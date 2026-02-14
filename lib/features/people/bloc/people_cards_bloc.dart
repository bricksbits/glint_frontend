import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:glint_frontend/analytics/glint_analytics_events.dart';
import 'package:glint_frontend/analytics/glint_analytics_service.dart';
import 'package:glint_frontend/data/local/db/entities/swipe_action_entity.dart';
import 'package:glint_frontend/domain/business_logic/repo/event/events_repo.dart';
import 'package:glint_frontend/services/swipe_cache_manager.dart';
import 'package:glint_frontend/di/injection.dart';
import 'package:glint_frontend/domain/business_logic/models/common/swipe_action_type.dart';
import 'package:glint_frontend/domain/business_logic/repo/people/people_repo.dart';
import 'package:glint_frontend/features/people/model/people_card_model.dart';
import 'package:glint_frontend/utils/result_sealed.dart';
import 'package:glint_frontend/utils/user_info/user_info_manager_cubit.dart';

part 'people_cards_event.dart';

part 'people_cards_state.dart';

part 'people_cards_bloc.freezed.dart';

class PeopleCardsBloc extends Bloc<PeopleCardsEvent, PeopleCardsState> {
  final PeopleRepo peopleRepo = getIt.get<PeopleRepo>();
  final EventRepo eventRepo = getIt.get<EventRepo>();
  final UserInfoManagerCubit userInfoManagerCubit =
      getIt.get<UserInfoManagerCubit>();
  final SwipeBufferManager swipeBufferManager = getIt.get<SwipeBufferManager>();

  PeopleCardsBloc() : super(const PeopleCardsState()) {
    on<_SetUpSwipeController>((event, emit) {
      emit(
        state.copyWith(cardSwipeController: event.controller),
      );
    });

    on<_Started>((event, emit) async {
      final userId = await peopleRepo.getUserId();
      emit(state.copyWith(userId: userId, isLoading: true));
      await _validateCacheOrFetch(emit);
    });

    on<_fetchInterestedUsersForEvent>((event, emit) async {
      emit(state.copyWith(
        isLoading: true,
        // error: null,
      ));
      final userId = await peopleRepo.getUserId();
      final result = await eventRepo.fetchInterestedProfiles(event.eventId);

      switch (result) {
        case Success<List<PeopleCardModel>>():
          emit(state.copyWith(
            // Full reset for event-specific stacks
            displayCards: result.data,
            currentIndex: 0,
            swipedHistoryCards: [],
            alreadySwipedIds: {},
            userId: userId,
            isLoading: false,
            // error: null,
          ));
        case Failure<List<PeopleCardModel>>():
          emit(state.copyWith(
            error: "Can't load profiles. Try again.",
            isLoading: false,
          ));
      }
    });

    // ────────────────────────────────────────────────────────────────────────
    // SWIPE ACTIONS
    // All three are identical in state logic — only the SwipeActionType differs.
    // ────────────────────────────────────────────────────────────────────────

    on<_RightSwiped>((event, emit) {
      _handleSwipe(emit, userId: event.onUserId, action: SwipeActionType.RIGHT);
    });

    on<_LeftSwiped>((event, emit) {
      _handleSwipe(emit, userId: event.onUserId, action: SwipeActionType.LEFT);
    });

    on<_SuperLiked>((event, emit) {
      _handleSwipe(emit,
          userId: event.onUserId, action: SwipeActionType.SUPER_LIKE);
    });

    on<_UndoCard>((event, emit) {
      if (!state.canUndo) {
        emit(state.copyWith(error: "Nothing left to undo."));
        return;
      }
      final history = [...state.swipedHistoryCards];
      history.removeLast();
      userInfoManagerCubit.rewindUsed();
      emit(state.copyWith(
        currentIndex: state.currentIndex - 1,
        swipedHistoryCards: history,
        error: null,
      ));
    });

    // ────────────────────────────────────────────────────────────────────────
    // PAGINATION
    // ────────────────────────────────────────────────────────────────────────

    on<_FetchNextCards>((event, emit) async {
      if (state.isFetchingMoreProfile || state.hasReachedEnd) return;

      final nextOffset = state.currentOffset + 5;
      emit(state.copyWith(isFetchingMoreProfile: true));

      final result = await peopleRepo.fetchProfiles(nextOffset);

      switch (result) {
        case Success<void>():
          emit(state.copyWith(currentOffset: nextOffset));
          add(const PeopleCardsEvent.appendProfilesFromDb());

        case Failure<void>():
          emit(state.copyWith(isFetchingMoreProfile: false));
      }
    });

    on<_AppendProfilesFromDb>((event, emit) async {
      final result = await peopleRepo.getProfilesFromDB();
      switch (result) {
        case Success<List<PeopleCardModel>>():
          final newUnique = result.data
              .where((p) =>
                  !state.alreadySwipedIds.contains(p.userId) &&
                  !state.displayCards.any((e) => e.userId == p.userId))
              .toList();

          if (newUnique.isEmpty) {
            emit(state.copyWith(
              isFetchingMoreProfile: false,
              hasReachedEnd: true,
            ));
            return;
          }

          emit(state.copyWith(
            displayCards: [...state.displayCards, ...newUnique],
            isLoading: false,
            isFetchingMoreProfile: false,
          ));

        case Failure<List<PeopleCardModel>>():
          emit(state.copyWith(
            error: result.error.toString(),
            isLoading: false,
            isFetchingMoreProfile: false,
          ));
      }
    });
  }

