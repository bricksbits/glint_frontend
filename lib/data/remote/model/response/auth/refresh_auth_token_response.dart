import 'dart:convert';
RefreshAuthTokenResponse refreshAuthTokenResponseFromJson(String str) => RefreshAuthTokenResponse.fromJson(json.decode(str));
String refreshAuthTokenResponseToJson(RefreshAuthTokenResponse data) => json.encode(data.toJson());
class RefreshAuthTokenResponse {
  RefreshAuthTokenResponse({
      String? accessToken,
      String? refreshToken,
      String? streamAuthToken,}){
    _accessToken = accessToken;
    _refreshToken = refreshToken;
    _streamAuthToken = streamAuthToken;
}

  RefreshAuthTokenResponse.fromJson(dynamic json) {
    _accessToken = json['access_token'];
    _refreshToken = json['refresh_token'];
    _streamAuthToken = json['stream_token'];
  }
  String? _accessToken;
  String? _refreshToken;
  String? _streamAuthToken;

RefreshAuthTokenResponse copyWith({
  String? accessToken,
  String? refreshToken,
  String? streamAuthToken,
}) => RefreshAuthTokenResponse(
  accessToken: accessToken ?? _accessToken,
  refreshToken: refreshToken ?? _refreshToken,
  streamAuthToken: streamAuthToken ?? _streamAuthToken,
);
  String? get accessToken => _accessToken;
  String? get refreshToken => _refreshToken;
  String? get streamAuthToken => _streamAuthToken;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['access_token'] = _accessToken;
    map['refresh_token'] = _refreshToken;
    map['stream_token'] = _streamAuthToken;
    return map;
  }

}