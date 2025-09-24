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

  StreamSubscription<Result<List<PeopleCardModel>>>? _peopleCardStream;

  PeopleCardsBloc() : super(const PeopleCardsState.ignite()) {
    List<String?> advertisementList = [];
    List<PeopleCardModel> cardsList = [];

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
      // final adsList = await peopleRepo.fetchAds();
      // Fetch Cards
      await peopleRepo.fetchProfiles();

      _peopleCardStream = peopleRepo.getProfilesFromDB().listen((newList) {
        switch (newList) {
          case Success<List<PeopleCardModel>>():
            if (newList.data.isNotEmpty) {
              cardsList.addAll(newList.data);
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
            }
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
      }, onError: (streamError) {
        add(
          PeopleCardsEvent.emitNewState(
            state.copyWith(
                error: "can't load more profiles. Try again", isLoading: false),
          ),
        );
      });
    });

    on<_Loading>((event, emit) async {
      final currentLoadingState = state.isLoading;
      emit(state.copyWith(isLoading: currentLoadingState));
    });

    on<_FetchNextCards>((event, emit) async {
      final passedIndex = event.index;
      final passedPage = event.page;
    });

    on<_RightSwiped>((event, emit) async {
      final passedId = event.onUserId;
      final currentUserId = state.userId;
      swipeBufferManager.bufferSwipe(SwipeActionEntity(
        collabId: int.parse(currentUserId) + int.parse(passedId),
        currentUserId: currentUserId.toString(),
        swipedOnUserId: passedId,
        action: SwipeActionType.RIGHT,
        timestamp: DateTime.now(),
      ));
    });

    on<_LeftSwiped>((event, emit) async {
      final passedId = event.onUserId;
      final currentUserId = state.userId;
      swipeBufferManager.bufferSwipe(SwipeActionEntity(
        collabId: int.parse(currentUserId) + int.parse(passedId),
        currentUserId: currentUserId.toString(),
        swipedOnUserId: passedId,
        action: SwipeActionType.LEFT,
        timestamp: DateTime.now(),
      ));
    });

    on<_SuperLiked>((event, emit) async {
      final passedId = event.onUserId;
      final currentUserId = state.userId;
      swipeBufferManager.bufferSwipe(SwipeActionEntity(
        collabId: int.parse(currentUserId) + int.parse(passedId),
        currentUserId: currentUserId.toString(),
        swipedOnUserId: passedId,
        action: SwipeActionType.SUPER_LIKE,
        timestamp: DateTime.now(),
      ));
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

    on<_emitNewState>((event, emit) {
      final passedItem = event.newState;
      emit(passedItem);
    });
  }

  @override
  Future<void> close() {
    _peopleCardStream?.cancel();
    return super.close();
  }
}
