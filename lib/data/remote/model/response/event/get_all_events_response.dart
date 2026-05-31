import 'dart:convert';

import 'package:glint_frontend/domain/business_logic/models/event/event_list_domain_model.dart';
import 'package:glint_frontend/utils/date_and_time_extensions.dart';

GetAllEventsResponse getAllEventsResponseFromJson(String str) =>
    GetAllEventsResponse.fromJson(json.decode(str));

String getAllEventsResponseToJson(GetAllEventsResponse data) =>
    json.encode(data.toJson());

class GetAllEventsResponse {
  GetAllEventsResponse({
    this.events,
  });

  GetAllEventsResponse.fromJson(dynamic json) {
    if (json['events'] != null) {
      events = [];
      json['events'].forEach((v) {
        events?.add(Events.fromJson(v));
      });
    }
  }

  List<Events>? events;

  GetAllEventsResponse copyWith({
    List<Events>? events,
  }) =>
      GetAllEventsResponse(
        events: events ?? this.events,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (events != null) {
      map['events'] = events?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

Events eventsFromJson(String str) => Events.fromJson(json.decode(str));

String eventsToJson(Events data) => json.encode(data.toJson());

class Events {
  Events({
    this.eventId,
    this.eventName,
    this.isHotEvent,
    this.locationLongitude,
    this.locationLatitude,
    this.timeRemaining,
    this.ticketPrice,
    this.pictureUrl,
  });

  Events.fromJson(dynamic json) {
    eventId = json['event_id'];
    eventName = json['event_name'];
    isHotEvent = json['is_hot_event'];
    locationLongitude = (json['location_longitude'] as num).toDouble();
    locationLatitude = (json['location_latitude'] as num).toDouble();
    timeRemaining = json['time_remaining'] != null
        ? (json['time_remaining'] as num).toInt()
        : null;
    ticketPrice = json['ticket_price'];
    pictureUrl = json['picture_url'] != null
        ? PictureUrl.fromJson(json['picture_url'])
        : null;
  }

  int? eventId;
  String? eventName;
  bool? isHotEvent;
  double? locationLongitude;
  double? locationLatitude;
  int? timeRemaining;
  int? ticketPrice;
  PictureUrl? pictureUrl;

  Events copyWith({
    int? eventId,
    String? eventName,
    bool? isHotEvent,
    double? locationLongitude,
    double? locationLatitude,
    int? timeRemaining,
    int? ticketPrice,
    PictureUrl? pictureUrl,
  }) =>
      Events(
        eventId: eventId ?? this.eventId,
        eventName: eventName ?? this.eventName,
        isHotEvent: isHotEvent ?? this.isHotEvent,
        locationLongitude: locationLongitude ?? this.locationLongitude,
        locationLatitude: locationLatitude ?? this.locationLatitude,
        timeRemaining: timeRemaining ?? this.timeRemaining,
        ticketPrice: ticketPrice ?? this.ticketPrice,
        pictureUrl: pictureUrl ?? this.pictureUrl,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['event_id'] = eventId;
    map['event_name'] = eventName;
    map['is_hot_event'] = isHotEvent;
    map['location_longitude'] = locationLongitude;
    map['location_latitude'] = locationLatitude;
    map['time_remaining'] = timeRemaining;
    map['ticket_price'] = ticketPrice;
    if (pictureUrl != null) {
      map['picture_url'] = pictureUrl?.toJson();
    }
    return map;
  }
}

PictureUrl pictureUrlFromJson(String str) =>
    PictureUrl.fromJson(json.decode(str));

String pictureUrlToJson(PictureUrl data) => json.encode(data.toJson());

class PictureUrl {
  PictureUrl({
    this.presignedUrl,
    this.fileExtension,
  });

  PictureUrl.fromJson(dynamic json) {
    presignedUrl = json['presigned_url'];
    fileExtension = json['file_extension'];
  }

  String? presignedUrl;
  String? fileExtension;

  PictureUrl copyWith({
    String? presignedUrl,
    String? fileExtension,
  }) =>
      PictureUrl(
        presignedUrl: presignedUrl ?? this.presignedUrl,
        fileExtension: fileExtension ?? this.fileExtension,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['presigned_url'] = presignedUrl;
    map['file_extension'] = fileExtension;
    return map;
  }
}

extension GetEventRequestMapper on GetAllEventsResponse {
  List<EventListDomainModel> mapToDomain() {
    return events?.map((event) {
          String? eventDate;
          String? eventTime;
          if (event.timeRemaining != null) {
            var eventDateConverted =
                convertToRequiredFormatDate(event.timeRemaining!);
            eventDate = eventDateConverted.toDayAndMonth();
            eventTime = eventDateConverted.formattedTime12Hour();
          } else {
            eventDate = "Not Provided";
            eventTime = "Not Mentioned";
          }
          var pictureUrl = event.pictureUrl?.presignedUrl;
          return EventListDomainModel(
            eventId: event.eventId.toString(),
            eventName: event.eventName ?? "",
            eventCoverImageUrl: pictureUrl ?? "",
            eventdate: eventDate,
            eventTime: eventTime,
            eventLocation: "Tap info button",
            eventOldPrice: event.ticketPrice.toString(),
            eventCurrentPrice: event.ticketPrice.toString(),
            daysLeft: event.timeRemaining?.toString() ?? "--",
            interestedProfiles: const [],
            isHotEvent: event.isHotEvent ?? false,
            location: {
              "lat": event.locationLatitude.toString(),
              "long": event.locationLongitude.toString()
            },
          );
        }).toList() ??
        [];
  }
}

DateTime convertToRequiredFormatDate(int daysRemaining) {
  return DateTime.now().add(Duration(days: daysRemaining));
}
