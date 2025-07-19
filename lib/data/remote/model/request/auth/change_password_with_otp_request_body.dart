import 'dart:convert';
ChangePasswordWithOtpRequestBody changePasswordWithOtpRequestBodyFromJson(String str) => ChangePasswordWithOtpRequestBody.fromJson(json.decode(str));
String changePasswordWithOtpRequestBodyToJson(ChangePasswordWithOtpRequestBody data) => json.encode(data.toJson());
class ChangePasswordWithOtpRequestBody {
  ChangePasswordWithOtpRequestBody({
      this.emailId, 
      this.newPassword, 
      this.passwordResetOtp,});

  ChangePasswordWithOtpRequestBody.fromJson(dynamic json) {
    emailId = json['email_id'];
    newPassword = json['new_password'];
    passwordResetOtp = json['password_reset_otp'];
  }
  String? emailId;
  String? newPassword;
  String? passwordResetOtp;
ChangePasswordWithOtpRequestBody copyWith({  String? emailId,
  String? newPassword,
  String? passwordResetOtp,
}) => ChangePasswordWithOtpRequestBody(  emailId: emailId ?? this.emailId,
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