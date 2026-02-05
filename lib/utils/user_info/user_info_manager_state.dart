part of 'user_info_manager_cubit.dart';

@freezed
class UserInfoManagerState with _$UserInfoManagerState {
  const factory UserInfoManagerState.initial({
    @Default(null) String? fcmToken,
    @Default(null) ProfileMembershipEntity? membershipEntity,
    @Default(null) String? error,
    @Default(false) bool isPremiumUser,
    @Default(false) bool isLoading,
    @Default(null) String? currentChatChannelId,
    @Default(null) String? superDmUsedOnUserId,
    @Default(null) String? superDmMessage,
}) = _Initial;
}
