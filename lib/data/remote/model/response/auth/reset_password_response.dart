import 'dart:convert';
/// message : "password reset successfully."

ResetPasswordResponse resetPasswordResponseFromJson(String str) => ResetPasswordResponse.fromJson(json.decode(str));
String resetPasswordResponseToJson(ResetPasswordResponse data) => json.encode(data.toJson());
class ResetPasswordResponse {
  ResetPasswordResponse({
      this.message,});

  ResetPasswordResponse.fromJson(dynamic json) {
    message = json['message'];
  }
  String? message;
ResetPasswordResponse copyWith({  String? message,
}) => ResetPasswordResponse(  message: message ?? this.message,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    return map;
  }

}