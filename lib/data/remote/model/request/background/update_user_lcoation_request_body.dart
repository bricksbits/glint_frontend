import 'dart:convert';
UpdateUserLcoationRequestBody updateUserLcoationRequestBodyFromJson(String str) => UpdateUserLcoationRequestBody.fromJson(json.decode(str));
String updateUserLcoationRequestBodyToJson(UpdateUserLcoationRequestBody data) => json.encode(data.toJson());
class UpdateUserLcoationRequestBody {
  UpdateUserLcoationRequestBody({
      this.userId, 
      this.longitude, 
      this.latitide,});

  UpdateUserLcoationRequestBody.fromJson(dynamic json) {
    userId = json['user_id'];
    longitude = json['longitude'];
    latitide = json['latitide'];
  }
  int? userId;
  double? longitude;
  double? latitide;
UpdateUserLcoationRequestBody copyWith({  int? userId,
  double? longitude,
  double? latitide,
}) => UpdateUserLcoationRequestBody(  userId: userId ?? this.userId,
  longitude: longitude ?? this.longitude,
  latitide: latitide ?? this.latitide,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user_id'] = userId;
    map['longitude'] = longitude;
    map['latitide'] = latitide;
    return map;
  }

}