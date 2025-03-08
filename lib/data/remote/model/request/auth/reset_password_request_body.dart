import 'dart:convert';

/// user_id : 3
/// new_password : "1234"

ResetPasswordRequestBody resetPasswordRequestBodyFromJson(String str) =>
    ResetPasswordRequestBody.fromJson(json.decode(str));

String resetPasswordRequestBodyToJson(ResetPasswordRequestBody data) =>
    json.encode(data.toJson());

class ResetPasswordRequestBody {
  ResetPasswordRequestBody({
    this.userId,
    this.newPassword,
  });

  ResetPasswordRequestBody.fromJson(dynamic json) {
    userId = json['user_id'];
    newPassword = json['new_password'];
  }

  num? userId;
  String? newPassword;

  ResetPasswordRequestBody copyWith({
    num? userId,
    String? newPassword,
  }) =>
      ResetPasswordRequestBody(
        userId: userId ?? this.userId,
        newPassword: newPassword ?? this.newPassword,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user_id'] = userId;
    map['new_password'] = newPassword;
    return map;
  }
}
