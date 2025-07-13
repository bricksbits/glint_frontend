import 'dart:convert';

/// email_id : "user@example.com"

SendOtpRequestBody sendOtpRequestBodyFromJson(String str) =>
    SendOtpRequestBody.fromJson(json.decode(str));

String sendOtpRequestBodyToJson(SendOtpRequestBody data) =>
    json.encode(data.toJson());

class SendOtpRequestBody {
  SendOtpRequestBody({
    this.emailId,
  });

  SendOtpRequestBody.fromJson(dynamic json) {
    emailId = json['email_id'];
  }

  String? emailId;

  SendOtpRequestBody copyWith({
    String? emailId,
  }) =>
      SendOtpRequestBody(
        emailId: emailId ?? this.emailId,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['email_id'] = emailId;
    return map;
  }
} 