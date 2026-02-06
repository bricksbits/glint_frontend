import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:glint_frontend/data/local/db/entities/swipe_action_entity.dart';
import 'package:glint_frontend/domain/business_logic/repo/event/events_repo.dart';
import 'package:glint_frontend/services/swipe_cache_manager.dart';
import 'package:glint_frontend/di/injection.dart';
import 'package:glint_frontend/domain/business_logic/models/common/swipe_action_type.dart';
import 'package:glint_frontend/domain/business_logic/repo/people/people_repo.dart';
import 'package:glint_frontend/features/people/model/people_card_model.dart';
import 'package:glint_frontend/utils/result_sealed.dart';

part 'people_cards_event.dart';

part 'people_cards_state.dart';

part 'people_cards_bloc.freezed.dart';

class PeopleCardsBloc extends Bloc<PeopleCardsEvent, PeopleCardsState> {
  final PeopleRepo peopleRepo = getIt.get<PeopleRepo>();
  final EventRepo eventRepo = getIt.get<EventRepo>();
  final SwipeBufferManager swipeBufferManager = getIt.get<SwipeBufferManager>();

  PeopleCardsBloc() : super(const PeopleCardsState.ignite()) {
    on<_Started>((event, emit) async {
      var userId = await peopleRepo.getUserId();
      add(PeopleCardsEvent.emitNewState(
        state.copyWith(
          userId: userId,
          isLoading: true,
          isFetchingMoreProfile: true,
        ),
      ));
      _validateTheCacheProfilesOrFetchMore();
    });

    on<_ClearAndUpdateListFromDb>((event, emit) async {
      final newUiModelsResult = await peopleRepo.getProfilesFromDB();
      switch (newUiModelsResult) {
        case Success<List<PeopleCardModel>>():
          // A mechanism to avoid repeating Cards,
          final newUniqueProfiles = newUiModelsResult.data.where((profile) {
            bool isAlreadyInList =
                state.displayCards.any((e) => e.userId == profile.userId);
            bool wasSwiped = state.alreadySwipedIds.contains(profile.userId);
            return !isAlreadyInList && !wasSwiped;
          }).toList();

          if (newUniqueProfiles.isNotEmpty) {
            add(PeopleCardsEvent.emitNewState(
              state.copyWith(
                displayCards: [
                  ...state.displayCards,
                  ...newUniqueProfiles,
                ],
                isLoading: false,
                isFetchingMoreProfile: false,
              ),
            ));
          }
        case Failure<List<PeopleCardModel>>():
          add(PeopleCardsEvent.emitNewState(
            state.copyWith(
              error: "${newUiModelsResult.error}",
              isLoading: false,
              isFetchingMoreProfile: false,
            ),
          ));
      }
    });

    on<_Loading>((event, emit) async {
      final currentLoadingState = state.isLoading;
      emit(state.copyWith(isLoading: currentLoadingState));
    });

    on<_FetchNextCards>((event, emit) async {
      final nextOffset = state.currentOffset + 5;
      final moreProfileResult = await peopleRepo.fetchProfiles(nextOffset);
      switch (moreProfileResult) {
        case Success<void>():
          add(
            _emitNewState(
              state.copyWith(
                currentOffset: nextOffset,
                isFetchingMoreProfile: true,
                isLoading: false,
              ),
            ),
          );
          add(const _ClearAndUpdateListFromDb());
          break;
        case Failure<void>():
          add(
            _emitNewState(
              state.copyWith(
                currentOffset: state.currentOffset,
                isFetchingMoreProfile: false,
                isLoading: false,
              ),
            ),
          );
          break;
      }
    });

    on<_RightSwiped>((event, emit) async {
      final passedId = event.onUserId;
      final currentUserId = state.userId;

      add(_OnActionHappened(passedId));

      swipeBufferManager.bufferSwipe(
        SwipeActionEntity(
          currentUserId: currentUserId.toString(),
          swipedOnUserId: passedId,
          action: SwipeActionType.RIGHT,
          timestamp: DateTime.now(),
        ),
      );
    });

    on<_LeftSwiped>((event, emit) async {
      final passedId = event.onUserId;
      final currentUserId = state.userId;

      add(_OnActionHappened(passedId));

      swipeBufferManager.bufferSwipe(
        SwipeActionEntity(
          currentUserId: currentUserId.toString(),
          swipedOnUserId: passedId,
          action: SwipeActionType.LEFT,
          timestamp: DateTime.now(),
        ),
      );
    });

    on<_SuperLiked>((event, emit) async {
      final passedId = event.onUserId;
      final currentUserId = state.userId;

      add(_OnActionHappened(passedId));

      swipeBufferManager.bufferSwipe(
        SwipeActionEntity(
          currentUserId: currentUserId.toString(),
          swipedOnUserId: passedId,
          action: SwipeActionType.SUPER_LIKE,
          timestamp: DateTime.now(),
        ),
      );
    });

    on<_UndoCard>((event, emit) {
      final currentHistoryList = [...state.swipedHistoryCards];
      final currentDisplayCards = [...state.displayCards];
      final swipeIdSet = {...state.alreadySwipedIds};

      if (currentHistoryList.isEmpty) {
        add(PeopleCardsEvent.emitNewState(
            state.copyWith(error: "You haven't Swiped left anyone yet")));
        return;
      }

      final userToRestore = currentHistoryList.removeLast();
      final updatedSwipeIds = swipeIdSet.remove(userToRestore.userId);
      currentDisplayCards.insert(0, userToRestore);
      add(
        PeopleCardsEvent.emitNewState(
          state.copyWith(
            displayCards: currentDisplayCards,
            swipedHistoryCards: currentHistoryList,
            alreadySwipedIds: swipeIdSet,
            lastActionWasUndo: DateTime.now().millisecondsSinceEpoch,
          ),
        ),
      );
      return;
    });

    on<_OnActionHappened>((event, emit) {
      final lastActionUser = state.displayCards
          .where((profile) => profile.userId == event.passedId)
          .toList()
          .first;

      final alreadySwipedUserIdSet = state.alreadySwipedIds;

      final historyUntilNow = state.swipedHistoryCards;

      add(
        PeopleCardsEvent.emitNewState(
          state.copyWith(
            swipedHistoryCards: [...historyUntilNow, lastActionUser],
            alreadySwipedIds: {
              ...alreadySwipedUserIdSet,
              lastActionUser.userId
            },
          ),
        ),
      );
    });

    on<_EmptyCardList>((event, emit) async {
      add(
        PeopleCardsEvent.emitNewState(
          state.copyWith(
            displayCards: [],
          ),
        ),
      );
    });

    on<_emitNewState>((event, emit) {
      final passedItem = event.newState;
      emit(passedItem);
    });

    on<_fetchInterestedUsersForEvent>(
      (event, emit) async {
        var userId = await peopleRepo.getUserId();
        var profileResult =
            await eventRepo.fetchInterestedProfiles(event.eventId);
        switch (profileResult) {
          case Success<List<PeopleCardModel>>():
            add(
              PeopleCardsEvent.emitNewState(
                state.copyWith(
                  displayCards: profileResult.data,
                  error: "",
                  isLoading: false,
                  userId: userId,
                ),
              ),
            );
          case Failure<List<PeopleCardModel>>():
            add(
              PeopleCardsEvent.emitNewState(
                state.copyWith(
                  error: "can't load more profiles. Try again",
                  isLoading: false,
                ),
              ),
            );
        }
      },
    );

    on<_onMatchMade>((event, emit) async {
      final passedId = event.onUserId;

      /// Check if the return response have the currentUserId
      /// IF available showcase a new screen
      /// Update the state to navigate to new screen
    });

    on<_shareProfile>((event, emit) async {
      final passedId = event.onUserId;

      /// Already have the Id, create a dynamic link
      /// And fetch the users details.
    });
  }

  Future<void> _validateTheCacheProfilesOrFetchMore() async {
    final newUiModelsResult = await peopleRepo.getProfilesFromDB();
    switch (newUiModelsResult) {
      case Success<List<PeopleCardModel>>():
        final cacheItems = newUiModelsResult.data;
        if (cacheItems.length < 3) {
          await peopleRepo.fetchProfiles(state.currentOffset);
          add(const PeopleCardsEvent.clearAndUpdateListFromDb());
        } else {
          add(const PeopleCardsEvent.clearAndUpdateListFromDb());
        }
        break;
      case Failure<List<PeopleCardModel>>():
        add(PeopleCardsEvent.emitNewState(
          state.copyWith(
            error: "${newUiModelsResult.error}",
            isLoading: false,
            isFetchingMoreProfile: false,
          ),
        ));
        break;
    }
  }

  void setCardController(CardSwiperController passedController) {
    add(
      PeopleCardsEvent.emitNewState(
        state.copyWith(cardSwipeController: passedController),
      ),
    );
  }

  void undo() {
    state.cardSwipeController?.undo();
  }
}
