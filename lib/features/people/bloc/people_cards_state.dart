part of 'people_cards_bloc.dart';

@freezed
class PeopleCardsState with _$PeopleCardsState {
  const factory PeopleCardsState.ignite({
    @Default(true) bool isLoading,
    @Default(false) bool isFetchingMoreProfile,
    @Default([]) List<PeopleCardModel> cardList,
    @Default("") String userId,
    @Default("") String error,
    @Default(0) int currentOffset,
    @Default(null) PeopleCardModel? lastSwipedProfile,
    @Default(null) PeopleCardModel? matchUpProfile,
    @Default({}) Set<String> alreadySwipedId,
  }) = _Ignite;
}
