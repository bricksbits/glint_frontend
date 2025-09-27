part of 'view_story_cubit.dart';

@freezed
class ViewStoryState with _$ViewStoryState {
  const factory ViewStoryState.initial({
    @Default(false) bool isLoading,
    @Default("") String error,
    // For Stories
    @Default([]) List<ViewStoryModel>? stories,
    @Default(null) int? selectedIndex,

}) = _Initial;
}
