import 'dart:convert';
StoryLikeDislikeRequestBody storyLikeDislikeRequestBodyFromJson(String str) => StoryLikeDislikeRequestBody.fromJson(json.decode(str));
String storyLikeDislikeRequestBodyToJson(StoryLikeDislikeRequestBody data) => json.encode(data.toJson());
class StoryLikeDislikeRequestBody {
  StoryLikeDislikeRequestBody({
      this.storyOwnerUserId, 
      this.storyUuid,});

  StoryLikeDislikeRequestBody.fromJson(dynamic json) {
    storyOwnerUserId = json['story_owner_user_id'];
    storyUuid = json['story_uuid'];
  }
  int? storyOwnerUserId;
  String? storyUuid;
StoryLikeDislikeRequestBody copyWith({  int? storyOwnerUserId,
  String? storyUuid,
}) => StoryLikeDislikeRequestBody(  storyOwnerUserId: storyOwnerUserId ?? this.storyOwnerUserId,
  storyUuid: storyUuid ?? this.storyUuid,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['story_owner_user_id'] = storyOwnerUserId;
    map['story_uuid'] = storyUuid;
    return map;
  }

}