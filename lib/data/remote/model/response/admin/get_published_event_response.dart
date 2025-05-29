import 'dart:convert';

import 'package:glint_frontend/domain/business_logic/models/admin/event_list_domain_model.dart';
import 'package:intl/intl.dart';

GetPublishedEventResponse getPublishedEventResponseFromJson(String str) =>
    GetPublishedEventResponse.fromJson(json.decode(str));

String getPublishedEventResponseToJson(GetPublishedEventResponse data) =>
    json.encode(data.toJson());

class GetPublishedEventResponse {
  GetPublishedEventResponse({
    this.response,
  });

  GetPublishedEventResponse.fromJson(dynamic json) {
    if (json['response'] != null) {
      response = [];
      json['response'].forEach((v) {
        response?.add(Response.fromJson(v));
      });
    }
  }

  List<Response>? response;

  GetPublishedEventResponse copyWith({
    List<Response>? response,
  }) =>
      GetPublishedEventResponse(
        response: response ?? this.response,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (response != null) {
      map['response'] = response?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

Response responseFromJson(String str) => Response.fromJson(json.decode(str));

String responseToJson(Response data) => json.encode(data.toJson());

class Response {
  Response({
    this.eventId,
    this.eventName,
    this.createdTime,
    this.bookByTime,
    this.startTime,
    this.endTime,
    this.ticketPrice,
    this.totalTickets,
    this.ticketsRemaining,
    this.approvedByAdmin,
    this.isHotEvent,
  });

  Response.fromJson(dynamic json) {
    eventId = json['event_id'];
    eventName = json['event_name'];
    createdTime = json['created_time'];
    bookByTime = json['book_by_time'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    ticketPrice = json['ticket_price'];
    totalTickets = json['total_tickets'];
    ticketsRemaining = json['tickets_remaining'];
    approvedByAdmin = json['approved_by_admin'];
    isHotEvent = json['is_hot_event'];
  }

  int? eventId;
  String? eventName;
  String? createdTime;
  String? bookByTime;
  String? startTime;
  String? endTime;
  int? ticketPrice;
  int? totalTickets;
  int? ticketsRemaining;
  String? approvedByAdmin;
  bool? isHotEvent;

  Response copyWith({
    int? eventId,
    String? eventName,
    String? createdTime,
    String? bookByTime,
    String? startTime,
    String? endTime,
    int? ticketPrice,
    int? totalTickets,
    int? ticketsRemaining,
    String? approvedByAdmin,
    bool? isHotEvent,
  }) =>
      Response(
        eventId: eventId ?? this.eventId,
        eventName: eventName ?? this.eventName,
        createdTime: createdTime ?? this.createdTime,
        bookByTime: bookByTime ?? this.bookByTime,
        startTime: startTime ?? this.startTime,
        endTime: endTime ?? this.endTime,
        ticketPrice: ticketPrice ?? this.ticketPrice,
        totalTickets: totalTickets ?? this.totalTickets,
        ticketsRemaining: ticketsRemaining ?? this.ticketsRemaining,
        approvedByAdmin: approvedByAdmin ?? this.approvedByAdmin,
        isHotEvent: isHotEvent ?? this.isHotEvent,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['event_id'] = eventId;
    map['event_name'] = eventName;
    map['created_time'] = createdTime;
    map['book_by_time'] = bookByTime;
    map['start_time'] = startTime;
    map['end_time'] = endTime;
    map['ticket_price'] = ticketPrice;
    map['total_tickets'] = totalTickets;
    map['tickets_remaining'] = ticketsRemaining;
    map['approved_by_admin'] = approvedByAdmin;
    map['is_hot_event'] = isHotEvent;
    return map;
  }
}

extension PublishedEventMapper on GetPublishedEventResponse {
  List<EventListDomainModel> mapToDomain() {
    if (response != null) {
      return response!
          .map((eventResponse) => EventListDomainModel(
              eventName: eventResponse.eventName ?? "Event Name",
              eventId: eventResponse.eventId.toString() ?? "0",
              eventThumbnail: eventResponse.eventName ?? "NO_URL",
              eventDate: eventResponse.startTime?.toFormattedDateTime() ?? "Starting Soon",
              eventBy: eventResponse.endTime?.toFormattedDateTime() ?? "Glint Media",
              eventState:
                  getEventState(eventResponse.approvedByAdmin ?? "false")))
          .toList();
    } else {
      return [];
    }
  }
}

AdminEventState getEventState(String responseEventState) {
  if (responseEventState == "true") {
    return AdminEventState.LIVE;
  } else if (responseEventState == "false") {
    return AdminEventState.REJECTED;
  } else if (responseEventState == "pending") {
    return AdminEventState.PENDING;
  } else {
    return AdminEventState.PAST_EVENT;
  }
}

extension DateStringFormatter on String {
  String toFormattedDateTime() {
    try {
      final parsed = DateTime.parse(this);
      final date = DateFormat('dd MMM').format(parsed);
      final time = DateFormat('hh:mm a').format(parsed);
      return '$date • $time';
    } catch (e) {
      if (length >= 10 && RegExp(r'^\d{4}-\d{2}-\d{2}').hasMatch(this)) {
        return substring(0, 10);
      }
      return this;
    }
  }
}
