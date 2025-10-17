import 'dart:convert';
LoginResponse loginResponseFromJson(String str) => LoginResponse.fromJson(json.decode(str));
String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());
class LoginResponse {
  LoginResponse({
      this.profile,});

  LoginResponse.fromJson(dynamic json) {
    profile = json['profile'] != null ? Profile.fromJson(json['profile']) : null;
  }
  Profile? profile;
LoginResponse copyWith({  Profile? profile,
}) => LoginResponse(  profile: profile ?? this.profile,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (profile != null) {
      map['profile'] = profile?.toJson();
    }
    return map;
  }

}

Profile profileFromJson(String str) => Profile.fromJson(json.decode(str));
String profileToJson(Profile data) => json.encode(data.toJson());
class Profile {
  Profile({
      this.authToken, 
      this.refreshToken, 
      this.streamAuthToken, 
      this.userRole, 
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
      this.isPremiumUser, 
      this.aiMessagesRemaining, 
      this.rewindsRemaining, 
      this.superLikesLeft, 
      this.directDmRemaining,});

  Profile.fromJson(dynamic json) {
    authToken = json['auth_token'];
    refreshToken = json['refresh_token'];
    streamAuthToken = json['stream_auth_token'];
    userRole = json['user_role'];
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
    isPremiumUser = json['is_premium_user'];
    aiMessagesRemaining = json['ai_messages_remaining'];
    rewindsRemaining = json['rewinds_remaining'];
    superLikesLeft = json['super_likes_left'];
    directDmRemaining = json['direct_dm_remaining'];
  }
  String? authToken;
  String? refreshToken;
  String? streamAuthToken;
  String? userRole;
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
  bool? isPremiumUser;
  int? aiMessagesRemaining;
  int? rewindsRemaining;
  int? superLikesLeft;
  int? directDmRemaining;
Profile copyWith({  String? authToken,
  String? refreshToken,
  String? streamAuthToken,
  String? userRole,
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
  List<VideoUrlList>? videoUrlList,
  bool? isPremiumUser,
  int? aiMessagesRemaining,
  int? rewindsRemaining,
  int? superLikesLeft,
  int? directDmRemaining,
}) => Profile(  authToken: authToken ?? this.authToken,
  refreshToken: refreshToken ?? this.refreshToken,
  streamAuthToken: streamAuthToken ?? this.streamAuthToken,
  userRole: userRole ?? this.userRole,
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
  isPremiumUser: isPremiumUser ?? this.isPremiumUser,
  aiMessagesRemaining: aiMessagesRemaining ?? this.aiMessagesRemaining,
  rewindsRemaining: rewindsRemaining ?? this.rewindsRemaining,
  superLikesLeft: superLikesLeft ?? this.superLikesLeft,
  directDmRemaining: directDmRemaining ?? this.directDmRemaining,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['auth_token'] = authToken;
    map['refresh_token'] = refreshToken;
    map['stream_auth_token'] = streamAuthToken;
    map['user_role'] = userRole;
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
    map['is_premium_user'] = isPremiumUser;
    map['ai_messages_remaining'] = aiMessagesRemaining;
    map['rewinds_remaining'] = rewindsRemaining;
    map['super_likes_left'] = superLikesLeft;
    map['direct_dm_remaining'] = directDmRemaining;
    return map;
  }

  static double? _toDouble(dynamic value) {
    try {
      if (value == null) return null;
      if (value is double) return value;
      if (value is int) return value.toDouble();
      if (value is String) return double.tryParse(value);
      return null;
    } catch (e){
      return null;
    }
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