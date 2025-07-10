import 'dart:convert';
GetTicketHistoryResponse getTicketHistoryResponseFromJson(String str) => GetTicketHistoryResponse.fromJson(json.decode(str));
String getTicketHistoryResponseToJson(GetTicketHistoryResponse data) => json.encode(data.toJson());
class GetTicketHistoryResponse {
  GetTicketHistoryResponse({
      this.tickets,});

  GetTicketHistoryResponse.fromJson(dynamic json) {
    if (json['tickets'] != null) {
      tickets = [];
      json['tickets'].forEach((v) {
        tickets?.add(Tickets.fromJson(v));
      });
    }
  }
  List<Tickets>? tickets;
GetTicketHistoryResponse copyWith({  List<Tickets>? tickets,
}) => GetTicketHistoryResponse(  tickets: tickets ?? this.tickets,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (tickets != null) {
      map['tickets'] = tickets?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

Tickets ticketsFromJson(String str) => Tickets.fromJson(json.decode(str));
String ticketsToJson(Tickets data) => json.encode(data.toJson());
class Tickets {
  Tickets({
      this.eventId, 
      this.eventName, 
      this.eventLocationName, 
      this.locationLongitude, 
      this.locationLatitude, 
      this.eventPictureUrl, 
      this.eventStartTime, 
      this.user1Id, 
      this.user1Username, 
      this.user1EmailId, 
      this.user1ProfilePictureUrl, 
      this.user2Id, 
      this.user2EmailId, 
      this.user2Username, 
      this.user2ProfilePictureUrl, 
      this.matchId, 
      this.bookedAtTime, 
      this.ticketPrice, 
      this.bookedStatus,});

  Tickets.fromJson(dynamic json) {
    eventId = json['event_id'];
    eventName = json['event_name'];
    eventLocationName = json['event_location_name'];
    locationLongitude = json['location_longitude'];
    locationLatitude = json['location_latitude'];
    eventPictureUrl = json['event_picture_url'] != null ? EventPictureUrl.fromJson(json['event_picture_url']) : null;
    eventStartTime = json['event_start_time'];
    user1Id = json['user1_id'];
    user1Username = json['user1_username'];
    user1EmailId = json['user1_email_id'];
    user1ProfilePictureUrl = json['user1_profile_picture_url'] != null ? User1ProfilePictureUrl.fromJson(json['user1_profile_picture_url']) : null;
    user2Id = json['user2_id'];
    user2EmailId = json['user2_email_id'];
    user2Username = json['user2_username'];
    user2ProfilePictureUrl = json['user2_profile_picture_url'] != null ? User2ProfilePictureUrl.fromJson(json['user2_profile_picture_url']) : null;
    matchId = json['match_id'];
    bookedAtTime = json['booked_at_time'];
    ticketPrice = json['ticket_price'];
    bookedStatus = json['booked_status'];
  }
  int? eventId;
  String? eventName;
  String? eventLocationName;
  double? locationLongitude;
  double? locationLatitude;
  EventPictureUrl? eventPictureUrl;
  String? eventStartTime;
  int? user1Id;
  String? user1Username;
  String? user1EmailId;
  User1ProfilePictureUrl? user1ProfilePictureUrl;
  int? user2Id;
  String? user2EmailId;
  String? user2Username;
  User2ProfilePictureUrl? user2ProfilePictureUrl;
  int? matchId;
  String? bookedAtTime;
  int? ticketPrice;
  String? bookedStatus;
Tickets copyWith({  int? eventId,
  String? eventName,
  String? eventLocationName,
  double? locationLongitude,
  double? locationLatitude,
  EventPictureUrl? eventPictureUrl,
  String? eventStartTime,
  int? user1Id,
  String? user1Username,
  String? user1EmailId,
  User1ProfilePictureUrl? user1ProfilePictureUrl,
  int? user2Id,
  String? user2EmailId,
  String? user2Username,
  User2ProfilePictureUrl? user2ProfilePictureUrl,
  int? matchId,
  String? bookedAtTime,
  int? ticketPrice,
  String? bookedStatus,
}) => Tickets(  eventId: eventId ?? this.eventId,
  eventName: eventName ?? this.eventName,
  eventLocationName: eventLocationName ?? this.eventLocationName,
  locationLongitude: locationLongitude ?? this.locationLongitude,
  locationLatitude: locationLatitude ?? this.locationLatitude,
  eventPictureUrl: eventPictureUrl ?? this.eventPictureUrl,
  eventStartTime: eventStartTime ?? this.eventStartTime,
  user1Id: user1Id ?? this.user1Id,
  user1Username: user1Username ?? this.user1Username,
  user1EmailId: user1EmailId ?? this.user1EmailId,
  user1ProfilePictureUrl: user1ProfilePictureUrl ?? this.user1ProfilePictureUrl,
  user2Id: user2Id ?? this.user2Id,
  user2EmailId: user2EmailId ?? this.user2EmailId,
  user2Username: user2Username ?? this.user2Username,
  user2ProfilePictureUrl: user2ProfilePictureUrl ?? this.user2ProfilePictureUrl,
  matchId: matchId ?? this.matchId,
  bookedAtTime: bookedAtTime ?? this.bookedAtTime,
  ticketPrice: ticketPrice ?? this.ticketPrice,
  bookedStatus: bookedStatus ?? this.bookedStatus,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['event_id'] = eventId;
    map['event_name'] = eventName;
    map['event_location_name'] = eventLocationName;
    map['location_longitude'] = locationLongitude;
    map['location_latitude'] = locationLatitude;
    if (eventPictureUrl != null) {
      map['event_picture_url'] = eventPictureUrl?.toJson();
    }
    map['event_start_time'] = eventStartTime;
    map['user1_id'] = user1Id;
    map['user1_username'] = user1Username;
    map['user1_email_id'] = user1EmailId;
    if (user1ProfilePictureUrl != null) {
      map['user1_profile_picture_url'] = user1ProfilePictureUrl?.toJson();
    }
    map['user2_id'] = user2Id;
    map['user2_email_id'] = user2EmailId;
    map['user2_username'] = user2Username;
    if (user2ProfilePictureUrl != null) {
      map['user2_profile_picture_url'] = user2ProfilePictureUrl?.toJson();
    }
    map['match_id'] = matchId;
    map['booked_at_time'] = bookedAtTime;
    map['ticket_price'] = ticketPrice;
    map['booked_status'] = bookedStatus;
    return map;
  }

}

User2ProfilePictureUrl user2ProfilePictureUrlFromJson(String str) => User2ProfilePictureUrl.fromJson(json.decode(str));
String user2ProfilePictureUrlToJson(User2ProfilePictureUrl data) => json.encode(data.toJson());
class User2ProfilePictureUrl {
  User2ProfilePictureUrl({
      this.presignedUrl, 
      this.fileExtension,});

  User2ProfilePictureUrl.fromJson(dynamic json) {
    presignedUrl = json['presigned_url'];
    fileExtension = json['file_extension'];
  }
  String? presignedUrl;
  String? fileExtension;
User2ProfilePictureUrl copyWith({  String? presignedUrl,
  String? fileExtension,
}) => User2ProfilePictureUrl(  presignedUrl: presignedUrl ?? this.presignedUrl,
  fileExtension: fileExtension ?? this.fileExtension,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['presigned_url'] = presignedUrl;
    map['file_extension'] = fileExtension;
    return map;
  }

}

User1ProfilePictureUrl user1ProfilePictureUrlFromJson(String str) => User1ProfilePictureUrl.fromJson(json.decode(str));
String user1ProfilePictureUrlToJson(User1ProfilePictureUrl data) => json.encode(data.toJson());
class User1ProfilePictureUrl {
  User1ProfilePictureUrl({
      this.presignedUrl, 
      this.fileExtension,});

  User1ProfilePictureUrl.fromJson(dynamic json) {
    presignedUrl = json['presigned_url'];
    fileExtension = json['file_extension'];
  }
  String? presignedUrl;
  String? fileExtension;
User1ProfilePictureUrl copyWith({  String? presignedUrl,
  String? fileExtension,
}) => User1ProfilePictureUrl(  presignedUrl: presignedUrl ?? this.presignedUrl,
  fileExtension: fileExtension ?? this.fileExtension,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['presigned_url'] = presignedUrl;
    map['file_extension'] = fileExtension;
    return map;
  }

}

EventPictureUrl eventPictureUrlFromJson(String str) => EventPictureUrl.fromJson(json.decode(str));
String eventPictureUrlToJson(EventPictureUrl data) => json.encode(data.toJson());
class EventPictureUrl {
  EventPictureUrl({
      this.presignedUrl, 
      this.fileExtension,});

  EventPictureUrl.fromJson(dynamic json) {
    presignedUrl = json['presigned_url'];
    fileExtension = json['file_extension'];
  }
  String? presignedUrl;
  String? fileExtension;
EventPictureUrl copyWith({  String? presignedUrl,
  String? fileExtension,
}) => EventPictureUrl(  presignedUrl: presignedUrl ?? this.presignedUrl,
  fileExtension: fileExtension ?? this.fileExtension,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['presigned_url'] = presignedUrl;
    map['file_extension'] = fileExtension;
    return map;
  }

}