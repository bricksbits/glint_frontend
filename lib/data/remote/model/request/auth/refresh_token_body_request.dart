import 'dart:convert';

RefreshTokenBodyRequest refreshTokenBodyRequestFromJson(String str) =>
    RefreshTokenBodyRequest.fromJson(json.decode(str));

String refreshTokenBodyRequestToJson(RefreshTokenBodyRequest data) =>
    json.encode(data.toJson());

class RefreshTokenBodyRequest {
  RefreshTokenBodyRequest({
    this.refreshToken,
  });

  RefreshTokenBodyRequest.fromJson(dynamic json) {
    refreshToken = json['refresh_token'];
  }

  String? refreshToken;

  RefreshTokenBodyRequest copyWith({
    String? refreshToken,
  }) =>
      RefreshTokenBodyRequest(
        refreshToken: refreshToken ?? this.refreshToken,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['refresh_token'] = refreshToken;
    return map;
  }
}
