import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:glint_frontend/di/injection.dart';
import 'package:glint_frontend/domain/application_logic/admin/get_all_interested_users_use_case.dart';
import 'package:glint_frontend/domain/application_logic/admin/get_all_ticket_bought_users_use_case.dart';
import 'package:glint_frontend/domain/business_logic/models/admin/event_interested_user_domain_model.dart';
import 'package:glint_frontend/domain/business_logic/models/admin/event_ticket_bought_domain_model.dart';

part 'track_admin_event_state.dart';

part 'track_admin_event_cubit.freezed.dart';

class TrackAdminEventCubit extends Cubit<TrackAdminEventState> {
  TrackAdminEventCubit() : super(const TrackAdminEventState.trackEventState());

  final getInterestedUsersUseCase = getIt.get<GetAllInterestedUsersUseCase>();
  final getTicketBoughtUsersUseCase =
      getIt.get<GetAllTicketBoughtUsersUseCase>();

  void collectTheArguments(
    int eventId,
    String eventTitle,
    String eventDate,
  ) {
    emit(
      state.copyWith(
        eventId: eventId,
        eventDate: eventDate,
        eventTitle: eventTitle,
        isLoading: true,
      ),
    );
    fetchUsersList(eventId);
  }

  void emitNewState(TrackAdminEventState newState) {
    emit(newState);
  }

  Future<void> fetchInterestedUsers(int eventId) async {
    getInterestedUsersUseCase.perform((interestedUsers) {
      if (interestedUsers != null && interestedUsers.isNotEmpty) {
        emit(state.copyWith(
            interestedUsers: interestedUsers,
            interestedUserCount: interestedUsers.length.toString()));
      }
    }, (error) {
      print("Error: Failed to load Interested users : $error");
    }, () {}, eventId);
  }

  Future<void> fetchTicketBoughtUsers(int eventId) async {
    getTicketBoughtUsersUseCase.perform((ticketBoughtUsers) {
      if (ticketBoughtUsers != null && ticketBoughtUsers.isNotEmpty) {
        emit(state.copyWith(
          revenueGenerated: (ticketBoughtUsers.length * 325).toString(),
          ticketBoughtUsers: ticketBoughtUsers,
        ));
      }
    }, (error) {
      print("Error: Failed to load Tickets Bought users : $error");
    }, () {}, eventId);
  }

  Future<void> fetchUsersList(int eventId) async {
    var results = await Future.wait(
        [fetchTicketBoughtUsers(eventId), fetchInterestedUsers(eventId)]);
    emitNewState(state.copyWith(isLoading: false));
  }
}
