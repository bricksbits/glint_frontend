import 'dart:convert';
GetPeopleResponse getPeopleResponseFromJson(String str) => GetPeopleResponse.fromJson(json.decode(str));
String getPeopleResponseToJson(GetPeopleResponse data) => json.encode(data.toJson());
class GetPeopleResponse {
  GetPeopleResponse({
      this.profiles,});

  GetPeopleResponse.fromJson(dynamic json) {
    if (json['profiles'] != null) {
      profiles = [];
      json['profiles'].forEach((v) {
        profiles?.add(Profiles.fromJson(v));
      });
    }
  }
  List<Profiles>? profiles;
GetPeopleResponse copyWith({  List<Profiles>? profiles,
}) => GetPeopleResponse(  profiles: profiles ?? this.profiles,
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
      this.videoUrlList,});

  Profiles.fromJson(dynamic json) {
    userId = json['user_id'];
    username = json['username'];
    dateOfBirth = json['date_of_birth'];
    gender = json['gender'];
    genderPreference = json['gender_preference'];
    interests = json['interests'] != null ? json['interests'].cast<String>() : [];
    relationshipGoals = json['relationship_goals'] != null ? json['relationship_goals'].cast<String>() : [];
    bio = json['bio'];
    height = _toDouble(json['height']);
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
    if (json['video_url_list'] != null) {
      videoUrlList = [];
      json['video_url_list'].forEach((v) {
        videoUrlList?.add(VideoUrlList.fromJson(v));
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
  double? height;
  String? occupation;
  String? education;
  String? workoutHabit;
  String? drinkingHabit;
  String? smokingHabit;
  int? profileViews;
  int? profileLikes;
  List<PictureUrlList>? pictureUrlList;
  List<VideoUrlList>? videoUrlList;
Profiles copyWith({  int? userId,
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
  List<VideoUrlList>? videoUrlList,
}) => Profiles(  userId: userId ?? this.userId,
  username: username ?? this.username,
  dateOfBirth: dateOfBirth ?? this.dateOfBirth,
  gender: gender ?? this.gender,
  genderPreference: genderPreference ?? this.genderPreference,
  interests: interests ?? this.interests,
  relationshipGoals: relationshipGoals ?? this.relationshipGoals,
  bio: bio ?? this.bio,
  height: height ?? _toDouble(this.height),
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
    if (pictureUrlList != null) {
      map['picture_url_list'] = pictureUrlList?.map((v) => v.toJson()).toList();
    }
    if (videoUrlList != null) {
      map['video_url_list'] = videoUrlList?.map((v) => v.toJson()).toList();
    }
    return map;
  }

  static double? _toDouble(dynamic value) {
    if (value == null) return null;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) return double.tryParse(value);
    return null;
  }
}

VideoUrlList videoUrlListFromJson(String str) => VideoUrlList.fromJson(json.decode(str));
String videoUrlListToJson(VideoUrlList data) => json.encode(data.toJson());
class VideoUrlList {
  VideoUrlList({
      this.presignedUrl, 
      this.fileExtension,});

  VideoUrlList.fromJson(dynamic json) {
    presignedUrl = json['presigned_url'];
    fileExtension = json['file_extension'];
  }
  String? presignedUrl;
  String? fileExtension;
VideoUrlList copyWith({  String? presignedUrl,
  String? fileExtension,
}) => VideoUrlList(  presignedUrl: presignedUrl ?? this.presignedUrl,
  fileExtension: fileExtension ?? this.fileExtension,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['presigned_url'] = presignedUrl;
    map['file_extension'] = fileExtension;
    return map;
  }

}

PictureUrlList pictureUrlListFromJson(String str) => PictureUrlList.fromJson(json.decode(str));
String pictureUrlListToJson(PictureUrlList data) => json.encode(data.toJson());
class PictureUrlList {
  PictureUrlList({
      this.presignedUrl, 
      this.fileExtension,});

  PictureUrlList.fromJson(dynamic json) {
    presignedUrl = json['presigned_url'];
    fileExtension = json['file_extension'];
  }
  String? presignedUrl;
  String? fileExtension;
PictureUrlList copyWith({  String? presignedUrl,
  String? fileExtension,
}) => PictureUrlList(  presignedUrl: presignedUrl ?? this.presignedUrl,
  fileExtension: fileExtension ?? this.fileExtension,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['presigned_url'] = presignedUrl;
    map['file_extension'] = fileExtension;
    return map;
  }
}

