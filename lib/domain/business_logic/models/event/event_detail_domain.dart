import 'package:glint_frontend/domain/business_logic/models/admin/create_event_request.dart';

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

  EventDetailsDomainModel({
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
    required this.aboutEvent,
    required this.location,
    required this.eventBy,
  });

  EventDetailsDomainModel copyWith({
    String? eventId,
    String? eventName,
    List<String>? eventCoverImageUrl,
    String? eventdate,
    String? eventTime,
    String? eventLocation,
    String? eventOldPrice,
    String? eventCurrentPrice,
    String? daysLeft,
    int? peopleInterested,
    String? aboutEvent,
    Map<String, String>? location,
    String? eventBy,
  }) {
    return EventDetailsDomainModel(
      eventId: eventId ?? this.eventId,
      eventName: eventName ?? this.eventName,
      eventCoverImageUrl: eventCoverImageUrl ?? this.eventCoverImageUrl,
      eventdate: eventdate ?? this.eventdate,
      eventTime: eventTime ?? this.eventTime,
      eventLocation: eventLocation ?? this.eventLocation,
      eventOldPrice: eventOldPrice ?? this.eventOldPrice,
      eventCurrentPrice: eventCurrentPrice ?? this.eventCurrentPrice,
      daysLeft: daysLeft ?? this.daysLeft,
      peopleInterested: peopleInterested ?? this.peopleInterested,
      aboutEvent: aboutEvent ?? this.aboutEvent,
      location: location ?? this.location,
      eventBy: eventBy ?? this.eventBy,
    );
  }

  @override
  String toString() {
    return 'EventDetailsDomainModel('
        'eventId: $eventId, '
        'eventName: $eventName, '
        'eventCoverImageUrl: $eventCoverImageUrl, '
        'eventdate: $eventdate, '
        'eventTime: $eventTime, '
        'eventLocation: $eventLocation, '
        'eventOldPrice: $eventOldPrice, '
        'eventCurrentPrice: $eventCurrentPrice, '
        'daysLeft: $daysLeft, '
        'peopleInterested: $peopleInterested, '
        'aboutEvent: $aboutEvent, '
        'location: $location, '
        'eventBy: $eventBy'
        ')';
  }
}

extension EventDetailsToCreateEventMapper on EventDetailsDomainModel {
  CreateEventRequestDomainModel mapToCreateEvent() {
    return CreateEventRequestDomainModel(
      eventName: eventName,
        isHotEvent: false,
        eventDescription: aboutEvent,
        eventLocationLat: 00.00,
        eventLocationLong: 00.00,
        createdTime: eventdate,
        bookTime: eventTime,
        startDateAndTime: eventdate,
        endDateAndTime: eventTime,
        originalPrice: int.parse(eventOldPrice),
        discountedPrice: int.parse(eventCurrentPrice),
        ticketsRemaining: 30,
        totalTicket: 100,
        eventLocationName: eventLocation,
        categoryList: [],
    );
  }
}
