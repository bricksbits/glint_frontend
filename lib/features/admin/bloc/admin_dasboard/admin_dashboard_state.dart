part of 'admin_dashboard_bloc.dart';

@freezed
class AdminDashboardState with _$AdminDashboardState {
  const factory AdminDashboardState.initial({
    @Default(false) bool isLoading,
    @Default([]) List<String> recentEvents,
    @Default("") String error,
  }) = _Initial;
}
