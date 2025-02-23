import 'dart:convert';

/// event_details : {"coordinator_user_id":3,"coordinator_user_phone_number":"1234567890","coordinator_user_username":"NP","event_description":"the annual trek","start_time":"2025-12-13T15:00:00Z","end_time":"2025-12-15T15:00:00Z","picture_url_list":[],"video_url_list":[]}

EventDetailsResponse eventDetailsResponseFromJson(String str) =>
    EventDetailsResponse.fromJson(json.decode(str));

String eventDetailsResponseToJson(EventDetailsResponse data) =>
    json.encode(data.toJson());

class EventDetailsResponse {
  EventDetailsResponse({
    this.eventDetails,
  });

  EventDetailsResponse.fromJson(dynamic json) {
    eventDetails = json['event_details'] != null
        ? EventDetails.fromJson(json['event_details'])
        : null;
  }

  EventDetails? eventDetails;

  EventDetailsResponse copyWith({
    EventDetails? eventDetails,
  }) =>
      EventDetailsResponse(
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

/// coordinator_user_id : 3
/// coordinator_user_phone_number : "1234567890"
/// coordinator_user_username : "NP"
/// event_description : "the annual trek"
/// start_time : "2025-12-13T15:00:00Z"
/// end_time : "2025-12-15T15:00:00Z"
/// picture_url_list : []
/// video_url_list : []

EventDetails eventDetailsFromJson(String str) =>
    EventDetails.fromJson(json.decode(str));

String eventDetailsToJson(EventDetails data) => json.encode(data.toJson());

class EventDetails {
  EventDetails({
    this.coordinatorUserId,
    this.coordinatorUserPhoneNumber,
    this.coordinatorUserUsername,
    this.eventDescription,
    this.startTime,
    this.endTime,
    this.pictureUrlList,
    this.videoUrlList,
  });

  EventDetails.fromJson(dynamic json) {
    coordinatorUserId = json['coordinator_user_id'];
    coordinatorUserPhoneNumber = json['coordinator_user_phone_number'];
    coordinatorUserUsername = json['coordinator_user_username'];
    eventDescription = json['event_description'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    pictureUrlList = json['picture_url_list'] != null
        ? List<String>.from(json['picture_url_list'])
        : [];
    videoUrlList = json['video_url_list'] != null
        ? List<String>.from(json['video_url_list'])
        : [];
  }

  num? coordinatorUserId;
  String? coordinatorUserPhoneNumber;
  String? coordinatorUserUsername;
  String? eventDescription;
  String? startTime;
  String? endTime;
  List<dynamic>? pictureUrlList;
  List<dynamic>? videoUrlList;

  EventDetails copyWith({
    num? coordinatorUserId,
    String? coordinatorUserPhoneNumber,
    String? coordinatorUserUsername,
    String? eventDescription,
    String? startTime,
    String? endTime,
    List<dynamic>? pictureUrlList,
    List<dynamic>? videoUrlList,
  }) =>
      EventDetails(
        coordinatorUserId: coordinatorUserId ?? this.coordinatorUserId,
        coordinatorUserPhoneNumber:
            coordinatorUserPhoneNumber ?? this.coordinatorUserPhoneNumber,
        coordinatorUserUsername:
            coordinatorUserUsername ?? this.coordinatorUserUsername,
        eventDescription: eventDescription ?? this.eventDescription,
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
    map['event_description'] = eventDescription;
    map['start_time'] = startTime;
    map['end_time'] = endTime;
    map['picture_url_list'] = pictureUrlList;
    map['video_url_list'] = videoUrlList;
    return map;
  }
}
