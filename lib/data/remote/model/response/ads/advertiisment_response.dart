import 'dart:convert';
AdvertiismentResponse advertiismentResponseFromJson(String str) => AdvertiismentResponse.fromJson(json.decode(str));
String advertiismentResponseToJson(AdvertiismentResponse data) => json.encode(data.toJson());
class AdvertiismentResponse {
  AdvertiismentResponse({
      this.ads,});

  AdvertiismentResponse.fromJson(dynamic json) {
    ads = json['ads'] != null ? json['ads'].cast<String>() : [];
  }
  List<String>? ads;
AdvertiismentResponse copyWith({  List<String>? ads,
}) => AdvertiismentResponse(  ads: ads ?? this.ads,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ads'] = ads;
    return map;
  }

}