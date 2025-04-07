import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'admin_recent_event_event.dart';
part 'admin_recent_event_state.dart';
part 'admin_recent_event_bloc.freezed.dart';

class AdminRecentEventBloc extends Bloc<AdminRecentEventEvent, AdminRecentEventState> {
  AdminRecentEventBloc() : super(const AdminRecentEventState.initial()) {
    on<AdminRecentEventEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
