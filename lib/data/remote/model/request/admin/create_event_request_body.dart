import 'dart:convert';

CreateEventRequestBody createEventRequestBodyFromJson(String str) =>
    CreateEventRequestBody.fromJson(json.decode(str));

String createEventRequestBodyToJson(CreateEventRequestBody data) =>
    json.encode(data.toJson());

class CreateEventRequestBody {
  CreateEventRequestBody({
    this.eventName,
    this.isHotEvent,
    this.eventDescription,
    this.googleMapUrl,
    this.eventLocationLongitude,
    this.eventLocationLatitude,
    this.eventLocationName,
    this.createdTime,
    this.bookByTime,
    this.startTime,
    this.endTime,
    this.ticketPrice,
    this.discountTicketPrice,
    this.discountActivated,
    this.ticketsRemaining,
    this.totalTickets,
    this.categoryList,
    this.tempImageIds,
    this.eventBy,
  });

  CreateEventRequestBody.fromJson(dynamic json) {
    eventName = json['event_name'];
    isHotEvent = json['is_hot_event'];
    eventDescription = json['event_description'];
    googleMapUrl = json['google_map_url'];
    eventLocationLongitude = json['event_location_longitude'];
    eventLocationLatitude = json['event_location_latitude'];
    eventLocationName = json['event_location_name'];
    createdTime = json['created_time'];
    bookByTime = json['book_by_time'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    ticketPrice = json['ticket_price'];
    discountTicketPrice = json['discount_ticket_price'];
    discountActivated = json['discount_activated'];
    ticketsRemaining = json['tickets_remaining'];
    totalTickets = json['total_tickets'];
    categoryList = json['category_list'] != null
        ? json['category_list'].cast<String>()
        : [];
    tempImageIds = json['temp_image_ids'] != null
        ? json['temp_image_ids'].cast<String>()
        : [];
    eventBy = json['event_by'];
  }

  String? eventName;
  bool? isHotEvent;
  String? eventDescription;
  String? googleMapUrl;
  double? eventLocationLongitude;
  double? eventLocationLatitude;
  String? eventLocationName;
  String? createdTime;
  String? bookByTime;
  String? startTime;
  String? endTime;
  int? ticketPrice;
  int? discountTicketPrice;
  bool? discountActivated;
  int? ticketsRemaining;
  int? totalTickets;
  List<String>? categoryList;
  List<String>? tempImageIds;
  String? eventBy;

  CreateEventRequestBody copyWith({
    String? eventName,
    bool? isHotEvent,
    String? eventDescription,
    String? googleMapUrl,
    double? eventLocationLongitude,
    double? eventLocationLatitude,
    String? eventLocationName,
    String? createdTime,
    String? bookByTime,
    String? startTime,
    String? endTime,
    int? ticketPrice,
    int? discountTicketPrice,
    bool? discountActivated,
    int? ticketsRemaining,
    int? totalTickets,
    List<String>? categoryList,
    List<String>? tempImageIds,
    String? eventBy,
  }) =>
      CreateEventRequestBody(
        eventName: eventName ?? this.eventName,
        isHotEvent: isHotEvent ?? this.isHotEvent,
        eventDescription: eventDescription ?? this.eventDescription,
        googleMapUrl: googleMapUrl ?? this.googleMapUrl,
        eventLocationLongitude:
            eventLocationLongitude ?? this.eventLocationLongitude,
        eventLocationLatitude:
            eventLocationLatitude ?? this.eventLocationLatitude,
        eventLocationName: eventLocationName ?? this.eventLocationName,
        createdTime: createdTime ?? this.createdTime,
        bookByTime: bookByTime ?? this.bookByTime,
        startTime: startTime ?? this.startTime,
        endTime: endTime ?? this.endTime,
        ticketPrice: ticketPrice ?? this.ticketPrice,
        discountTicketPrice: discountTicketPrice ?? this.discountTicketPrice,
        discountActivated: discountActivated ?? this.discountActivated,
        ticketsRemaining: ticketsRemaining ?? this.ticketsRemaining,
        totalTickets: totalTickets ?? this.totalTickets,
        categoryList: categoryList ?? this.categoryList,
        tempImageIds: tempImageIds ?? this.tempImageIds,
        eventBy: eventBy ?? this.eventBy,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['event_name'] = eventName;
    map['is_hot_event'] = isHotEvent;
    map['event_description'] = eventDescription;
    map['google_map_url'] = googleMapUrl;
    map['event_location_longitude'] = eventLocationLongitude;
    map['event_location_latitude'] = eventLocationLatitude;
    map['event_location_name'] = eventLocationName;
    map['created_time'] = createdTime;
    map['book_by_time'] = bookByTime;
    map['start_time'] = startTime;
    map['end_time'] = endTime;
    map['ticket_price'] = ticketPrice;
    map['discount_ticket_price'] = discountTicketPrice;
    map['discount_activated'] = discountActivated;
    map['tickets_remaining'] = ticketsRemaining;
    map['total_tickets'] = totalTickets;
    map['category_list'] = categoryList;
    map['temp_image_ids'] = tempImageIds;
    map['event_by'] = eventBy;
    return map;
  }
}
