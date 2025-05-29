part of 'super_admin_dashboard_bloc.dart';

@freezed
class SuperAdminDashboardEvent with _$SuperAdminDashboardEvent {
  const factory SuperAdminDashboardEvent.fetch() = _Fetch;
  const factory SuperAdminDashboardEvent.approveEvent(String eventId) = _ApproveEvent;
  const factory SuperAdminDashboardEvent.rejectEvent(String eventId) = _RejectEvent;
  const factory SuperAdminDashboardEvent.selectLive() = _SelectLive;
  const factory SuperAdminDashboardEvent.selectRequests() = selectRequests;
  const factory SuperAdminDashboardEvent.updateList() = _UpdateList;
}
