import 'dart:convert';
GetEventStatsResponse getEventStatsResponseFromJson(String str) => GetEventStatsResponse.fromJson(json.decode(str));
String getEventStatsResponseToJson(GetEventStatsResponse data) => json.encode(data.toJson());
class GetEventStatsResponse {
  GetEventStatsResponse({
      this.response,});

  GetEventStatsResponse.fromJson(dynamic json) {
    response = json['response'] != null ? Response.fromJson(json['response']) : null;
  }
  Response? response;
GetEventStatsResponse copyWith({  Response? response,
}) => GetEventStatsResponse(  response: response ?? this.response,
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
        ticketsBooked?.add(Dynamic.fromJson(v));
      });
    }
  }
  List<InterestedUserInfo>? interestedUserInfo;
  int? revenueGenerated;
  List<dynamic>? ticketsBooked;
Response copyWith({  List<InterestedUserInfo>? interestedUserInfo,
  int? revenueGenerated,
  List<dynamic>? ticketsBooked,
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

InterestedUserInfo interestedUserInfoFromJson(String str) => InterestedUserInfo.fromJson(json.decode(str));
String interestedUserInfoToJson(InterestedUserInfo data) => json.encode(data.toJson());
class InterestedUserInfo {
  InterestedUserInfo({
      this.userId, 
      this.username,});

  InterestedUserInfo.fromJson(dynamic json) {
    userId = json['user_id'];
    username = json['username'];
  }
  int? userId;
  String? username;
InterestedUserInfo copyWith({  int? userId,
  String? username,
}) => InterestedUserInfo(  userId: userId ?? this.userId,
  username: username ?? this.username,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user_id'] = userId;
    map['username'] = username;
    return map;
  }

}