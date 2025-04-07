import 'dart:convert';

TicketHistory ticketHistoryFromJson(String str) =>
    TicketHistory.fromJson(json.decode(str));

String ticketHistoryToJson(TicketHistory data) => json.encode(data.toJson());

class TicketHistory {
  TicketHistory({
    this.eventId,
    this.user1Id,
    this.user2Id,
    this.matchId,
    this.eventName,
    this.locationLongitude,
    this.locationLatitude,
    this.timeRemaining,
    this.eventPictureUrl,
  });

  TicketHistory.fromJson(dynamic json) {
    eventId = json['event_id'];
    user1Id = json['user1_id'];
    user2Id = json['user2_id'];
    matchId = json['match_id'];
    eventName = json['event_name'];
    locationLongitude = json['location_longitude']?.toDouble();
    locationLatitude = json['location_latitude']?.toDouble();
    timeRemaining = json['time_remaining'] != null
        ? TimeRemaining.fromJson(json['time_remaining'])
        : null;
    eventPictureUrl = json['event_picture_url'];
  }

  int? eventId;
  int? user1Id;
  int? user2Id;
  int? matchId;
  String? eventName;
  double? locationLongitude;
  double? locationLatitude;
  TimeRemaining? timeRemaining;
  String? eventPictureUrl;

  TicketHistory copyWith({
    int? eventId,
    int? user1Id,
    int? user2Id,
    int? matchId,
    String? eventName,
    double? locationLongitude,
    double? locationLatitude,
    TimeRemaining? timeRemaining,
    String? eventPictureUrl,
  }) =>
      TicketHistory(
        eventId: eventId ?? this.eventId,
        user1Id: user1Id ?? this.user1Id,
        user2Id: user2Id ?? this.user2Id,
        matchId: matchId ?? this.matchId,
        eventName: eventName ?? this.eventName,
        locationLongitude: locationLongitude ?? this.locationLongitude,
        locationLatitude: locationLatitude ?? this.locationLatitude,
        timeRemaining: timeRemaining ?? this.timeRemaining,
        eventPictureUrl: eventPictureUrl ?? this.eventPictureUrl,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['event_id'] = eventId;
    map['user1_id'] = user1Id;
    map['user2_id'] = user2Id;
    map['match_id'] = matchId;
    map['event_name'] = eventName;
    map['location_longitude'] = locationLongitude;
    map['location_latitude'] = locationLatitude;
    if (timeRemaining != null) {
      map['time_remaining'] = timeRemaining?.toJson();
    }
    map['event_picture_url'] = eventPictureUrl;
    return map;
  }
}

TimeRemaining timeRemainingFromJson(String str) =>
    TimeRemaining.fromJson(json.decode(str));

String timeRemainingToJson(TimeRemaining data) => json.encode(data.toJson());

class TimeRemaining {
  TimeRemaining({
    this.months,
    this.days,
    this.hours,
    this.minutes,
    this.seconds,
  });

  TimeRemaining.fromJson(dynamic json) {
    months = json['months'];
    days = json['days'];
    hours = json['hours'];
    minutes = json['minutes'];
    seconds = json['seconds'];
  }

  int? months;
  int? days;
  int? hours;
  int? minutes;
  int? seconds;

  TimeRemaining copyWith({
    int? months,
    int? days,
    int? hours,
    int? minutes,
    int? seconds,
  }) =>
      TimeRemaining(
        months: months ?? this.months,
        days: days ?? this.days,
        hours: hours ?? this.hours,
        minutes: minutes ?? this.minutes,
        seconds: seconds ?? this.seconds,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['months'] = months;
    map['days'] = days;
    map['hours'] = hours;
    map['minutes'] = minutes;
    map['seconds'] = seconds;
    return map;
  }
}
