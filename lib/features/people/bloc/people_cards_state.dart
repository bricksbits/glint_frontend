part of 'people_cards_bloc.dart';

@freezed
class PeopleCardsState with _$PeopleCardsState {
  const factory PeopleCardsState.ignite({
    @Default(true) bool isLoading,
    @Default([]) List<PeopleCardModel> cardList,
    @Default("") String error,
    @Default(1) int currentPaginatedIndex,
    @Default(0) int currentPaginatedPage,
    @Default(null) PeopleCardModel? lastSwipedProfile,
    @Default(null) PeopleCardModel? matchUpProfile,
  }) = _Ignite;
}
