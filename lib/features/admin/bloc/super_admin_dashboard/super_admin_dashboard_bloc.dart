import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'super_admin_dashboard_event.dart';

part 'super_admin_dashboard_state.dart';

part 'super_admin_dashboard_bloc.freezed.dart';

class SuperAdminDashboardBloc
    extends Bloc<SuperAdminDashboardEvent, SuperAdminDashboardState> {
  SuperAdminDashboardBloc() : super(const SuperAdminDashboardState.initial()) {
    on<SuperAdminDashboardEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
