part of 'people_cards_bloc.dart';

@freezed
class PeopleCardsEvent with _$PeopleCardsEvent {
  const factory PeopleCardsEvent.started() = _Started;
  const factory PeopleCardsEvent.loading(bool isLoading) = _Loading;
  const factory PeopleCardsEvent.fetchNextCards(int page, int index) = _FetchNextCards;
  const factory PeopleCardsEvent.onSuperLiked(String onUserId) = _SuperLiked;
  const factory PeopleCardsEvent.onRightSwiped(String onUserId) = _RightSwiped;
  const factory PeopleCardsEvent.onLeftSwiped(String onUserId) = _LeftSwiped;
  const factory PeopleCardsEvent.onMatchMade(String onUserId) = _onMatchMade;
  const factory PeopleCardsEvent.shareProfile(String onUserId) = _shareProfile;
  const factory PeopleCardsEvent.emitNewState(PeopleCardsState newState) = _emitNewState;
  const factory PeopleCardsEvent.flushSwipeCards() = _flushSwipeCards;
  const factory PeopleCardsEvent.fetchInterestedUserForTheEvent(int? eventId) = _fetchInterestedUsersForEvent;
}
