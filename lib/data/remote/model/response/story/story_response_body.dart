import 'dart:convert';
StoryResponseBody storyResponseBodyFromJson(String str) => StoryResponseBody.fromJson(json.decode(str));
String storyResponseBodyToJson(StoryResponseBody data) => json.encode(data.toJson());
class StoryResponseBody {
  StoryResponseBody({
      this.success, 
      this.message, 
      this.data,});

  StoryResponseBody.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  bool? success;
  String? message;
  Data? data;
StoryResponseBody copyWith({  bool? success,
  String? message,
  Data? data,
}) => StoryResponseBody(  success: success ?? this.success,
  message: message ?? this.message,
  data: data ?? this.data,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }

}

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      this.stories,});

  Data.fromJson(dynamic json) {
    if (json['stories'] != null) {
      stories = [];
      json['stories'].forEach((v) {
        stories?.add(Stories.fromJson(v));
      });
    }
  }
  List<Stories>? stories;
Data copyWith({  List<Stories>? stories,
}) => Data(  stories: stories ?? this.stories,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (stories != null) {
      map['stories'] = stories?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

Stories storiesFromJson(String str) => Stories.fromJson(json.decode(str));
String storiesToJson(Stories data) => json.encode(data.toJson());
class Stories {
  Stories({
      this.userId, 
      this.username, 
      this.storyUrlList, 
      this.storyViews, 
      this.storyLikes, 
      this.hasViewedByMe, 
      this.hasLikedByMe, 
      this.streamChatChannelId, 
      this.isOwnStory, 
      this.storyUuid,});

  Stories.fromJson(dynamic json) {
    userId = json['user_id'];
    username = json['username'];
    if (json['story_url_list'] != null) {
      storyUrlList = [];
      json['story_url_list'].forEach((v) {
        storyUrlList?.add(StoryUrlList.fromJson(v));
      });
    }
    storyViews = json['story_views'];
    storyLikes = json['story_likes'];
    hasViewedByMe = json['has_viewed_by_me'];
    hasLikedByMe = json['has_liked_by_me'];
    streamChatChannelId = json['stream_chat_channel_id'];
    isOwnStory = json['is_own_story'];
    storyUuid = json['story_uuid'];
  }
  int? userId;
  String? username;
  List<StoryUrlList>? storyUrlList;
  int? storyViews;
  int? storyLikes;
  bool? hasViewedByMe;
  bool? hasLikedByMe;
  dynamic streamChatChannelId;
  bool? isOwnStory;
  String? storyUuid;
Stories copyWith({  int? userId,
  String? username,
  List<StoryUrlList>? storyUrlList,
  int? storyViews,
  int? storyLikes,
  bool? hasViewedByMe,
  bool? hasLikedByMe,
  dynamic streamChatChannelId,
  bool? isOwnStory,
  String? storyUuid,
}) => Stories(  userId: userId ?? this.userId,
  username: username ?? this.username,
  storyUrlList: storyUrlList ?? this.storyUrlList,
  storyViews: storyViews ?? this.storyViews,
  storyLikes: storyLikes ?? this.storyLikes,
  hasViewedByMe: hasViewedByMe ?? this.hasViewedByMe,
  hasLikedByMe: hasLikedByMe ?? this.hasLikedByMe,
  streamChatChannelId: streamChatChannelId ?? this.streamChatChannelId,
  isOwnStory: isOwnStory ?? this.isOwnStory,
  storyUuid: storyUuid ?? this.storyUuid,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user_id'] = userId;
    map['username'] = username;
    if (storyUrlList != null) {
      map['story_url_list'] = storyUrlList?.map((v) => v.toJson()).toList();
    }
    map['story_views'] = storyViews;
    map['story_likes'] = storyLikes;
    map['has_viewed_by_me'] = hasViewedByMe;
    map['has_liked_by_me'] = hasLikedByMe;
    map['stream_chat_channel_id'] = streamChatChannelId;
    map['is_own_story'] = isOwnStory;
    map['story_uuid'] = storyUuid;
    return map;
  }

}

StoryUrlList storyUrlListFromJson(String str) => StoryUrlList.fromJson(json.decode(str));
String storyUrlListToJson(StoryUrlList data) => json.encode(data.toJson());
class StoryUrlList {
  StoryUrlList({
      this.presignedUrl, 
      this.fileExtension,});

  StoryUrlList.fromJson(dynamic json) {
    presignedUrl = json['presigned_url'];
    fileExtension = json['file_extension'];
  }
  String? presignedUrl;
  String? fileExtension;
StoryUrlList copyWith({  String? presignedUrl,
  String? fileExtension,
}) => StoryUrlList(  presignedUrl: presignedUrl ?? this.presignedUrl,
  fileExtension: fileExtension ?? this.fileExtension,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['presigned_url'] = presignedUrl;
    map['file_extension'] = fileExtension;
    return map;
  }

}