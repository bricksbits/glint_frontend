part of 'track_specific_event_bloc.dart';

@freezed
class TrackSpecificEventEvent with _$TrackSpecificEventEvent {
  const factory TrackSpecificEventEvent.started() = _Started;

  const factory TrackSpecificEventEvent.pauseEvent() = _PauseEvent;

  const factory TrackSpecificEventEvent.editEvent() = _EditEvent;

  const factory TrackSpecificEventEvent.fetchInterestedUsers() =
      _FetchInterestedUsers;

  const factory TrackSpecificEventEvent.fetchTicketBoughtUsers() =
      _FetchTicketBoughtUsers;
}
