part of 'notification_cubit.dart';

@freezed
class NotificationState with _$NotificationState {
  const factory NotificationState.initial({
    @Default(false) bool isLoading,
    @Default('') String error,
    @Default([]) List<NotificationGroup> notificationGroups,
  }) = _Initial;
}
