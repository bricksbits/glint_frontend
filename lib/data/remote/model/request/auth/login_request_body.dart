import 'dart:convert';
LoginRequestBody loginRequestBodyFromJson(String str) => LoginRequestBody.fromJson(json.decode(str));
String loginRequestBodyToJson(LoginRequestBody data) => json.encode(data.toJson());
class LoginRequestBody {
  LoginRequestBody({
      this.email, 
      this.password,});

  LoginRequestBody.fromJson(dynamic json) {
    email = json['email'];
    password = json['password'];
  }
  String? email;
  String? password;
LoginRequestBody copyWith({  String? email,
  String? password,
}) => LoginRequestBody(  email: email ?? this.email,
  password: password ?? this.password,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['email'] = email;
    map['password'] = password;
    return map;
  }

}