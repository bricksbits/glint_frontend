import 'dart:convert';

import 'package:glint_frontend/features/chat/story/model/recent_matches_model.dart';

GetRecentMatchesResponse getRecentMatchesResponseFromJson(String str) =>
    GetRecentMatchesResponse.fromJson(json.decode(str));

String getRecentMatchesResponseToJson(GetRecentMatchesResponse data) =>
    json.encode(data.toJson());

class GetRecentMatchesResponse {
  GetRecentMatchesResponse({
    this.profiles,
  });

  GetRecentMatchesResponse.fromJson(dynamic json) {
    if (json['profiles'] != null) {
      profiles = [];
      json['profiles'].forEach((v) {
        profiles?.add(Profiles.fromJson(v));
      });
    }
  }

  List<Profiles>? profiles;

  GetRecentMatchesResponse copyWith({
    List<Profiles>? profiles,
  }) =>
      GetRecentMatchesResponse(
        profiles: profiles ?? this.profiles,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (profiles != null) {
      map['profiles'] = profiles?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

Profiles profilesFromJson(String str) => Profiles.fromJson(json.decode(str));

String profilesToJson(Profiles data) => json.encode(data.toJson());

class Profiles {
  Profiles({
    this.matchId,
    this.userId,
    this.username,
    this.dateOfBirth,
    this.gender,
    this.genderPreference,
    this.interests,
    this.relationshipGoals,
    this.bio,
    this.height,
    this.occupation,
    this.education,
    this.workoutHabit,
    this.drinkingHabit,
    this.smokingHabit,
    this.profileViews,
    this.profileLikes,
    this.pictureUrlList,
    this.videoUrlList,
    this.streamChatChannelId,
    this.matchedAtEvent,
    this.matchedAtEventName,
    this.matchedAtEventId,
    this.matchedAtEventStartTime,
  });

  Profiles.fromJson(dynamic json) {
    matchId = json['match_id'];
    userId = json['user_id'];
    username = json['username'];
    dateOfBirth = json['date_of_birth'];
    gender = json['gender'];
    genderPreference = json['gender_preference'];
    interests =
        json['interests'] != null ? json['interests'].cast<String>() : [];
    relationshipGoals = json['relationship_goals'] != null
        ? json['relationship_goals'].cast<String>()
        : [];
    bio = json['bio'];
    height = json['height'];
    occupation = json['occupation'];
    education = json['education'];
    workoutHabit = json['workout_habit'];
    drinkingHabit = json['drinking_habit'];
    smokingHabit = json['smoking_habit'];
    profileViews = json['profile_views'];
    profileLikes = json['profile_likes'];
    if (json['picture_url_list'] != null) {
      pictureUrlList = [];
      json['picture_url_list'].forEach((v) {
        pictureUrlList?.add(PictureUrlList.fromJson(v));
      });
    }
    videoUrlList = json['video_url_list'] != null
        ? json['video_url_list'].cast<String>()
        : [];
    streamChatChannelId = json['stream_chat_channel_id'];
    matchedAtEvent = json['matched_at_event'];
    matchedAtEventName = json['matched_at_event_name'];
    matchedAtEventId = json['matched_at_event_id'];
    matchedAtEventStartTime = json['matched_at_event_start_time'];
  }

  int? matchId;
  int? userId;
  String? username;
  String? dateOfBirth;
  String? gender;
  String? genderPreference;
  List<String>? interests;
  List<String>? relationshipGoals;
  String? bio;
  double? height;
  String? occupation;
  String? education;
  String? workoutHabit;
  String? drinkingHabit;
  String? smokingHabit;
  int? profileViews;
  int? profileLikes;
  List<PictureUrlList>? pictureUrlList;
  List<String>? videoUrlList;
  String? streamChatChannelId;
  bool? matchedAtEvent;
  String? matchedAtEventName;
  int? matchedAtEventId;
  String? matchedAtEventStartTime;

  Profiles copyWith({
    int? matchId,
    int? userId,
    String? username,
    String? dateOfBirth,
    String? gender,
    String? genderPreference,
    List<String>? interests,
    List<String>? relationshipGoals,
    String? bio,
    double? height,
    String? occupation,
    String? education,
    String? workoutHabit,
    String? drinkingHabit,
    String? smokingHabit,
    int? profileViews,
    int? profileLikes,
    List<PictureUrlList>? pictureUrlList,
    List<String>? videoUrlList,
    String? streamChatChannelId,
    bool? matchedAtEvent,
    String? matchedAtEventName,
    int? matchedAtEventId,
    String? matchedAtEventStartTime,
  }) =>
      Profiles(
        matchId: matchId ?? this.matchId,
        userId: userId ?? this.userId,
        username: username ?? this.username,
        dateOfBirth: dateOfBirth ?? this.dateOfBirth,
        gender: gender ?? this.gender,
        genderPreference: genderPreference ?? this.genderPreference,
        interests: interests ?? this.interests,
        relationshipGoals: relationshipGoals ?? this.relationshipGoals,
        bio: bio ?? this.bio,
        height: height ?? this.height,
        occupation: occupation ?? this.occupation,
        education: education ?? this.education,
        workoutHabit: workoutHabit ?? this.workoutHabit,
        drinkingHabit: drinkingHabit ?? this.drinkingHabit,
        smokingHabit: smokingHabit ?? this.smokingHabit,
        profileViews: profileViews ?? this.profileViews,
        profileLikes: profileLikes ?? this.profileLikes,
        pictureUrlList: pictureUrlList ?? this.pictureUrlList,
        videoUrlList: videoUrlList ?? this.videoUrlList,
        streamChatChannelId: streamChatChannelId ?? this.streamChatChannelId,
        matchedAtEvent: matchedAtEvent ?? this.matchedAtEvent,
        matchedAtEventName: matchedAtEventName ?? this.matchedAtEventName,
        matchedAtEventId: matchedAtEventId ?? this.matchedAtEventId,
        matchedAtEventStartTime:
            matchedAtEventStartTime ?? this.matchedAtEventStartTime,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['match_id'] = matchId;
    map['user_id'] = userId;
    map['username'] = username;
    map['date_of_birth'] = dateOfBirth;
    map['gender'] = gender;
    map['gender_preference'] = genderPreference;
    map['interests'] = interests;
    map['relationship_goals'] = relationshipGoals;
    map['bio'] = bio;
    map['height'] = height;
    map['occupation'] = occupation;
    map['education'] = education;
    map['workout_habit'] = workoutHabit;
    map['drinking_habit'] = drinkingHabit;
    map['smoking_habit'] = smokingHabit;
    map['profile_views'] = profileViews;
    map['profile_likes'] = profileLikes;
    if (pictureUrlList != null) {
      map['picture_url_list'] = pictureUrlList?.map((v) => v.toJson()).toList();
    }
    map['video_url_list'] = videoUrlList;
    map['stream_chat_channel_id'] = streamChatChannelId;
    map['matched_at_event'] = matchedAtEvent;
    map['matched_at_event_name'] = matchedAtEventName;
    map['matched_at_event_id'] = matchedAtEventId;
    map['matched_at_event_start_time'] = matchedAtEventStartTime;
    return map;
  }
}

PictureUrlList pictureUrlListFromJson(String str) =>
    PictureUrlList.fromJson(json.decode(str));

String pictureUrlListToJson(PictureUrlList data) => json.encode(data.toJson());

class PictureUrlList {
  PictureUrlList({
    this.presignedUrl,
    this.fileExtension,
  });

  PictureUrlList.fromJson(dynamic json) {
    presignedUrl = json['presigned_url'];
    fileExtension = json['file_extension'];
  }

  String? presignedUrl;
  String? fileExtension;

  PictureUrlList copyWith({
    String? presignedUrl,
    String? fileExtension,
  }) =>
      PictureUrlList(
        presignedUrl: presignedUrl ?? this.presignedUrl,
        fileExtension: fileExtension ?? this.fileExtension,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['presigned_url'] = presignedUrl;
    map['file_extension'] = fileExtension;
    return map;
  }
}

extension RecentMatchesMapper on GetRecentMatchesResponse {
  List<RecentMatchesModel> mapToUiModel() {
    return profiles?.map(
          (profile) {
            final userFirstImageObj = profile.pictureUrlList?.first;
            final imageUrl =
                "${userFirstImageObj?.presignedUrl}${userFirstImageObj?.fileExtension}";
            return RecentMatchesModel(
              matchUserId: profile.userId.toString(),
              matchUserName: profile.username ?? "",
              matchUserImageUrl: imageUrl,
              matchId: profile.matchId.toString(),
              chatChannelId: profile.streamChatChannelId ?? "",
              matchedAtEvent: profile.matchedAtEvent ?? false,
              eventId: profile.matchedAtEventId.toString(),
              eventName: profile.matchedAtEventName,
              eventStartTime: profile.matchedAtEventStartTime,
            );
          },
        ).toList() ??
        [];
  }
}
