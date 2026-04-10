import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:glint_frontend/data/local/persist/async_encrypted_shared_preference_helper.dart';
import 'package:glint_frontend/data/local/persist/shared_pref_key.dart';
import 'package:glint_frontend/utils/app_config.dart';
import 'package:package_info_plus/package_info_plus.dart';

part 'settings_state.dart';

part 'settings_cubit.freezed.dart';

class SettingsCubit extends Cubit<SettingsState> {
  final AsyncEncryptedSharedPreferenceHelper _prefs;

  SettingsCubit(this._prefs) : super(const SettingsState()) {
    _loadInitialState();
  }

  Future<void> _loadInitialState() async {
    emit(state.copyWith(isLoading: true));

    final packageInfo = await PackageInfo.fromPlatform();
    final appVersion =
        'v${packageInfo.version} (${packageInfo.buildNumber}) ${AppConfig.envType}';

    final matches =
        await _prefs.getBoolean(SharedPreferenceKeys.notifMatchesEnabledKey);
    final events =
        await _prefs.getBoolean(SharedPreferenceKeys.notifEventsEnabledKey);
    final tickets =
        await _prefs.getBoolean(SharedPreferenceKeys.notifTicketsEnabledKey);
    final reminders =
        await _prefs.getBoolean(SharedPreferenceKeys.notifRemindersEnabledKey);

    emit(state.copyWith(
      isLoading: false,
      appVersion: appVersion,
      isMatchesEnabled: matches,
      isEventsEnabled: events,
      isTicketsEnabled: tickets,
      isRemindersEnabled: reminders,
    ));
  }

  void toggleNotifications(bool value) {
    emit(state.copyWith(isNotificationsEnabled: value));
  }

  Future<void> toggleMatches(bool value) async {
    emit(state.copyWith(isMatchesEnabled: value));
    await _prefs.saveBoolean(SharedPreferenceKeys.notifMatchesEnabledKey, value);
  }

  Future<void> toggleEvents(bool value) async {
    emit(state.copyWith(isEventsEnabled: value));
    await _prefs.saveBoolean(SharedPreferenceKeys.notifEventsEnabledKey, value);
  }

  Future<void> toggleTickets(bool value) async {
    emit(state.copyWith(isTicketsEnabled: value));
    await _prefs.saveBoolean(SharedPreferenceKeys.notifTicketsEnabledKey, value);
  }

  Future<void> toggleReminders(bool value) async {
    emit(state.copyWith(isRemindersEnabled: value));
    await _prefs.saveBoolean(
        SharedPreferenceKeys.notifRemindersEnabledKey, value);
  }
}
