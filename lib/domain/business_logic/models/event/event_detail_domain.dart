import 'package:glint_frontend/domain/business_logic/models/admin/create_event_request.dart';
import 'package:glint_frontend/utils/date_and_time_extensions.dart';

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
  final bool isPaused;

  // Common extended fields
  final bool discountActivated;
  final int? ticketsBought;
  final String? coordinatorUsername;

  final DateTime? startDateTime;
  final DateTime? endDateTime;

  // Admin-only fields
  final String? googleMapUrl;
  final DateTime? bookByTime;
  final int? totalTickets;
  final int? ticketsRemaining;
  final List<String>? categories;
  final String? approvalStatus;
  final bool? isHotEvent;
  final String? coordinatorEmail;
  final int? interestedCount;
  final int? confirmedTicketsCount;

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
    this.isPaused = false,
    this.discountActivated = false,
    this.ticketsBought,
    this.coordinatorUsername,
    this.startDateTime,
    this.endDateTime,
    this.googleMapUrl,
    this.bookByTime,
    this.totalTickets,
    this.ticketsRemaining,
    this.categories,
    this.approvalStatus,
    this.isHotEvent,
    this.coordinatorEmail,
    this.interestedCount,
    this.confirmedTicketsCount,
  });

  double get latitude => double.tryParse(location["lat"] ?? "0") ?? 0.0;
  double get longitude => double.tryParse(location["long"] ?? "0") ?? 0.0;

  bool get isAdminView => totalTickets != null || googleMapUrl != null;

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
    bool? isPaused,
    bool? discountActivated,
    int? ticketsBought,
    String? coordinatorUsername,
    DateTime? startDateTime,
    DateTime? endDateTime,
    String? googleMapUrl,
    DateTime? bookByTime,
    int? totalTickets,
    int? ticketsRemaining,
    List<String>? categories,
    String? approvalStatus,
    bool? isHotEvent,
    String? coordinatorEmail,
    int? interestedCount,
    int? confirmedTicketsCount,
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
      isPaused: isPaused ?? this.isPaused,
      discountActivated: discountActivated ?? this.discountActivated,
      ticketsBought: ticketsBought ?? this.ticketsBought,
      coordinatorUsername: coordinatorUsername ?? this.coordinatorUsername,
      startDateTime: startDateTime ?? this.startDateTime,
      endDateTime: endDateTime ?? this.endDateTime,
      googleMapUrl: googleMapUrl ?? this.googleMapUrl,
      bookByTime: bookByTime ?? this.bookByTime,
      totalTickets: totalTickets ?? this.totalTickets,
      ticketsRemaining: ticketsRemaining ?? this.ticketsRemaining,
      categories: categories ?? this.categories,
      approvalStatus: approvalStatus ?? this.approvalStatus,
      isHotEvent: isHotEvent ?? this.isHotEvent,
      coordinatorEmail: coordinatorEmail ?? this.coordinatorEmail,
      interestedCount: interestedCount ?? this.interestedCount,
      confirmedTicketsCount: confirmedTicketsCount ?? this.confirmedTicketsCount,
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
    final now = DateTime.now();
    return CreateEventRequestDomainModel(
      eventId: eventId,
      eventName: eventName,
      isHotEvent: isHotEvent ?? false,
      eventDescription: aboutEvent,
      googleMapUrl: googleMapUrl ?? "",
      eventLocationLat: latitude,
      eventLocationLong: longitude,
      createdTime: now.formatToStandard(),
      bookTime: bookByTime?.formatToStandard() ?? startDateTime?.formatToStandard() ?? "",
      startDateAndTime: startDateTime?.formatToStandard() ?? "",
      endDateAndTime: endDateTime?.formatToStandard() ?? "",
      originalPrice: int.tryParse(eventOldPrice) ?? 0,
      discountedPrice: int.tryParse(eventCurrentPrice) ?? 0,
      discountActivated: discountActivated,
      ticketsRemaining: ticketsRemaining ?? 30,
      totalTicket: totalTickets ?? 100,
      eventLocationName: eventLocation,
      eventBy: eventBy,
      categoryList: categories ?? [],
      originalCategoryList: categories ?? [],
      tempImageIds: [],
    );
  }
}
