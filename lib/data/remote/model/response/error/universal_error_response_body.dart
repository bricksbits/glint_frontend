import 'dart:convert';
UniversalErrorResponseBody universalErrorResponseBodyFromJson(String str) => UniversalErrorResponseBody.fromJson(json.decode(str));
String universalErrorResponseBodyToJson(UniversalErrorResponseBody data) => json.encode(data.toJson());
class UniversalErrorResponseBody {
  UniversalErrorResponseBody({
      this.success, 
      this.error,});

  UniversalErrorResponseBody.fromJson(dynamic json) {
    success = json['success'];
    error = json['error'] != null ? Error.fromJson(json['error']) : null;
  }
  bool? success;
  Error? error;
UniversalErrorResponseBody copyWith({  bool? success,
  Error? error,
}) => UniversalErrorResponseBody(  success: success ?? this.success,
  error: error ?? this.error,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    if (error != null) {
      map['error'] = error?.toJson();
    }
    return map;
  }

}

Error errorFromJson(String str) => Error.fromJson(json.decode(str));
String errorToJson(Error data) => json.encode(data.toJson());
class Error {
  Error({
      this.code, 
      this.message, 
      this.details,});

  Error.fromJson(dynamic json) {
    code = json['code'];
    message = json['message'];
    details = json['details'] != null ? Details.fromJson(json['details']) : null;
  }
  String? code;
  String? message;
  Details? details;
Error copyWith({  String? code,
  String? message,
  Details? details,
}) => Error(  code: code ?? this.code,
  message: message ?? this.message,
  details: details ?? this.details,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = code;
    map['message'] = message;
    if (details != null) {
      map['details'] = details?.toJson();
    }
    return map;
  }

}

Details detailsFromJson(String str) => Details.fromJson(json.decode(str));
String detailsToJson(Details data) => json.encode(data.toJson());
class Details {
  Details({
      this.username,});

  Details.fromJson(dynamic json) {
    username = json['username'];
  }
  String? username;
Details copyWith({  String? username,
}) => Details(  username: username ?? this.username,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['username'] = username;
    return map;
  }

}