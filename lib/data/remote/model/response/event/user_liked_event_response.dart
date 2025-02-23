import 'dart:convert';
/// message : "event liked successfully"

UserLikedEventResponse userLikedEventResponseFromJson(String str) => UserLikedEventResponse.fromJson(json.decode(str));
String userLikedEventResponseToJson(UserLikedEventResponse data) => json.encode(data.toJson());
class UserLikedEventResponse {
  UserLikedEventResponse({
      this.message,});

  UserLikedEventResponse.fromJson(dynamic json) {
    message = json['message'];
  }
  String? message;
UserLikedEventResponse copyWith({  String? message,
}) => UserLikedEventResponse(  message: message ?? this.message,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    return map;
  }

}