import 'dart:convert';
LikeStoryRequestBody likeStoryRequestBodyFromJson(String str) => LikeStoryRequestBody.fromJson(json.decode(str));
String likeStoryRequestBodyToJson(LikeStoryRequestBody data) => json.encode(data.toJson());
class LikeStoryRequestBody {
  LikeStoryRequestBody({
      this.storyOwnerUserId, 
      this.storyUuid,});

  LikeStoryRequestBody.fromJson(dynamic json) {
    storyOwnerUserId = json['story_owner_user_id'];
    storyUuid = json['story_uuid'];
  }
  int? storyOwnerUserId;
  String? storyUuid;
LikeStoryRequestBody copyWith({  int? storyOwnerUserId,
  String? storyUuid,
}) => LikeStoryRequestBody(  storyOwnerUserId: storyOwnerUserId ?? this.storyOwnerUserId,
  storyUuid: storyUuid ?? this.storyUuid,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['story_owner_user_id'] = storyOwnerUserId;
    map['story_uuid'] = storyUuid;
    return map;
  }

}