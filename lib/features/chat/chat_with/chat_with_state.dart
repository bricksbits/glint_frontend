part of 'chat_with_cubit.dart';

@freezed
class ChatWithState with _$ChatWithState {
  const factory ChatWithState.initial({
    @Default(true) bool isLoading,
    @Default(false) bool hasError,
    @Default(null) String? error,
    @Default(false) bool chatAvailable,
    @Default(null) User? oppositeUserDetails,
    @Default(null) User? currentUserDetails,
    @Default(null) ChatWithNavArguments? chatNavArgs,
    @Default(null) Channel? currentChannel,
  }) = _Initial;
}

enum MediaMessageViewType {
  Photo,
  Viewed,
}

const oneTimeViewKey = "one_time_view";
const viewedKey = "viewed";
