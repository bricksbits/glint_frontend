part of 'chat_screen_cubit.dart';

@freezed
class ChatScreenState with _$ChatScreenState {
  const factory ChatScreenState.initial({
    @Default(false) bool isLoading,
    @Default(false) bool isChatReady,
    @Default("") String error,

    // For Recent Matches
    @Default(null) List<RecentMatchesModel>? recentMatches,
    @Default(null) StreamChannelListController? channelListController,

    // For Stories
    @Default(null) List<ViewStoryModel>? stories,
    @Default(null) int? selectedIndex,
  }) = _Initial;
}
