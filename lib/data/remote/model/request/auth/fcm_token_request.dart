import 'dart:convert';
FcmTokenRequest fcmTokenRequestFromJson(String str) => FcmTokenRequest.fromJson(json.decode(str));
String fcmTokenRequestToJson(FcmTokenRequest data) => json.encode(data.toJson());
class FcmTokenRequest {
  FcmTokenRequest({
      this.fcmToken,});

  FcmTokenRequest.fromJson(dynamic json) {
    fcmToken = json['fcm_token'];
  }
  String? fcmToken;
FcmTokenRequest copyWith({  String? fcmToken,
}) => FcmTokenRequest(  fcmToken: fcmToken ?? this.fcmToken,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['fcm_token'] = fcmToken;
    return map;
  }

}