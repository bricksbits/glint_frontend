import 'dart:convert';

import 'package:glint_frontend/features/people/model/people_model.dart';

GetPeopleResponse getPeopleResponseFromJson(String str) =>
    GetPeopleResponse.fromJson(json.decode(str));

String getPeopleResponseToJson(GetPeopleResponse data) =>
    json.encode(data.toJson());

class GetPeopleResponse {
  GetPeopleResponse({
    this.profiles,
  });

  GetPeopleResponse.fromJson(dynamic json) {
    if (json['profiles'] != null) {
      profiles = [];
      json['profiles'].forEach((v) {
        profiles?.add(Profiles.fromJson(v));
      });
    }
  }

  List<Profiles>? profiles;

  GetPeopleResponse copyWith({
    List<Profiles>? profiles,
  }) =>
      GetPeopleResponse(
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
  });

  Profiles.fromJson(dynamic json) {
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
    pictureUrlList = json['picture_url_list'] != null
        ? json['picture_url_list'].cast<String>()
        : [];
    if (json['video_url_list'] != null) {
      videoUrlList = [];
      json['video_url_list'].forEach((v) {
        videoUrlList?.add(Dynamic.fromJson(v));
      });
    }
  }

  int? userId;
  String? username;
  String? dateOfBirth;
  String? gender;
  String? genderPreference;
  List<String>? interests;
  List<String>? relationshipGoals;
  String? bio;
  int? height;
  String? occupation;
  String? education;
  String? workoutHabit;
  String? drinkingHabit;
  String? smokingHabit;
  int? profileViews;
  int? profileLikes;
  List<String>? pictureUrlList;
  List<dynamic>? videoUrlList;

  Profiles copyWith({
    int? userId,
    String? username,
    String? dateOfBirth,
    String? gender,
    String? genderPreference,
    List<String>? interests,
    List<String>? relationshipGoals,
    String? bio,
    int? height,
    String? occupation,
    String? education,
    String? workoutHabit,
    String? drinkingHabit,
    String? smokingHabit,
    int? profileViews,
    int? profileLikes,
    List<String>? pictureUrlList,
    List<dynamic>? videoUrlList,
  }) =>
      Profiles(
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
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
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
    map['picture_url_list'] = pictureUrlList;
    if (videoUrlList != null) {
      map['video_url_list'] = videoUrlList?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

extension GetPeopleResponseMapper on GetPeopleResponse {
  List<PeopleUiModel>? mapToUiModelList() {
    return profiles
        ?.map((element) => PeopleUiModel(
            element.userId.toString(),
            element.username ?? "",
            element.dateOfBirth ?? "",
            "9",
            element.profileViews.toString(),
            element.occupation ?? "New Here",
            [
              element.height.toString(),
              element.drinkingHabit ?? "Never",
              element.smokingHabit ?? "Never",
              element.workoutHabit ?? "Sometimes",
              element.gender ?? "Not to Say",
            ],
            element.bio ?? "",
            element.relationshipGoals ?? [],
            "Not Shared",
            element.interests ?? [],
            element.pictureUrlList ?? []))
        .toList();
  }
}
