part of 'settings_cubit.dart';

@freezed
class SettingsState with _$SettingsState {
  const factory SettingsState({
    @Default(true) bool isNotificationsEnabled,
    @Default(true) bool isMatchesEnabled,
    @Default(true) bool isEventsEnabled,
    @Default(true) bool isTicketsEnabled,
    @Default(true) bool isRemindersEnabled,
    @Default('') String appVersion,
    @Default(false) bool isLoading,
  }) = _SettingsState;
}
