part of 'chat_screen_cubit.dart';

@freezed
class ChatScreenState with _$ChatScreenState {
  const factory ChatScreenState.initial({
    @Default(false) bool isLoading,
    @Default("") String error,

    // For Recent Matches
    @Default(null) List<RecentMatchesModel>? recentMatches,
  }) = _Initial;
}
//Todo: Remove the Stories or put them in the last, which are already viewed
