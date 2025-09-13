import 'dart:async';

import 'package:bloc/bloc.dart';
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
    List<PeopleCardModel> alreadyActionItem = [];

    on<_fetchInterestedUsersForEvent>(
      (event, emit) async {
        var userId = await peopleRepo.getUserId();
        var profileResult =
            await eventRepo.fetchInterestedProfiles(event.eventId);
        switch (profileResult) {
          case Success<List<PeopleCardModel>>():
            cardsList.addAll(profileResult.data);
            add(
              PeopleCardsEvent.emitNewState(
                state.copyWith(
                  cardList: cardsList,
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

    on<_Started>((event, emit) async {
      var userId = await peopleRepo.getUserId();
      add(PeopleCardsEvent.emitNewState(
        state.copyWith(
          userId: userId,
          isLoading: true,
          isFetchingMoreProfile: true,
        ),
      ));
      await peopleRepo.fetchProfiles(state.currentOffset);
      add(const _ClearAndUpdateListFromDb());
    });

    on<_ClearAndUpdateListFromDb>((event, emit) async {
      final newUiModelsResult = await peopleRepo.getProfilesFromDB();
      switch (newUiModelsResult) {
        case Success<List<PeopleCardModel>>():
          add(PeopleCardsEvent.emitNewState(
            state.copyWith(
              cardList: newUiModelsResult.data,
              isLoading: false,
              isFetchingMoreProfile: false,
            ),
          ));
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

    //todo: When Fetching profiles fails, update the UI as well.
    on<_FetchNextCards>((event, emit) async {
      add(
        _emitNewState(
          state.copyWith(
              isFetchingMoreProfile: true, cardList: [], isLoading: false),
        ),
      );
      final passedCurrentOffset = event.currentOffset;
      await peopleRepo.fetchProfiles(passedCurrentOffset);
      add(const _ClearAndUpdateListFromDb());
    });

    on<_RightSwiped>((event, emit) async {
      final passedId = event.onUserId;
      final currentUserId = state.userId;
      add(const _EmptyCardList());
      swipeBufferManager.bufferSwipe(SwipeActionEntity(
        collabId: int.parse(currentUserId) + int.parse(passedId),
        currentUserId: currentUserId.toString(),
        swipedOnUserId: passedId,
        action: SwipeActionType.RIGHT,
        timestamp: DateTime.now(),
      ));

      add(_OnActionHappened(passedId));
    });

    on<_LeftSwiped>((event, emit) async {
      final passedId = event.onUserId;
      final currentUserId = state.userId;
      add(const _EmptyCardList());
      swipeBufferManager.bufferSwipe(SwipeActionEntity(
        collabId: int.parse(currentUserId) + int.parse(passedId),
        currentUserId: currentUserId.toString(),
        swipedOnUserId: passedId,
        action: SwipeActionType.LEFT,
        timestamp: DateTime.now(),
      ));

      add(_OnActionHappened(passedId));
    });

    on<_SuperLiked>((event, emit) async {
      final passedId = event.onUserId;
      final currentUserId = state.userId;
      add(const _EmptyCardList());
      swipeBufferManager.bufferSwipe(SwipeActionEntity(
        collabId: int.parse(currentUserId) + int.parse(passedId),
        currentUserId: currentUserId.toString(),
        swipedOnUserId: passedId,
        action: SwipeActionType.SUPER_LIKE,
        timestamp: DateTime.now(),
      ));

      add(_OnActionHappened(passedId));
    });

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

    on<_OnActionHappened>((event, emit) {
      final actionItem = state.cardList
          .where((profile) => profile.userId == event.passedId)
          .toList()
          .first;

      alreadyActionItem.add(actionItem);
      add(PeopleCardsEvent.emitNewState(
        state.copyWith(
          lastSwipedProfile: actionItem,
        ),
      ));
      if (alreadyActionItem.length >= 5) {
        final currentOffset = state.currentOffset;
        final nextOffset = currentOffset + 5;
        add(_emitNewState(state.copyWith(currentOffset: nextOffset)));
        alreadyActionItem.clear();
        add(_FetchNextCards(nextOffset));
      }
    });

    on<_EmptyCardList>((event, emit) async {
      add(
        _emitNewState(
          state.copyWith(
            cardList: [],
          ),
        ),
      );
    });

    on<_emitNewState>((event, emit) {
      final passedItem = event.newState;
      emit(passedItem);
    });
  }
}
