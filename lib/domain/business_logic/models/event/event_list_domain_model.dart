class EventListDomainModel {
  final String eventId;
  final String eventName;
  final String eventCoverImageUrl;
  final String eventdate;
  final String eventTime;
  final String eventLocation;
  final String eventOldPrice;
  final String eventCurrentPrice;
  final String daysLeft;
  final int peopleInterested;
  final bool isHotEvent;
  final Map<String, String> location;

  EventListDomainModel({
    required this.eventId,
    required this.eventName,
    required this.eventCoverImageUrl,
    required this.eventdate,
    required this.eventTime,
    required this.eventLocation,
    required this.eventOldPrice,
    required this.eventCurrentPrice,
    required this.daysLeft,
    required this.peopleInterested,
    required this.isHotEvent,
    required this.location,
  });
}
