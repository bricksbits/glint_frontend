import 'dart:convert';
GenerateOtpResponseBody generateOtpResponseBodyFromJson(String str) => GenerateOtpResponseBody.fromJson(json.decode(str));
String generateOtpResponseBodyToJson(GenerateOtpResponseBody data) => json.encode(data.toJson());
class GenerateOtpResponseBody {
  GenerateOtpResponseBody({
      this.message,});

  GenerateOtpResponseBody.fromJson(dynamic json) {
    message = json['message'];
  }
  String? message;
GenerateOtpResponseBody copyWith({  String? message,
}) => GenerateOtpResponseBody(  message: message ?? this.message,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    return map;
  }

}