part of 'admin_recent_event_bloc.dart';

@freezed
class AdminRecentEventState with _$AdminRecentEventState {
  const factory AdminRecentEventState.initial({
    @Default(true) bool loading,
    @Default([]) List<String> allPublishedEvents,
  }) = _Initial;
}
