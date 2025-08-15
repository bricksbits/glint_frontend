import 'dart:convert';
GetEventStatsForAdmin getEventStatsForAdminFromJson(String str) => GetEventStatsForAdmin.fromJson(json.decode(str));
String getEventStatsForAdminToJson(GetEventStatsForAdmin data) => json.encode(data.toJson());
class GetEventStatsForAdmin {
  GetEventStatsForAdmin({
      this.response,});

  GetEventStatsForAdmin.fromJson(dynamic json) {
    response = json['response'] != null ? Response.fromJson(json['response']) : null;
  }
  Response? response;
GetEventStatsForAdmin copyWith({  Response? response,
}) => GetEventStatsForAdmin(  response: response ?? this.response,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (response != null) {
      map['response'] = response?.toJson();
    }
    return map;
  }

}

Response responseFromJson(String str) => Response.fromJson(json.decode(str));
String responseToJson(Response data) => json.encode(data.toJson());
class Response {
  Response({
      this.interestedUserInfo, 
      this.revenueGenerated, 
      this.ticketsBooked,});

  Response.fromJson(dynamic json) {
    if (json['interested_user_info'] != null) {
      interestedUserInfo = [];
      json['interested_user_info'].forEach((v) {
        interestedUserInfo?.add(InterestedUserInfo.fromJson(v));
      });
    }
    revenueGenerated = json['revenue_generated'];
    if (json['tickets_booked'] != null) {
      ticketsBooked = [];
      json['tickets_booked'].forEach((v) {
        ticketsBooked?.add(TicketsBooked.fromJson(v));
      });
    }
  }
  List<InterestedUserInfo>? interestedUserInfo;
  int? revenueGenerated;
  List<TicketsBooked>? ticketsBooked;
Response copyWith({  List<InterestedUserInfo>? interestedUserInfo,
  int? revenueGenerated,
  List<TicketsBooked>? ticketsBooked,
}) => Response(  interestedUserInfo: interestedUserInfo ?? this.interestedUserInfo,
  revenueGenerated: revenueGenerated ?? this.revenueGenerated,
  ticketsBooked: ticketsBooked ?? this.ticketsBooked,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (interestedUserInfo != null) {
      map['interested_user_info'] = interestedUserInfo?.map((v) => v.toJson()).toList();
    }
    map['revenue_generated'] = revenueGenerated;
    if (ticketsBooked != null) {
      map['tickets_booked'] = ticketsBooked?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

TicketsBooked ticketsBookedFromJson(String str) => TicketsBooked.fromJson(json.decode(str));
String ticketsBookedToJson(TicketsBooked data) => json.encode(data.toJson());
class TicketsBooked {
  TicketsBooked({
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

  TicketsBooked.fromJson(dynamic json) {
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
TicketsBooked copyWith({  int? user1Id,
  String? user1Username,
  String? user1EmailId,
  User1ProfilePictureUrl? user1ProfilePictureUrl,
  int? user2Id,
  String? user2EmailId,
  String? user2Username,
  User2ProfilePictureUrl? user2ProfilePictureUrl,
  int? matchId,
  String? bookedAtTime,
}) => TicketsBooked(  user1Id: user1Id ?? this.user1Id,
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

InterestedUserInfo interestedUserInfoFromJson(String str) => InterestedUserInfo.fromJson(json.decode(str));
String interestedUserInfoToJson(InterestedUserInfo data) => json.encode(data.toJson());
class InterestedUserInfo {
  InterestedUserInfo({
      this.userId, 
      this.username, 
      this.emailId, 
      this.profilePicture,});

  InterestedUserInfo.fromJson(dynamic json) {
    userId = json['user_id'];
    username = json['username'];
    emailId = json['email_id'];
    profilePicture = json['profile_picture'] != null ? ProfilePicture.fromJson(json['profile_picture']) : null;
  }
  int? userId;
  String? username;
  String? emailId;
  ProfilePicture? profilePicture;
InterestedUserInfo copyWith({  int? userId,
  String? username,
  String? emailId,
  ProfilePicture? profilePicture,
}) => InterestedUserInfo(  userId: userId ?? this.userId,
  username: username ?? this.username,
  emailId: emailId ?? this.emailId,
  profilePicture: profilePicture ?? this.profilePicture,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user_id'] = userId;
    map['username'] = username;
    map['email_id'] = emailId;
    if (profilePicture != null) {
      map['profile_picture'] = profilePicture?.toJson();
    }
    return map;
  }

}

ProfilePicture profilePictureFromJson(String str) => ProfilePicture.fromJson(json.decode(str));
String profilePictureToJson(ProfilePicture data) => json.encode(data.toJson());
class ProfilePicture {
  ProfilePicture({
      this.presignedUrl, 
      this.fileExtension,});

  ProfilePicture.fromJson(dynamic json) {
    presignedUrl = json['presigned_url'];
    fileExtension = json['file_extension'];
  }
  String? presignedUrl;
  String? fileExtension;
ProfilePicture copyWith({  String? presignedUrl,
  String? fileExtension,
}) => ProfilePicture(  presignedUrl: presignedUrl ?? this.presignedUrl,
  fileExtension: fileExtension ?? this.fileExtension,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['presigned_url'] = presignedUrl;
    map['file_extension'] = fileExtension;
    return map;
  }

}