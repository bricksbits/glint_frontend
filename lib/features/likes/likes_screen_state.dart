part of 'likes_screen_cubit.dart';

@freezed
class LikesScreenState with _$LikesScreenState {
  const factory LikesScreenState.initial({
    @Default(false) bool isLoading,
    @Default("") String error,
    @Default(0) int profileViewCount,
    @Default([]) List<PeopleCardModel> topProfiles,
    @Default([]) List<PeopleCardModel> superLikeProfiles,
    @Default([]) List<PeopleCardModel> likeProfiles,
  }) = _Initial;
}
