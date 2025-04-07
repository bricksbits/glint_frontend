import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'admin_dashboard_event.dart';
part 'admin_dashboard_state.dart';
part 'admin_dashboard_bloc.freezed.dart';

class AdminDashboardBloc extends Bloc<AdminDashboardEvent, AdminDashboardState> {
  AdminDashboardBloc() : super(const AdminDashboardState.initial()) {
    on<AdminDashboardEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
