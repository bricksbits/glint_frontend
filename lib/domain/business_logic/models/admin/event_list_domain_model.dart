class EventListDomainModel {
  final String eventName;
  final String eventId;
  final String eventThumbnail;
  final String eventDate;
  final String eventBy;
  final AdminEventState eventState;

  EventListDomainModel({
    required this.eventName,
    required this.eventId,
    required this.eventThumbnail,
    required this.eventDate,
    required this.eventBy,
    this.eventState = AdminEventState.PENDING,
  });
}

enum AdminEventState {
  LIVE,
  PENDING,
  REJECTED,
  PAST_EVENT,
}
