import 'dart:convert';
ProfileDeleteMediaRequestBody profileDeleteMediaRequestBodyFromJson(String str) => ProfileDeleteMediaRequestBody.fromJson(json.decode(str));
String profileDeleteMediaRequestBodyToJson(ProfileDeleteMediaRequestBody data) => json.encode(data.toJson());
class ProfileDeleteMediaRequestBody {
  ProfileDeleteMediaRequestBody({
      this.pictureList, 
      this.videoList,});

  ProfileDeleteMediaRequestBody.fromJson(dynamic json) {
    pictureList = json['picture_list'] != null ? json['picture_list'].cast<String>() : [];
    videoList = [];
  }
  List<String>? pictureList;
  List<dynamic>? videoList;
ProfileDeleteMediaRequestBody copyWith({  List<String>? pictureList,
  List<dynamic>? videoList,
}) => ProfileDeleteMediaRequestBody(  pictureList: pictureList ?? this.pictureList,
  videoList: videoList ?? this.videoList,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['picture_list'] = pictureList;
    if (videoList != null) {
      map['video_list'] = videoList?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}