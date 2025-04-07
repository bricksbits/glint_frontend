part of 'super_admin_dashboard_bloc.dart';

@freezed
class SuperAdminDashboardState with _$SuperAdminDashboardState {
  const factory SuperAdminDashboardState.initial() = _Initial;

  const factory SuperAdminDashboardState.loading() = _Loading;

  const factory SuperAdminDashboardState.error(String error) = _Error;

  const factory SuperAdminDashboardState.live(List<String> liveEvents) =
      _LiveEvents;

  const factory SuperAdminDashboardState.requests(List<String> requestsEvents) =
      _RequestsEvents;
}
