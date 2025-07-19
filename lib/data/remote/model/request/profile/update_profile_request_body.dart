import 'dart:convert';
UpdateProfileRequestBody updateProfileRequestBodyFromJson(String str) => UpdateProfileRequestBody.fromJson(json.decode(str));
String updateProfileRequestBodyToJson(UpdateProfileRequestBody data) => json.encode(data.toJson());
class UpdateProfileRequestBody {
  UpdateProfileRequestBody({
      this.username, 
      this.password, 
      this.email, 
      this.phoneNumber, 
      this.bio, 
      this.dateOfBirth, 
      this.height, 
      this.education, 
      this.occupation, 
      this.gender, 
      this.genderPreference, 
      this.workoutHabit, 
      this.drinkingHabit, 
      this.smokingHabit, 
      this.relationshipGoals, 
      this.interests,});

  UpdateProfileRequestBody.fromJson(dynamic json) {
    username = json['username'];
    password = json['password'];
    email = json['email'];
    phoneNumber = json['phone_number'];
    bio = json['bio'];
    dateOfBirth = json['date_of_birth'];
    height = json['height'];
    education = json['education'];
    occupation = json['occupation'];
    gender = json['gender'];
    genderPreference = json['gender_preference'];
    workoutHabit = json['workout_habit'];
    drinkingHabit = json['drinking_habit'];
    smokingHabit = json['smoking_habit'];
    relationshipGoals = json['relationship_goals'] != null ? RelationshipGoals.fromJson(json['relationship_goals']) : null;
    interests = json['interests'] != null ? Interests.fromJson(json['interests']) : null;
  }
  String? username;
  String? password;
  String? email;
  String? phoneNumber;
  String? bio;
  String? dateOfBirth;
  double? height;
  String? education;
  String? occupation;
  String? gender;
  String? genderPreference;
  String? workoutHabit;
  String? drinkingHabit;
  String? smokingHabit;
  RelationshipGoals? relationshipGoals;
  Interests? interests;
UpdateProfileRequestBody copyWith({  String? username,
  String? password,
  String? email,
  String? phoneNumber,
  String? bio,
  String? dateOfBirth,
  double? height,
  String? education,
  String? occupation,
  String? gender,
  String? genderPreference,
  String? workoutHabit,
  String? drinkingHabit,
  String? smokingHabit,
  RelationshipGoals? relationshipGoals,
  Interests? interests,
}) => UpdateProfileRequestBody(  username: username ?? this.username,
  password: password ?? this.password,
  email: email ?? this.email,
  phoneNumber: phoneNumber ?? this.phoneNumber,
  bio: bio ?? this.bio,
  dateOfBirth: dateOfBirth ?? this.dateOfBirth,
  height: height ?? this.height,
  education: education ?? this.education,
  occupation: occupation ?? this.occupation,
  gender: gender ?? this.gender,
  genderPreference: genderPreference ?? this.genderPreference,
  workoutHabit: workoutHabit ?? this.workoutHabit,
  drinkingHabit: drinkingHabit ?? this.drinkingHabit,
  smokingHabit: smokingHabit ?? this.smokingHabit,
  relationshipGoals: relationshipGoals ?? this.relationshipGoals,
  interests: interests ?? this.interests,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['username'] = username;
    map['password'] = password;
    map['email'] = email;
    map['phone_number'] = phoneNumber;
    map['bio'] = bio;
    map['date_of_birth'] = dateOfBirth;
    map['height'] = height;
    map['education'] = education;
    map['occupation'] = occupation;
    map['gender'] = gender;
    map['gender_preference'] = genderPreference;
    map['workout_habit'] = workoutHabit;
    map['drinking_habit'] = drinkingHabit;
    map['smoking_habit'] = smokingHabit;
    if (relationshipGoals != null) {
      map['relationship_goals'] = relationshipGoals?.toJson();
    }
    if (interests != null) {
      map['interests'] = interests?.toJson();
    }
    return map;
  }

}

Interests interestsFromJson(String str) => Interests.fromJson(json.decode(str));
String interestsToJson(Interests data) => json.encode(data.toJson());
class Interests {
  Interests({
      this.addInterests, 
      this.deleteInterests,});

  Interests.fromJson(dynamic json) {
    addInterests = json['add_interests'] != null ? json['add_interests'].cast<String>() : [];
    deleteInterests = json['delete_interests'] != null ? json['delete_interests'].cast<String>() : [];
  }
  List<String>? addInterests;
  List<String>? deleteInterests;
Interests copyWith({  List<String>? addInterests,
  List<String>? deleteInterests,
}) => Interests(  addInterests: addInterests ?? this.addInterests,
  deleteInterests: deleteInterests ?? this.deleteInterests,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['add_interests'] = addInterests;
    map['delete_interests'] = deleteInterests;
    return map;
  }

}

RelationshipGoals relationshipGoalsFromJson(String str) => RelationshipGoals.fromJson(json.decode(str));
String relationshipGoalsToJson(RelationshipGoals data) => json.encode(data.toJson());
class RelationshipGoals {
  RelationshipGoals({
      this.addGoals, 
      this.deleteGoals,});

  RelationshipGoals.fromJson(dynamic json) {
    addGoals = json['add_goals'] != null ? json['add_goals'].cast<String>() : [];
    deleteGoals = json['delete_goals'] != null ? json['delete_goals'].cast<String>() : [];
  }
  List<String>? addGoals;
  List<String>? deleteGoals;
RelationshipGoals copyWith({  List<String>? addGoals,
  List<String>? deleteGoals,
}) => RelationshipGoals(  addGoals: addGoals ?? this.addGoals,
  deleteGoals: deleteGoals ?? this.deleteGoals,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['add_goals'] = addGoals;
    map['delete_goals'] = deleteGoals;
    return map;
  }

}