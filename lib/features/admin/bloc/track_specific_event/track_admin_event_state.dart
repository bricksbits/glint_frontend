part of 'track_admin_event_cubit.dart';

@freezed
class TrackAdminEventState with _$TrackAdminEventState {
  const factory TrackAdminEventState.trackEventState({
    @Default(null) int? eventId,
    @Default("") String eventTitle,
    @Default("") String eventDate,
    @Default("") String eventImageUrl,
    @Default("0") String interestedUserCount,
    @Default("000") String revenueGenerated,
    @Default([]) List<EventTicketBoughtDomainModel> ticketBoughtUsers,
    @Default([]) List<EventInterestedUserDomainModel> interestedUsers,
    @Default(false) bool isLoading,
    @Default("") String error,
  }) = _TrackEventState;
}
