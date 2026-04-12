import 'package:glint_frontend/data/remote/model/request/admin/create_event_request_body.dart';
import 'package:glint_frontend/data/remote/model/request/admin/update_event_request_body.dart';
import 'package:glint_frontend/domain/business_logic/models/event/event_list_domain_model.dart';

class CreateEventRequestDomainModel {
  String eventName;
  bool isHotEvent;
  String eventDescription;
  String googleMapUrl;
  double eventLocationLat;
  double eventLocationLong;
  String createdTime;
  String bookTime;
  String startDateAndTime;
  String endDateAndTime;
  int originalPrice;
  int discountedPrice;
  bool discountActivated;
  int ticketsRemaining;
  int totalTicket;
  String eventLocationName;
  List<String> categoryList;
  List<String> tempImageIds;

  /// Only used when editing an existing event.
  String? eventId;

  CreateEventRequestDomainModel({
    required this.eventName,
    required this.isHotEvent,
    required this.eventDescription,
    required this.googleMapUrl,
    required this.eventLocationLat,
    required this.eventLocationLong,
    required this.createdTime,
    required this.bookTime,
    required this.startDateAndTime,
    required this.endDateAndTime,
    required this.originalPrice,
    required this.discountedPrice,
    required this.discountActivated,
    required this.ticketsRemaining,
    required this.totalTicket,
    required this.categoryList,
    required this.eventLocationName,
    required this.tempImageIds,
    this.eventId,
  });

  factory CreateEventRequestDomainModel.defaultValues() {
    return CreateEventRequestDomainModel(
      eventName: "",
      isHotEvent: false,
      eventDescription: "",
      googleMapUrl: "",
      eventLocationLat: 0.0,
      eventLocationLong: 0.0,
      createdTime: DateTime.now().toIso8601String(),
      bookTime: "",
      startDateAndTime: "",
      endDateAndTime: "",
      originalPrice: 100,
      discountedPrice: 100,
      discountActivated: false,
      ticketsRemaining: 100,
      totalTicket: 100,
      eventLocationName: "",
      categoryList: [],
      tempImageIds: [],
    );
  }

  CreateEventRequestDomainModel copyWith({
    String? eventName,
    bool? isHotEvent,
    String? eventDescription,
    String? googleMapUrl,
    double? eventLocationLat,
    double? eventLocationLong,
    String? createdTime,
    String? bookTime,
    String? startDateAndTime,
    String? endDateAndTime,
    int? originalPrice,
    int? discountedPrice,
    bool? discountActivated,
    int? ticketsRemaining,
    int? totalTicket,
    List<String>? categoryList,
    String? eventLocationName,
    List<String>? tempImageIds,
    String? eventId,
  }) {
    return CreateEventRequestDomainModel(
      eventName: eventName ?? this.eventName,
      isHotEvent: isHotEvent ?? this.isHotEvent,
      eventDescription: eventDescription ?? this.eventDescription,
      googleMapUrl: googleMapUrl ?? this.googleMapUrl,
      eventLocationLat: eventLocationLat ?? this.eventLocationLat,
      eventLocationLong: eventLocationLong ?? this.eventLocationLong,
      createdTime: createdTime ?? this.createdTime,
      bookTime: bookTime ?? this.bookTime,
      startDateAndTime: startDateAndTime ?? this.startDateAndTime,
      endDateAndTime: endDateAndTime ?? this.endDateAndTime,
      originalPrice: originalPrice ?? this.originalPrice,
      discountedPrice: discountedPrice ?? this.discountedPrice,
      discountActivated: discountActivated ?? this.discountActivated,
      ticketsRemaining: ticketsRemaining ?? this.ticketsRemaining,
      totalTicket: totalTicket ?? this.totalTicket,
      eventLocationName: eventLocationName ?? this.eventLocationName,
      categoryList: categoryList ?? List<String>.from(this.categoryList),
      tempImageIds: tempImageIds ?? List<String>.from(this.tempImageIds),
      eventId: eventId ?? this.eventId,
    );
  }
}

extension CreateEventRequestMapper on CreateEventRequestDomainModel {
  CreateEventRequestBody mapToRequestBody() {
    return CreateEventRequestBody(
      eventName: eventName,
      isHotEvent: isHotEvent,
      eventDescription: eventDescription,
      googleMapUrl: googleMapUrl,
      eventLocationLongitude: eventLocationLong,
      eventLocationLatitude: eventLocationLat,
      createdTime: createdTime,
      bookByTime: bookTime,
      startTime: startDateAndTime,
      endTime: endDateAndTime,
      ticketPrice: originalPrice,
      discountTicketPrice: discountedPrice,
      discountActivated: discountActivated,
      ticketsRemaining: ticketsRemaining,
      totalTickets: totalTicket,
      eventLocationName: eventLocationName,
      categoryList: categoryList,
      tempImageIds: tempImageIds,
    );
  }

  UpdateEventRequestBody mapToUpdateRequestBody() {
    return UpdateEventRequestBody(
      eventId: eventId != null ? int.tryParse(eventId!) : null,
      eventName: eventName,
      isHotEvent: isHotEvent,
      eventDescription: eventDescription,
      googleMapUrl: googleMapUrl,
      eventLocationLongitude: eventLocationLong,
      eventLocationLatitude: eventLocationLat,
      eventLocationName: eventLocationName,
      bookByTime: bookTime,
      startTime: startDateAndTime,
      endTime: endDateAndTime,
      ticketPrice: originalPrice,
      discountTicketPrice: discountedPrice,
      discountActivated: discountActivated,
      ticketsRemaining: ticketsRemaining,
      totalTickets: totalTicket,
      addCategoryList: categoryList,
      deleteCategoryList: [],
    );
  }

  EventListDomainModel mapToDomainModel() {
    return EventListDomainModel(
      eventId: "",
      eventName: eventName,
      eventCoverImageUrl: "",
      eventdate: startDateAndTime,
      eventTime: bookTime,
      eventLocation: eventLocationName,
      eventOldPrice: originalPrice.toString(),
      eventCurrentPrice: discountedPrice.toString(),
      daysLeft: "7",
      peopleInterested: 0,
      isHotEvent: isHotEvent,
      location: {},
    );
  }
}
