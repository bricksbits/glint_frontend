part of 'admin_dashboard_bloc.dart';

@freezed
class AdminDashboardEvent with _$AdminDashboardEvent {
  const factory AdminDashboardEvent.started() = _Started;

  const factory AdminDashboardEvent.trackEventWithId(String id) =
      _TrackEventWithId;

  const factory AdminDashboardEvent.emitNewState(AdminDashboardState newState) =
  _EmitNewState;
}
