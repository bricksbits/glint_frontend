import 'dart:convert';
LoginRequestBody loginRequestBodyFromJson(String str) => LoginRequestBody.fromJson(json.decode(str));
String loginRequestBodyToJson(LoginRequestBody data) => json.encode(data.toJson());
class LoginRequestBody {
  LoginRequestBody({
      String? username, 
      String? password,}){
    _username = username;
    _password = password;
}

  LoginRequestBody.fromJson(dynamic json) {
    _username = json['username'];
    _password = json['password'];
  }
  String? _username;
  String? _password;
LoginRequestBody copyWith({  String? username,
  String? password,
}) => LoginRequestBody(  username: username ?? _username,
  password: password ?? _password,
);
  String? get username => _username;
  String? get password => _password;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['username'] = _username;
    map['password'] = _password;
    return map;
  }

}