import 'package:glint_frontend/data/remote/model/request/admin/create_event_request_body.dart';
import 'package:glint_frontend/domain/business_logic/models/event/event_list_domain_model.dart';

class CreateEventRequestDomainModel {
  String eventName;
  bool isHotEvent;
  String eventDescription;
  double eventLocationLat;
  double eventLocationLong;
  String createdTime;
  String bookTime;
  String startDateAndTime;
  String endDateAndTime;
  int originalPrice;
  int discountedPrice;
  int ticketsRemaining;
  int totalTicket;
  String eventLocationName;
  List<String> categoryList;

  CreateEventRequestDomainModel({
    required this.eventName,
    required this.isHotEvent,
    required this.eventDescription,
    required this.eventLocationLat,
    required this.eventLocationLong,
    required this.createdTime,
    required this.bookTime,
    required this.startDateAndTime,
    required this.endDateAndTime,
    required this.originalPrice,
    required this.discountedPrice,
    required this.ticketsRemaining,
    required this.totalTicket,
    required this.categoryList,
    required this.eventLocationName,
  });

  factory CreateEventRequestDomainModel.defaultValues() {
    return CreateEventRequestDomainModel(
      eventName: "",
      isHotEvent: false,
      eventDescription: "",
      eventLocationLat: 0.0,
      eventLocationLong: 0.0,
      createdTime: DateTime.now().toIso8601String(),
      bookTime: "",
      startDateAndTime: "",
      endDateAndTime: "",
      originalPrice: 100,
      discountedPrice: 100,
      ticketsRemaining: 100,
      totalTicket: 100,
      eventLocationName: "",
      categoryList: [],
    );
  }

  CreateEventRequestDomainModel copyWith({
    String? eventName,
    bool? isHotEvent,
    String? eventDescription,
    double? eventLocationLat,
    double? eventLocationLong,
    String? createdTime,
    String? bookTime,
    String? startDateAndTime,
    String? endDateAndTime,
    int? originalPrice,
    int? discountedPrice,
    int? ticketsRemaining,
    int? totalTicket,
    List<String>? categoryList,
    String? eventLocationName,
  }) {
    return CreateEventRequestDomainModel(
      eventName: eventName ?? this.eventName,
      isHotEvent: isHotEvent ?? this.isHotEvent,
      eventDescription: eventDescription ?? this.eventDescription,
      eventLocationLat: eventLocationLat ?? this.eventLocationLat,
      eventLocationLong: eventLocationLong ?? this.eventLocationLong,
      createdTime: createdTime ?? this.createdTime,
      bookTime: bookTime ?? this.bookTime,
      startDateAndTime: startDateAndTime ?? this.startDateAndTime,
      endDateAndTime: endDateAndTime ?? this.endDateAndTime,
      originalPrice: originalPrice ?? this.originalPrice,
      discountedPrice: discountedPrice ?? this.discountedPrice,
      ticketsRemaining: ticketsRemaining ?? this.ticketsRemaining,
      totalTicket: totalTicket ?? this.totalTicket,
      eventLocationName: eventLocationName ?? this.eventLocationName,
      categoryList: categoryList ?? List<String>.from(this.categoryList),
    );
  }
}

extension CreateEventRequestMapper on CreateEventRequestDomainModel {
  CreateEventRequestBody mapToRequestBody() {
    return CreateEventRequestBody(
      eventName: eventName,
      isHotEvent: isHotEvent,
      eventDescription: eventDescription,
      eventLocationLongitude: eventLocationLong,
      eventLocationLatitude: eventLocationLong,
      createdTime: createdTime,
      bookByTime: bookTime,
      startTime: startDateAndTime,
      endTime: endDateAndTime,
      ticketPrice: originalPrice,
      ticketsRemaining: ticketsRemaining,
      totalTickets: totalTicket,
      eventLocationName: eventLocationName,
      categoryList: ["Basic"],
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