  void _handleSwipe(
    Emitter<PeopleCardsState> emit, {
    required String userId,
    required SwipeActionType action,
  }) {
    if (state.currentIndex >= state.displayCards.length) return;

    final swipedCard = state.displayCards[state.currentIndex];

    assert(
      swipedCard.userId == userId,
      '[PeopleCardsBloc] Swipe mismatch: '
      'expected ${swipedCard.userId}, got $userId. '
      'This means the UI index and Bloc index are out of sync.',
    );

    final updatedHistory = [
      ...state.swipedHistoryCards,
      swipedCard,
    ];
    if (updatedHistory.length > kMaxUndoDepth) {
      updatedHistory.removeAt(0); // Evict oldest
    }

    final newActiveIndex = state.currentIndex + 1;
    emit(state.copyWith(
      currentIndex: newActiveIndex,
      swipedHistoryCards: updatedHistory,
      alreadySwipedIds: {...state.alreadySwipedIds, swipedCard.userId},
      // error: null,
    ));

    swipeBufferManager.bufferSwipe(SwipeActionEntity(
      currentUserId: state.userId.toString(),
      swipedOnUserId: userId,
      action: action,
      timestamp: DateTime.now(),
    ));

    // ── Pagination trigger ──────────────────────────────────────────────────
    // After the emit above, remainingCards has already decremented.
    // "2 or fewer remaining" is your chosen threshold.
    final newCalculatedRemaining = state.displayCards.length - newActiveIndex;
    if (newCalculatedRemaining <= 2 && !state.isFetchingMoreProfile) {
      add(const PeopleCardsEvent.fetchNextCards());
    }
  }

  /// Called on startup. Uses local cache if warm enough, otherwise fetches.
  Future<void> _validateCacheOrFetch(Emitter<PeopleCardsState> emit) async {
    final result = await peopleRepo.getProfilesFromDB();

    switch (result) {
      case Success<List<PeopleCardModel>>():
        if (result.data.length < 2) {
          await peopleRepo.fetchProfiles(state.currentOffset);
        }
        add(const PeopleCardsEvent.appendProfilesFromDb());

      case Failure<List<PeopleCardModel>>():
        emit(state.copyWith(
          error: result.error.toString(),
          isLoading: false,
          isFetchingMoreProfile: false,
        ));
    }
  }

  bool superLikeUser(String userId) {
    final isSuperLikesAvailable = userInfoManagerCubit.superLikeClicked();
    GlintAnalyticService.onCardActionEvent(
      GlintSwipeGestureAnalyticsEvents.SUPER,
      isSuperLikesAvailable,
    );

    if (!isSuperLikesAvailable) {
      return false;
    }

    userInfoManagerCubit.superLikedUsed();
    add(PeopleCardsEvent.onSuperLiked(userId));
    state.cardSwipeController?.swipe(
      CardSwiperDirection.top,
    );

    return true;
  }

  void rewindUsingSwipeController() {
    final isRewindAvailable =
        userInfoManagerCubit.isRewindFunctionalityAvailable();
    GlintAnalyticService.onRewindEvent(isRewindAvailable);

    if (!isRewindAvailable) {
      return;
    }
    state.cardSwipeController?.undo();
  }
}
