part of 'super_admin_dashboard_bloc.dart';

@freezed
class SuperAdminDashboardState with _$SuperAdminDashboardState {
  const factory SuperAdminDashboardState({
    @Default(false) bool isLoading,
    String? errorMessage,
    @Default(EventDisplayType.live) EventDisplayType currentTab,
    @Default([]) List<AdminEventListDomainModel> liveEvents,
    @Default([]) List<AdminEventListDomainModel> requestEvents,
    @Default([]) List<AdminEventListDomainModel> currentSelectedList,
  }) = _SuperAdminDashboardState;
}
