import 'dart:convert';
FcmTokenUpdatedResponse fcmTokenUpdatedResponseFromJson(String str) => FcmTokenUpdatedResponse.fromJson(json.decode(str));
String fcmTokenUpdatedResponseToJson(FcmTokenUpdatedResponse data) => json.encode(data.toJson());
class FcmTokenUpdatedResponse {
  FcmTokenUpdatedResponse({
      this.response,});

  FcmTokenUpdatedResponse.fromJson(dynamic json) {
    response = json['response'];
  }
  String? response;
FcmTokenUpdatedResponse copyWith({  String? response,
}) => FcmTokenUpdatedResponse(  response: response ?? this.response,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['response'] = response;
    return map;
  }

}