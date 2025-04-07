import 'dart:convert';

import 'package:glint_frontend/domain/business_logic/models/admin/event_interested_user_domain_model.dart';
import 'package:glint_frontend/domain/business_logic/models/admin/event_ticket_bought_domain_model.dart';

GetTicketBookedResponse getTicketBookedResponseFromJson(String str) =>
    GetTicketBookedResponse.fromJson(json.decode(str));

String getTicketBookedResponseToJson(GetTicketBookedResponse data) =>
    json.encode(data.toJson());

class GetTicketBookedResponse {
  GetTicketBookedResponse({
    this.response,
  });

  GetTicketBookedResponse.fromJson(dynamic json) {
    if (json['response'] != null) {
      response = [];
      json['response'].forEach((v) {
        response?.add(Response.fromJson(v));
      });
    }
  }

  List<Response>? response;

  GetTicketBookedResponse copyWith({
    List<Response>? response,
  }) =>
      GetTicketBookedResponse(
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

extension GetTicketBoughtUsersResponseMappper on GetTicketBookedResponse {
  EventTicketBoughtDomainModel mapToDomain() {
    return EventTicketBoughtDomainModel(
        EventInterestedUserDomainModel(
            id: response?.first.userId.toString() ?? "",
            name: response?.first.username ?? "",
            emailId: response?.first.username ?? "",
            thumbnailUrl: response?.first.username ?? ""),
        EventInterestedUserDomainModel(
            id: response?.first.userId.toString() ?? "",
            name: response?.first.username ?? "",
            emailId: response?.first.username ?? "",
            thumbnailUrl: response?.first.username ?? ""));
  }
}
