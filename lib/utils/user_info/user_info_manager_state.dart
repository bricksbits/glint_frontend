part of 'user_info_manager_cubit.dart';

@freezed
class UserInfoManagerState with _$UserInfoManagerState {
  const factory UserInfoManagerState.initial({
    @Default(null) String? fcmToken,
    @Default(null) ProfileMembershipEntity? membershipEntity,
    @Default(null) String? error,
}) = _Initial;
}
