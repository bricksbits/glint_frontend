part of 'people_cards_bloc.dart';

@freezed
class PeopleCardsState with _$PeopleCardsState {
  const factory PeopleCardsState.ignite({
    @Default(true) bool isLoading,
    @Default([]) List<PeopleUiModel> cardList,
    @Default("") String error,
    @Default(1) int currentPaginatedIndex,
    @Default(0) int currentPaginatedPage,
    @Default(null) PeopleUiModel? lastSwipedProfile,
    @Default(null) PeopleUiModel? matchUpProfile,
  }) = _Ignite;
}
