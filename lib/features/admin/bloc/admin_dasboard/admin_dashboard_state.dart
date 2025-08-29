part of 'admin_dashboard_bloc.dart';

@freezed
class AdminDashboardState with _$AdminDashboardState {
  const factory AdminDashboardState.initial({
    @Default(true) bool isLoading,
    @Default([]) List<AdminEventListDomainModel> recentEvents,
    @Default([]) List<AdminEventListDomainModel> allPublishedEvents,
    @Default("") String error,
    @Default("Event Manager") String adminUserName,
    @Default("For Organization") String adminOrganization,
    @Default(null) PeopleCardModel? currentUser,
  }) = _Initial;
}
