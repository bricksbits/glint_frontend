part of 'people_cards_bloc.dart';

enum PeopleScreenType { discover, interestedInEvent }

@freezed
class PeopleCardsState with _$PeopleCardsState {
  const factory PeopleCardsState({
    @Default(true) bool isLoading,
    @Default(false) bool isFetchingMoreProfile,
    @Default([]) List<PeopleCardModel> displayCards,
    @Default("") String userId,
    @Default(null) String? error,
    @Default(0) int currentOffset,
    @Default([]) List<PeopleCardModel> swipedHistoryCards,
    @Default(null) CardSwiperController? cardSwipeController,
    @Default({}) Set<String> alreadySwipedIds,
    @Default(0) int lastActionWasUndo,
    @Default(0) int currentIndex,
    @Default(false) bool hasReachedEnd,
    @Default(PeopleScreenType.discover) PeopleScreenType screenType,
    int? activeEventId,
  }) = _PeopleCardState;

  const PeopleCardsState._();

  /// Cards the user hasn't seen yet.
  int get remainingCards => displayCards.length - currentIndex;

  /// Whether undo is available.
  bool get canUndo => swipedHistoryCards.isNotEmpty && currentIndex > 0;
}

const int kMaxUndoDepth = 3;
