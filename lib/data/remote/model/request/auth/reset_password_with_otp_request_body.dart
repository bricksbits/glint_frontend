import 'dart:convert';

/// email_id : "user@example.com"
/// new_password : "newPassword123"
/// password_reset_otp : "123456"

ResetPasswordWithOtpRequestBody resetPasswordWithOtpRequestBodyFromJson(String str) =>
    ResetPasswordWithOtpRequestBody.fromJson(json.decode(str));

String resetPasswordWithOtpRequestBodyToJson(ResetPasswordWithOtpRequestBody data) =>
    json.encode(data.toJson());

class ResetPasswordWithOtpRequestBody {
  ResetPasswordWithOtpRequestBody({
    this.emailId,
    this.newPassword,
    this.passwordResetOtp,
  });

  ResetPasswordWithOtpRequestBody.fromJson(dynamic json) {
    emailId = json['email_id'];
    newPassword = json['new_password'];
    passwordResetOtp = json['password_reset_otp'];
  }

  String? emailId;
  String? newPassword;
  String? passwordResetOtp;

  ResetPasswordWithOtpRequestBody copyWith({
    String? emailId,
    String? newPassword,
    String? passwordResetOtp,
  }) =>
      ResetPasswordWithOtpRequestBody(
        emailId: emailId ?? this.emailId,
        newPassword: newPassword ?? this.newPassword,
        passwordResetOtp: passwordResetOtp ?? this.passwordResetOtp,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['email_id'] = emailId;
    map['new_password'] = newPassword;
    map['password_reset_otp'] = passwordResetOtp;
    return map;
  }
} 