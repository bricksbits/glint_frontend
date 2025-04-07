import 'dart:convert';
RefreshAuthTokenResponse refreshAuthTokenResponseFromJson(String str) => RefreshAuthTokenResponse.fromJson(json.decode(str));
String refreshAuthTokenResponseToJson(RefreshAuthTokenResponse data) => json.encode(data.toJson());
class RefreshAuthTokenResponse {
  RefreshAuthTokenResponse({
      String? accessToken, 
      String? refreshToken,}){
    _accessToken = accessToken;
    _refreshToken = refreshToken;
}

  RefreshAuthTokenResponse.fromJson(dynamic json) {
    _accessToken = json['access_token'];
    _refreshToken = json['refresh_token'];
  }
  String? _accessToken;
  String? _refreshToken;
RefreshAuthTokenResponse copyWith({  String? accessToken,
  String? refreshToken,
}) => RefreshAuthTokenResponse(  accessToken: accessToken ?? _accessToken,
  refreshToken: refreshToken ?? _refreshToken,
);
  String? get accessToken => _accessToken;
  String? get refreshToken => _refreshToken;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['access_token'] = _accessToken;
    map['refresh_token'] = _refreshToken;
    return map;
  }

}