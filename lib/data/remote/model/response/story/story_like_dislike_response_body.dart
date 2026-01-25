import 'dart:convert';
StoryLikeDislikeResponseBody storyLikeDislikeResponseBodyFromJson(String str) => StoryLikeDislikeResponseBody.fromJson(json.decode(str));
String storyLikeDislikeResponseBodyToJson(StoryLikeDislikeResponseBody data) => json.encode(data.toJson());
class StoryLikeDislikeResponseBody {
  StoryLikeDislikeResponseBody({
      this.success, 
      this.message,});

  StoryLikeDislikeResponseBody.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
  }
  bool? success;
  String? message;
StoryLikeDislikeResponseBody copyWith({  bool? success,
  String? message,
}) => StoryLikeDislikeResponseBody(  success: success ?? this.success,
  message: message ?? this.message,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['message'] = message;
    return map;
  }

}