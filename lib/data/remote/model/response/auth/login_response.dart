import 'dart:convert';
LoginResponse loginResponseFromJson(String str) => LoginResponse.fromJson(json.decode(str));
String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());
class LoginResponse {
  LoginResponse({
      Profile? profile,}){
    _profile = profile;
}

  LoginResponse.fromJson(dynamic json) {
    _profile = json['profile'] != null ? Profile.fromJson(json['profile']) : null;
  }
  Profile? _profile;
LoginResponse copyWith({  Profile? profile,
}) => LoginResponse(  profile: profile ?? _profile,
);
  Profile? get profile => _profile;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_profile != null) {
      map['profile'] = _profile?.toJson();
    }
    return map;
  }

}

Profile profileFromJson(String str) => Profile.fromJson(json.decode(str));
String profileToJson(Profile data) => json.encode(data.toJson());
class Profile {
  Profile({
      String? authToken, 
      String? refreshToken, 
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
      dynamic pictureUrlList, 
      dynamic videoUrlList,}){
    _authToken = authToken;
    _refreshToken = refreshToken;
    _userId = userId;
    _username = username;
    _dateOfBirth = dateOfBirth;
    _gender = gender;
    _genderPreference = genderPreference;
    _interests = interests;
    _relationshipGoals = relationshipGoals;
    _bio = bio;
    _height = height;
    _occupation = occupation;
    _education = education;
    _workoutHabit = workoutHabit;
    _drinkingHabit = drinkingHabit;
    _smokingHabit = smokingHabit;
    _profileViews = profileViews;
    _profileLikes = profileLikes;
    _pictureUrlList = pictureUrlList;
    _videoUrlList = videoUrlList;
}

  Profile.fromJson(dynamic json) {
    _authToken = json['auth_token'];
    _refreshToken = json['refresh_token'];
    _userId = json['user_id'];
    _username = json['username'];
    _dateOfBirth = json['date_of_birth'];
    _gender = json['gender'];
    _genderPreference = json['gender_preference'];
    _interests = json['interests'] != null ? json['interests'].cast<String>() : [];
    _relationshipGoals = json['relationship_goals'] != null ? json['relationship_goals'].cast<String>() : [];
    _bio = json['bio'];
    _height = json['height'];
    _occupation = json['occupation'];
    _education = json['education'];
    _workoutHabit = json['workout_habit'];
    _drinkingHabit = json['drinking_habit'];
    _smokingHabit = json['smoking_habit'];
    _profileViews = json['profile_views'];
    _profileLikes = json['profile_likes'];
    _pictureUrlList = json['picture_url_list'];
    _videoUrlList = json['video_url_list'];
  }
  String? _authToken;
  String? _refreshToken;
  int? _userId;
  String? _username;
  String? _dateOfBirth;
  String? _gender;
  String? _genderPreference;
  List<String>? _interests;
  List<String>? _relationshipGoals;
  String? _bio;
  double? _height;
  String? _occupation;
  String? _education;
  String? _workoutHabit;
  String? _drinkingHabit;
  String? _smokingHabit;
  int? _profileViews;
  int? _profileLikes;
  dynamic _pictureUrlList;
  dynamic _videoUrlList;
Profile copyWith({  String? authToken,
  String? refreshToken,
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
  dynamic pictureUrlList,
  dynamic videoUrlList,
}) => Profile(  authToken: authToken ?? _authToken,
  refreshToken: refreshToken ?? _refreshToken,
  userId: userId ?? _userId,
  username: username ?? _username,
  dateOfBirth: dateOfBirth ?? _dateOfBirth,
  gender: gender ?? _gender,
  genderPreference: genderPreference ?? _genderPreference,
  interests: interests ?? _interests,
  relationshipGoals: relationshipGoals ?? _relationshipGoals,
  bio: bio ?? _bio,
  height: height ?? _height,
  occupation: occupation ?? _occupation,
  education: education ?? _education,
  workoutHabit: workoutHabit ?? _workoutHabit,
  drinkingHabit: drinkingHabit ?? _drinkingHabit,
  smokingHabit: smokingHabit ?? _smokingHabit,
  profileViews: profileViews ?? _profileViews,
  profileLikes: profileLikes ?? _profileLikes,
  pictureUrlList: pictureUrlList ?? _pictureUrlList,
  videoUrlList: videoUrlList ?? _videoUrlList,
);
  String? get authToken => _authToken;
  String? get refreshToken => _refreshToken;
  int? get userId => _userId;
  String? get username => _username;
  String? get dateOfBirth => _dateOfBirth;
  String? get gender => _gender;
  String? get genderPreference => _genderPreference;
  List<String>? get interests => _interests;
  List<String>? get relationshipGoals => _relationshipGoals;
  String? get bio => _bio;
  double? get height => _height;
  String? get occupation => _occupation;
  String? get education => _education;
  String? get workoutHabit => _workoutHabit;
  String? get drinkingHabit => _drinkingHabit;
  String? get smokingHabit => _smokingHabit;
  int? get profileViews => _profileViews;
  int? get profileLikes => _profileLikes;
  dynamic get pictureUrlList => _pictureUrlList;
  dynamic get videoUrlList => _videoUrlList;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['auth_token'] = _authToken;
    map['refresh_token'] = _refreshToken;
    map['user_id'] = _userId;
    map['username'] = _username;
    map['date_of_birth'] = _dateOfBirth;
    map['gender'] = _gender;
    map['gender_preference'] = _genderPreference;
    map['interests'] = _interests;
    map['relationship_goals'] = _relationshipGoals;
    map['bio'] = _bio;
    map['height'] = _height;
    map['occupation'] = _occupation;
    map['education'] = _education;
    map['workout_habit'] = _workoutHabit;
    map['drinking_habit'] = _drinkingHabit;
    map['smoking_habit'] = _smokingHabit;
    map['profile_views'] = _profileViews;
    map['profile_likes'] = _profileLikes;
    map['picture_url_list'] = _pictureUrlList;
    map['video_url_list'] = _videoUrlList;
    return map;
  }

}