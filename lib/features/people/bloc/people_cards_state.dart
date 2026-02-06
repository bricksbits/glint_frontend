part of 'people_cards_bloc.dart';

@freezed
class PeopleCardsState with _$PeopleCardsState {
  const factory PeopleCardsState.ignite({
    @Default(true) bool isLoading,
    @Default(false) bool isFetchingMoreProfile,
    @Default([]) List<PeopleCardModel> displayCards,
    @Default("") String userId,
    @Default("") String error,
    @Default(0) int currentOffset,
    @Default([]) List<PeopleCardModel> swipedHistoryCards,
    @Default(null) CardSwiperController? cardSwipeController,
    @Default({}) Set<String> alreadySwipedIds,
    @Default(0) int lastActionWasUndo,
  }) = _Ignite;
}
