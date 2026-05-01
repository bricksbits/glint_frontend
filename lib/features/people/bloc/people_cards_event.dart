part of 'people_cards_bloc.dart';

@freezed
class PeopleCardsEvent with _$PeopleCardsEvent {
  const factory PeopleCardsEvent.started() = _Started;
  const factory PeopleCardsEvent.loading(bool isLoading) = _Loading;
  const factory PeopleCardsEvent.fetchNextCards() = _FetchNextCards;
  const factory PeopleCardsEvent.clearAndUpdateListFromDb() = _ClearAndUpdateListFromDb;
  const factory PeopleCardsEvent.onSuperLiked(String onUserId, String? onEventId) = _SuperLiked;
  const factory PeopleCardsEvent.onRightSwiped(String onUserId, String? onEventId) = _RightSwiped;
  const factory PeopleCardsEvent.onLeftSwiped(String onUserId, String? onEventId) = _LeftSwiped;
  const factory PeopleCardsEvent.onMatchMade(String onUserId) = _onMatchMade;
  const factory PeopleCardsEvent.shareProfile(String onUserId) = _shareProfile;
  const factory PeopleCardsEvent.emitNewState(PeopleCardsState newState) = _emitNewState;
  const factory PeopleCardsEvent.flushSwipeCards() = _flushSwipeCards;
  const factory PeopleCardsEvent.fetchInterestedUserForTheEvent(int? eventId) = _fetchInterestedUsersForEvent;
  const factory PeopleCardsEvent.onActionHappened(String passedId) = _OnActionHappened;
  const factory PeopleCardsEvent.emptyCardList() = _EmptyCardList;
  const factory PeopleCardsEvent.undo() = _UndoCard;
  const factory PeopleCardsEvent.appendProfilesFromDb() = _AppendProfilesFromDb;
  const factory PeopleCardsEvent.setupSwipeController(CardSwiperController controller) = _SetUpSwipeController;
}
