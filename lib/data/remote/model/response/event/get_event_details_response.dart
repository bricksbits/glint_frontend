import 'dart:convert';

import 'package:glint_frontend/domain/business_logic/models/event/event_detail_domain.dart';

GetEventDetailsResponse getEventDetailsResponseFromJson(String str) =>
    GetEventDetailsResponse.fromJson(json.decode(str));

String getEventDetailsResponseToJson(GetEventDetailsResponse data) =>
    json.encode(data.toJson());

class GetEventDetailsResponse {
  GetEventDetailsResponse({
    this.eventDetails,
  });

  GetEventDetailsResponse.fromJson(dynamic json) {
    eventDetails = json['event_details'] != null
        ? EventDetails.fromJson(json['event_details'])
        : null;
  }

  EventDetails? eventDetails;

  GetEventDetailsResponse copyWith({
    EventDetails? eventDetails,
  }) =>
      GetEventDetailsResponse(
        eventDetails: eventDetails ?? this.eventDetails,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (eventDetails != null) {
      map['event_details'] = eventDetails?.toJson();
    }
    return map;
  }
}

EventDetails eventDetailsFromJson(String str) =>
    EventDetails.fromJson(json.decode(str));

String eventDetailsToJson(EventDetails data) => json.encode(data.toJson());

class EventDetails {
  EventDetails({
    this.coordinatorUserId,
    this.coordinatorUserPhoneNumber,
    this.coordinatorUserUsername,
    this.eventName,
    this.eventDescription,
    this.ticketPrice,
    this.discountTicketPrice,
    this.discountActivated,
    this.ticketsBought,
    this.interestedUsersCount,
    this.eventLongitude,
    this.eventLatitude,
    this.startTime,
    this.endTime,
    this.pictureUrlList,
    this.videoUrlList,
  });

  EventDetails.fromJson(dynamic json) {
    coordinatorUserId = json['coordinator_user_id'];
    coordinatorUserPhoneNumber = json['coordinator_user_phone_number'];
    coordinatorUserUsername = json['coordinator_user_username'];
    eventName = json['event_name'];
    eventDescription = json['event_description'];
    ticketPrice = json['ticket_price'];
    discountTicketPrice = json['discount_ticket_price'];
    discountActivated = json['discount_activated'];
    ticketsBought = json['tickets_bought'];
    interestedUsersCount = json['interested_users_count'];
    eventLongitude = (json['event_longitude'] as num).toDouble();
    eventLatitude = (json['event_latitude'] as num).toDouble();
    startTime = json['start_time'];
    endTime = json['end_time'];
    pictureUrlList = json['picture_url_list'] != null
        ? json['picture_url_list'].cast<String>()
        : [];
    videoUrlList = json['video_url_list'] != null
        ? json['video_url_list'].cast<String>()
        : [];
  }

  int? coordinatorUserId;
  String? coordinatorUserPhoneNumber;
  String? coordinatorUserUsername;
  String? eventName;
  String? eventDescription;
  int? ticketPrice;
  int? discountTicketPrice;
  bool? discountActivated;
  int? ticketsBought;
  int? interestedUsersCount;
  double? eventLongitude;
  double? eventLatitude;
  String? startTime;
  String? endTime;
  List<String>? pictureUrlList;
  List<String>? videoUrlList;

  EventDetails copyWith({
    int? coordinatorUserId,
    String? coordinatorUserPhoneNumber,
    String? coordinatorUserUsername,
    String? eventName,
    String? eventDescription,
    int? ticketPrice,
    int? discountTicketPrice,
    bool? discountActivated,
    int? ticketsBought,
    int? interestedUsersCount,
    double? eventLongitude,
    double? eventLatitude,
    String? startTime,
    String? endTime,
    List<String>? pictureUrlList,
    List<String>? videoUrlList,
  }) =>
      EventDetails(
        coordinatorUserId: coordinatorUserId ?? this.coordinatorUserId,
        coordinatorUserPhoneNumber:
            coordinatorUserPhoneNumber ?? this.coordinatorUserPhoneNumber,
        coordinatorUserUsername:
            coordinatorUserUsername ?? this.coordinatorUserUsername,
        eventName: eventName ?? this.eventName,
        eventDescription: eventDescription ?? this.eventDescription,
        ticketPrice: ticketPrice ?? this.ticketPrice,
        discountTicketPrice: discountTicketPrice ?? this.discountTicketPrice,
        discountActivated: discountActivated ?? this.discountActivated,
        ticketsBought: ticketsBought ?? this.ticketsBought,
        interestedUsersCount: interestedUsersCount ?? this.interestedUsersCount,
        eventLongitude: eventLongitude ?? this.eventLongitude,
        eventLatitude: eventLatitude ?? this.eventLatitude,
        startTime: startTime ?? this.startTime,
        endTime: endTime ?? this.endTime,
        pictureUrlList: pictureUrlList ?? this.pictureUrlList,
        videoUrlList: videoUrlList ?? this.videoUrlList,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['coordinator_user_id'] = coordinatorUserId;
    map['coordinator_user_phone_number'] = coordinatorUserPhoneNumber;
    map['coordinator_user_username'] = coordinatorUserUsername;
    map['event_name'] = eventName;
    map['event_description'] = eventDescription;
    map['ticket_price'] = ticketPrice;
    map['discount_ticket_price'] = discountTicketPrice;
    map['discount_activated'] = discountActivated;
    map['tickets_bought'] = ticketsBought;
    map['interested_users_count'] = interestedUsersCount;
    map['event_longitude'] = eventLongitude;
    map['event_latitude'] = eventLatitude;
    map['start_time'] = startTime;
    map['end_time'] = endTime;
    map['picture_url_list'] = pictureUrlList;
    map['video_url_list'] = videoUrlList;
    return map;
  }
}

extension EventDetailsMapper on GetEventDetailsResponse {
  EventDetailsDomainModel mapToDomain() {
    final detail = eventDetails;
    return EventDetailsDomainModel(
        eventId: detail?.coordinatorUserId.toString() ?? "",
        eventName: detail?.eventName ?? "",
        eventCoverImageUrl: detail?.pictureUrlList ?? [],
        eventdate: detail?.endTime ?? "",
        eventTime: detail?.startTime ?? "",
        eventLocation: "Location - ",
        eventOldPrice: detail?.ticketPrice.toString() ?? "",
        eventCurrentPrice: detail?.discountTicketPrice.toString() ?? "",
        daysLeft: calculateDaysBetween(detail?.startTime, detail?.endTime),
        peopleInterested: detail?.interestedUsersCount ?? 0,
        aboutEvent: detail?.eventDescription ?? "",
        location: {
          "lat": detail?.eventLatitude.toString() ?? "",
          "long": detail?.eventLongitude.toString() ?? ""
        },
        eventBy: "Event By - ");
  }
}

String calculateDaysBetween(String? startTime, String? endTime) {
  if (startTime != null && endTime != null) {
    final start = DateTime.parse(startTime);
    final end = DateTime.parse(endTime);

    // Ensure time is in UTC (as indicated by the 'Z')
    final startUtc = start.toUtc();
    final endUtc = end.toUtc();

    final difference = endUtc.difference(startUtc);

    // If duration is less than 24 hours, return 0
    return (difference.inDays).toString();
  } else {
    return "0";
  }
}
