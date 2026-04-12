import 'dart:convert';
GetTicketBookedResponse getTicketBookedResponseFromJson(String str) => GetTicketBookedResponse.fromJson(json.decode(str));
String getTicketBookedResponseToJson(GetTicketBookedResponse data) => json.encode(data.toJson());
class GetTicketBookedResponse {
  GetTicketBookedResponse({
      this.response,});

  GetTicketBookedResponse.fromJson(dynamic json) {
    final list = json is List ? json : json['data'];
    if (list != null) {
      response = [];
      list.forEach((v) {
        response?.add(Response.fromJson(v));
      });
    }
  }
  List<Response>? response;
GetTicketBookedResponse copyWith({  List<Response>? response,
}) => GetTicketBookedResponse(  response: response ?? this.response,
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
      this.user1Id, 
      this.user1Username, 
      this.user1EmailId, 
      this.user1ProfilePictureUrl, 
      this.user2Id, 
      this.user2EmailId, 
      this.user2Username, 
      this.user2ProfilePictureUrl, 
      this.matchId, 
      this.bookedAtTime,});

  Response.fromJson(dynamic json) {
    user1Id = json['user_1_id'];
    user1Username = json['user_1_username'];
    user1EmailId = json['user_1_email_id'];
    user1ProfilePictureUrl = json['user_1_profile_picture_url'] != null ? User1ProfilePictureUrl.fromJson(json['user_1_profile_picture_url']) : null;
    user2Id = json['user_2_id'];
    user2EmailId = json['user_2_email_id'];
    user2Username = json['user_2_username'];
    user2ProfilePictureUrl = json['user_2_profile_picture_url'] != null ? User2ProfilePictureUrl.fromJson(json['user_2_profile_picture_url']) : null;
    matchId = json['match_id'];
    bookedAtTime = json['booked_at_time'];
  }
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
Response copyWith({  int? user1Id,
  String? user1Username,
  String? user1EmailId,
  User1ProfilePictureUrl? user1ProfilePictureUrl,
  int? user2Id,
  String? user2EmailId,
  String? user2Username,
  User2ProfilePictureUrl? user2ProfilePictureUrl,
  int? matchId,
  String? bookedAtTime,
}) => Response(  user1Id: user1Id ?? this.user1Id,
  user1Username: user1Username ?? this.user1Username,
  user1EmailId: user1EmailId ?? this.user1EmailId,
  user1ProfilePictureUrl: user1ProfilePictureUrl ?? this.user1ProfilePictureUrl,
  user2Id: user2Id ?? this.user2Id,
  user2EmailId: user2EmailId ?? this.user2EmailId,
  user2Username: user2Username ?? this.user2Username,
  user2ProfilePictureUrl: user2ProfilePictureUrl ?? this.user2ProfilePictureUrl,
  matchId: matchId ?? this.matchId,
  bookedAtTime: bookedAtTime ?? this.bookedAtTime,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user_1_id'] = user1Id;
    map['user_1_username'] = user1Username;
    map['user_1_email_id'] = user1EmailId;
    if (user1ProfilePictureUrl != null) {
      map['user_1_profile_picture_url'] = user1ProfilePictureUrl?.toJson();
    }
    map['user_2_id'] = user2Id;
    map['user_2_email_id'] = user2EmailId;
    map['user_2_username'] = user2Username;
    if (user2ProfilePictureUrl != null) {
      map['user_2_profile_picture_url'] = user2ProfilePictureUrl?.toJson();
    }
    map['match_id'] = matchId;
    map['booked_at_time'] = bookedAtTime;
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