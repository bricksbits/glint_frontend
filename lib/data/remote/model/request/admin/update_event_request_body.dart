import 'dart:convert';
UpdateEventRequestBody updateEventRequestBodyFromJson(String str) => UpdateEventRequestBody.fromJson(json.decode(str));
String updateEventRequestBodyToJson(UpdateEventRequestBody data) => json.encode(data.toJson());
class UpdateEventRequestBody {
  UpdateEventRequestBody({
      this.eventName, 
      this.isHotEvent, 
      this.eventDescription, 
      this.eventLocationLongitude, 
      this.eventLocationLatitude, 
      this.createdTime, 
      this.bookByTime, 
      this.startTime, 
      this.endTime, 
      this.ticketPrice, 
      this.ticketsRemaining, 
      this.totalTickets, 
      this.addCategoryList, 
      this.deleteCategoryList,});

  UpdateEventRequestBody.fromJson(dynamic json) {
    eventName = json['event_name'];
    isHotEvent = json['is_hot_event'];
    eventDescription = json['event_description'];
    eventLocationLongitude = json['event_location_longitude'];
    eventLocationLatitude = json['event_location_latitude'];
    createdTime = json['created_time'];
    bookByTime = json['book_by_time'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    ticketPrice = json['ticket_price'];
    ticketsRemaining = json['tickets_remaining'];
    totalTickets = json['total_tickets'];
    addCategoryList = json['add_category_list'] != null ? json['add_category_list'].cast<String>() : [];
    deleteCategoryList = json['delete_category_list'] != null ? json['delete_category_list'].cast<String>() : [];
  }
  String? eventName;
  bool? isHotEvent;
  String? eventDescription;
  double? eventLocationLongitude;
  double? eventLocationLatitude;
  String? createdTime;
  String? bookByTime;
  String? startTime;
  String? endTime;
  int? ticketPrice;
  int? ticketsRemaining;
  int? totalTickets;
  List<String>? addCategoryList;
  List<String>? deleteCategoryList;
UpdateEventRequestBody copyWith({  String? eventName,
  bool? isHotEvent,
  String? eventDescription,
  double? eventLocationLongitude,
  double? eventLocationLatitude,
  String? createdTime,
  String? bookByTime,
  String? startTime,
  String? endTime,
  int? ticketPrice,
  int? ticketsRemaining,
  int? totalTickets,
  List<String>? addCategoryList,
  List<String>? deleteCategoryList,
}) => UpdateEventRequestBody(  eventName: eventName ?? this.eventName,
  isHotEvent: isHotEvent ?? this.isHotEvent,
  eventDescription: eventDescription ?? this.eventDescription,
  eventLocationLongitude: eventLocationLongitude ?? this.eventLocationLongitude,
  eventLocationLatitude: eventLocationLatitude ?? this.eventLocationLatitude,
  createdTime: createdTime ?? this.createdTime,
  bookByTime: bookByTime ?? this.bookByTime,
  startTime: startTime ?? this.startTime,
  endTime: endTime ?? this.endTime,
  ticketPrice: ticketPrice ?? this.ticketPrice,
  ticketsRemaining: ticketsRemaining ?? this.ticketsRemaining,
  totalTickets: totalTickets ?? this.totalTickets,
  addCategoryList: addCategoryList ?? this.addCategoryList,
  deleteCategoryList: deleteCategoryList ?? this.deleteCategoryList,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['event_name'] = eventName;
    map['is_hot_event'] = isHotEvent;
    map['event_description'] = eventDescription;
    map['event_location_longitude'] = eventLocationLongitude;
    map['event_location_latitude'] = eventLocationLatitude;
    map['created_time'] = createdTime;
    map['book_by_time'] = bookByTime;
    map['start_time'] = startTime;
    map['end_time'] = endTime;
    map['ticket_price'] = ticketPrice;
    map['tickets_remaining'] = ticketsRemaining;
    map['total_tickets'] = totalTickets;
    map['add_category_list'] = addCategoryList;
    map['delete_category_list'] = deleteCategoryList;
    return map;
  }

}