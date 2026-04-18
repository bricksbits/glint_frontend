part of 'track_admin_event_cubit.dart';

@freezed
class TrackAdminEventState with _$TrackAdminEventState {
  const factory TrackAdminEventState.trackEventState({
    @Default(null) int? eventId,
    @Default("") String eventTitle,
    @Default("") String eventDate,
    @Default("") String eventImageUrl,
    @Default("") String eventLocation,
    @Default(false) bool isPaused,
    @Default(false) bool isTogglingPause,
    @Default("0") String interestedUserCount,
    @Default("0") String revenueGenerated,
    @Default([]) List<EventTicketBoughtDomainModel> ticketBoughtUsers,
    @Default([]) List<EventInterestedUserDomainModel> interestedUsers,
    @Default(false) bool isLoading,
    @Default("") String error,
    // Pagination — interested users
    @Default(0) int interestedOffset,
    @Default(false) bool isLoadingMoreInterested,
    @Default(true) bool hasMoreInterested,
    // Pagination — ticket-bought users
    @Default(0) int ticketBoughtOffset,
    @Default(false) bool isLoadingMoreTicketBought,
    @Default(true) bool hasMoreTicketBought,
  }) = _TrackEventState;
}
