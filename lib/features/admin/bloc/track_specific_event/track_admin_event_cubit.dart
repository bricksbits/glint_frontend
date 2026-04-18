import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:glint_frontend/di/injection.dart';
import 'package:glint_frontend/domain/application_logic/admin/get_all_interested_users_use_case.dart';
import 'package:glint_frontend/domain/application_logic/admin/get_all_ticket_bought_users_use_case.dart';
import 'package:glint_frontend/domain/application_logic/admin/get_event_admin_stats_use_case.dart';
import 'package:glint_frontend/domain/application_logic/admin/toggle_pause_event_use_case.dart';
import 'package:glint_frontend/domain/business_logic/models/admin/event_interested_user_domain_model.dart';
import 'package:glint_frontend/domain/business_logic/models/admin/event_ticket_bought_domain_model.dart';
import 'package:glint_frontend/domain/business_logic/models/common/pagination_params.dart';
import 'package:glint_frontend/domain/business_logic/models/event/event_detail_domain.dart';
import 'package:glint_frontend/domain/business_logic/repo/event/events_repo.dart';
import 'package:glint_frontend/utils/result_sealed.dart';

part 'track_admin_event_state.dart';

part 'track_admin_event_cubit.freezed.dart';

class TrackAdminEventCubit extends Cubit<TrackAdminEventState> {
  TrackAdminEventCubit() : super(const TrackAdminEventState.trackEventState());

  final getInterestedUsersUseCase = getIt.get<GetAllInterestedUsersUseCase>();
  final getTicketBoughtUsersUseCase =
      getIt.get<GetAllTicketBoughtUsersUseCase>();
  final getEventAdminStatsUseCase = getIt.get<GetEventAdminStatsUseCase>();
  final togglePauseEventUseCase = getIt.get<TogglePauseEventUseCase>();
  final _eventRepo = getIt.get<EventRepo>();

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
    fetchEventHeader(eventId);
    fetchAdminStats(eventId);
  }

  void emitNewState(TrackAdminEventState newState) {
    emit(newState);
  }

  /// Populates the image / location / paused state from the event details API.
  Future<void> fetchEventHeader(int eventId) async {
    final response = await _eventRepo.getEventDetails(eventId);
    switch (response) {
      case Success<EventDetailsDomainModel>():
        final detail = response.data;
        final firstImage = detail.eventCoverImageUrl.isNotEmpty
            ? detail.eventCoverImageUrl.first
            : "";
        emit(state.copyWith(
          eventImageUrl: firstImage,
          eventLocation: detail.eventLocation,
          isPaused: detail.isPaused,
        ));
      case Failure<EventDetailsDomainModel>():
        print("Error: Failed to load event header: ${response.error}");
    }
  }

  /// Revenue + interested count come from the AdminStats endpoint — not from
  /// paginated list lengths, which only reflect the pages fetched so far.
  Future<void> fetchAdminStats(int eventId) async {
    getEventAdminStatsUseCase.perform(
      (stats) {
        if (stats == null) return;
        emit(state.copyWith(
          revenueGenerated: stats.totalRevenue,
          interestedUserCount: stats.interestedUsers.length.toString(),
        ));
      },
      (error) {
        print("Error: Failed to load admin stats: $error");
      },
      () {},
      eventId,
    );
  }

  Future<void> fetchInterestedUsers(int eventId) async {
    getInterestedUsersUseCase.perform(
      (interestedUsers) {
        final list = interestedUsers ?? [];
        emit(state.copyWith(
          interestedUsers: list,
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
          interestedOffset: merged.length,
          isLoadingMoreInterested: false,
          // Empty response from the server marks the end of the list.
          hasMoreInterested: incoming.isNotEmpty,
        ));
      },
      (error) {
        print("Error: Failed to load more Interested users : $error");
        emit(state.copyWith(
          isLoadingMoreInterested: false,
        ));
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

  /// Flips the paused state. Returns true on API success, false on failure —
  /// the UI layer uses that to pick which snackbar to show.
  Future<bool> togglePauseState() async {
    final eventId = state.eventId;
    if (eventId == null || state.isTogglingPause) return false;

    final shouldPause = !state.isPaused;
    emit(state.copyWith(isTogglingPause: true));

    final completer = Completer<bool>();
    togglePauseEventUseCase.perform(
      (success) => completer.complete(success ?? false),
      (error) {
        print("Error: Failed to toggle pause state: $error");
        completer.complete(false);
      },
      () {},
      TogglePauseEventParams(
        eventId: eventId.toString(),
        shouldPause: shouldPause,
      ),
    );

    final success = await completer.future;
    emit(state.copyWith(
      isTogglingPause: false,
      // Only flip the stored state when the backend confirms the change.
      isPaused: success ? shouldPause : state.isPaused,
    ));
    return success;
  }
}
