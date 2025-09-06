import 'dart:convert';

import 'package:glint_frontend/domain/business_logic/models/event/event_list_domain_model.dart';

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
        ? TimeRemaining.fromJson(json['time_remaining'])
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
  TimeRemaining? timeRemaining;
  int? ticketPrice;
  PictureUrl? pictureUrl;

  Events copyWith({
    int? eventId,
    String? eventName,
    bool? isHotEvent,
    double? locationLongitude,
    double? locationLatitude,
    TimeRemaining? timeRemaining,
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
    if (timeRemaining != null) {
      map['time_remaining'] = timeRemaining?.toJson();
    }
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

TimeRemaining timeRemainingFromJson(String str) =>
    TimeRemaining.fromJson(json.decode(str));

String timeRemainingToJson(TimeRemaining data) => json.encode(data.toJson());

class TimeRemaining {
  TimeRemaining({
    this.microseconds,
    this.days,
    this.months,
    this.valid,
  });

  TimeRemaining.fromJson(dynamic json) {
    microseconds = json['Microseconds'];
    days = json['Days'];
    months = json['Months'];
    valid = json['Valid'];
  }

  int? microseconds;
  int? days;
  int? months;
  bool? valid;

  TimeRemaining copyWith({
    int? microseconds,
    int? days,
    int? months,
    bool? valid,
  }) =>
      TimeRemaining(
        microseconds: microseconds ?? this.microseconds,
        days: days ?? this.days,
        months: months ?? this.months,
        valid: valid ?? this.valid,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Microseconds'] = microseconds;
    map['Days'] = days;
    map['Months'] = months;
    map['Valid'] = valid;
    return map;
  }
}

extension GetEventRequestMapper on GetAllEventsResponse {
  List<EventListDomainModel> mapToDomain() {
    return events?.map((event) {
          var pictureUrl =
              "${event.pictureUrl?.presignedUrl}${event.pictureUrl?.fileExtension}";
          return EventListDomainModel(
            eventId: event.eventId.toString(),
            eventName: event.eventName ?? "",
            eventCoverImageUrl: pictureUrl,
            eventdate: "Event Date - ",
            eventTime: "Event Time - ",
            eventLocation: "Event Location - ",
            eventOldPrice: "Event Price ",
            eventCurrentPrice: event.ticketPrice.toString() ?? "",
            daysLeft: event.timeRemaining?.days.toString() ?? "--",
            peopleInterested: 0,
            isHotEvent: event.isHotEvent ?? false,
            location: {
              "lat": event.locationLatitude.toString() ?? "",
              "long": event.locationLongitude.toString() ?? ""
            },
          );
        }).toList() ??
        [];
  }
}
