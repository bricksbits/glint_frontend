import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:glint_frontend/di/injection.dart';
import 'package:glint_frontend/domain/application_logic/admin/get_all_interested_users_use_case.dart';
import 'package:glint_frontend/domain/application_logic/admin/get_all_ticket_bought_users_use_case.dart';
import 'package:glint_frontend/domain/business_logic/models/admin/event_interested_user_domain_model.dart';
import 'package:glint_frontend/domain/business_logic/models/admin/event_ticket_bought_domain_model.dart';
import 'package:glint_frontend/domain/business_logic/models/common/pagination_params.dart';

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
        // Reset pagination when arguments change (screen reopen).
        interestedUsers: [],
        ticketBoughtUsers: [],
        interestedOffset: 0,
        ticketBoughtOffset: 0,
        hasMoreInterested: true,
        hasMoreTicketBought: true,
      ),
    );
    fetchUsersList(eventId);
  }

  void emitNewState(TrackAdminEventState newState) {
    emit(newState);
  }

  Future<void> fetchInterestedUsers(int eventId) async {
    getInterestedUsersUseCase.perform(
      (interestedUsers) {
        final list = interestedUsers ?? [];
        emit(state.copyWith(
          interestedUsers: list,
          interestedUserCount: list.length.toString(),
          interestedOffset: list.length,
          // An empty first page means nothing more to fetch.
          hasMoreInterested: list.isNotEmpty,
        ));
      },
      (error) {
        print("Error: Failed to load Interested users : $error");
      },
      () {},
      EventPaginationParams(eventId: eventId, offset: 0),
    );
  }

  Future<void> fetchTicketBoughtUsers(int eventId) async {
    getTicketBoughtUsersUseCase.perform(
      (ticketBoughtUsers) {
        final list = ticketBoughtUsers ?? [];
        emit(state.copyWith(
          revenueGenerated: (list.length * 325).toString(),
          ticketBoughtUsers: list,
          ticketBoughtOffset: list.length,
          hasMoreTicketBought: list.isNotEmpty,
        ));
      },
      (error) {
        print("Error: Failed to load Tickets Bought users : $error");
      },
      () {},
      EventPaginationParams(eventId: eventId, offset: 0),
    );
  }

  /// Appends the next page of interested users. Guarded against duplicate
  /// triggers (isLoadingMoreInterested) and end-of-list (hasMoreInterested).
  Future<void> loadMoreInterestedUsers() async {
    final eventId = state.eventId;
    if (eventId == null) return;
    if (state.isLoadingMoreInterested || !state.hasMoreInterested) return;

    emit(state.copyWith(isLoadingMoreInterested: true));

    getInterestedUsersUseCase.perform(
      (interestedUsers) {
        final incoming = interestedUsers ?? [];
        final merged = [...state.interestedUsers, ...incoming];
        emit(state.copyWith(
          interestedUsers: merged,
          interestedUserCount: merged.length.toString(),
          interestedOffset: merged.length,
          isLoadingMoreInterested: false,
          // Empty response from the server marks the end of the list.
          hasMoreInterested: incoming.isNotEmpty,
        ));
      },
      (error) {
        print("Error: Failed to load more Interested users : $error");
        emit(state.copyWith(isLoadingMoreInterested: false));
      },
      () {},
      EventPaginationParams(
        eventId: eventId,
        offset: state.interestedOffset,
      ),
    );
  }

  /// Appends the next page of ticket-bought users.
  Future<void> loadMoreTicketBoughtUsers() async {
    final eventId = state.eventId;
    if (eventId == null) return;
    if (state.isLoadingMoreTicketBought || !state.hasMoreTicketBought) return;

    emit(state.copyWith(isLoadingMoreTicketBought: true));

    getTicketBoughtUsersUseCase.perform(
      (ticketBoughtUsers) {
        final incoming = ticketBoughtUsers ?? [];
        final merged = [...state.ticketBoughtUsers, ...incoming];
        emit(state.copyWith(
          ticketBoughtUsers: merged,
          revenueGenerated: (merged.length * 325).toString(),
          ticketBoughtOffset: merged.length,
          isLoadingMoreTicketBought: false,
          hasMoreTicketBought: incoming.isNotEmpty,
        ));
      },
      (error) {
        print("Error: Failed to load more Tickets Bought users : $error");
        emit(state.copyWith(isLoadingMoreTicketBought: false));
      },
      () {},
      EventPaginationParams(
        eventId: eventId,
        offset: state.ticketBoughtOffset,
      ),
    );
  }

  Future<void> fetchUsersList(int eventId) async {
    await Future.wait(
        [fetchTicketBoughtUsers(eventId), fetchInterestedUsers(eventId)]);
    emitNewState(state.copyWith(isLoading: false));
  }
}
