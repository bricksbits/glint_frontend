class EventDetailsDomainModel {
  final String eventId;
  final String eventName;
  final List<String> eventCoverImageUrl;
  final String eventdate;
  final String eventTime;
  final String eventLocation;
  final String eventOldPrice;
  final String eventCurrentPrice;
  final String daysLeft;
  final int peopleInterested;
  final String aboutEvent;
  final Map<String, String> location;
  final String eventBy;

  EventDetailsDomainModel(
      {required this.eventId,
      required this.eventName,
      required this.eventCoverImageUrl,
      required this.eventdate,
      required this.eventTime,
      required this.eventLocation,
      required this.eventOldPrice,
      required this.eventCurrentPrice,
      required this.daysLeft,
      required this.peopleInterested,
      required this.aboutEvent,
      required this.location,
      required this.eventBy});
}
