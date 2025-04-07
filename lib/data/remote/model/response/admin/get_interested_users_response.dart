import 'dart:convert';

import 'package:glint_frontend/domain/business_logic/models/admin/event_interested_user_domain_model.dart';

GetInterestedUsersResponse getInterestedUsersResponseFromJson(String str) =>
    GetInterestedUsersResponse.fromJson(json.decode(str));

String getInterestedUsersResponseToJson(GetInterestedUsersResponse data) =>
    json.encode(data.toJson());

class GetInterestedUsersResponse {
  GetInterestedUsersResponse({
    this.response,
  });

  GetInterestedUsersResponse.fromJson(dynamic json) {
    if (json['response'] != null) {
      response = [];
      json['response'].forEach((v) {
        response?.add(Response.fromJson(v));
      });
    }
  }

  List<Response>? response;

  GetInterestedUsersResponse copyWith({
    List<Response>? response,
  }) =>
      GetInterestedUsersResponse(
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
    this.userId,
    this.username,
  });

  Response.fromJson(dynamic json) {
    userId = json['user_id'];
    username = json['username'];
  }

  int? userId;
  String? username;

  Response copyWith({
    int? userId,
    String? username,
  }) =>
      Response(
        userId: userId ?? this.userId,
        username: username ?? this.username,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user_id'] = userId;
    map['username'] = username;
    return map;
  }
}

extension GetInterestedUsersMapper on GetInterestedUsersResponse {
  EventInterestedUserDomainModel mapToDomain() {
    return EventInterestedUserDomainModel(
        id: response?.first.userId.toString() ?? "",
        name: response?.first.username ?? "",
        emailId: response?.first.username ?? "",
        thumbnailUrl: response?.first.username ?? "");
  }
}
