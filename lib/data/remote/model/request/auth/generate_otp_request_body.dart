import 'dart:convert';
GenerateOtpRequestBody generateOtpRequestBodyFromJson(String str) => GenerateOtpRequestBody.fromJson(json.decode(str));
String generateOtpRequestBodyToJson(GenerateOtpRequestBody data) => json.encode(data.toJson());
class GenerateOtpRequestBody {
  GenerateOtpRequestBody({
      this.emailId,});

  GenerateOtpRequestBody.fromJson(dynamic json) {
    emailId = json['email_id'];
  }
  String? emailId;
GenerateOtpRequestBody copyWith({  String? emailId,
}) => GenerateOtpRequestBody(  emailId: emailId ?? this.emailId,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['email_id'] = emailId;
    return map;
  }

}