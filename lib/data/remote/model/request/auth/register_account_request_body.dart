import 'dart:convert';
import 'dart:math';

import 'package:glint_frontend/domain/business_logic/models/auth/register_user_request.dart';

RegisterAccountRequestBody registerAccountRequestBodyFromJson(String str) =>
    RegisterAccountRequestBody.fromJson(json.decode(str));

String registerAccountRequestBodyToJson(RegisterAccountRequestBody data) =>
    json.encode(data.toJson());

class RegisterAccountRequestBody {
  RegisterAccountRequestBody({
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
    this.interests,
    this.role,
    this.approvedByAdmin,
    this.fcmToken,
  });

  RegisterAccountRequestBody.fromJson(dynamic json) {
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
    relationshipGoals = json['relationship_goals'] != null
        ? json['relationship_goals'].cast<String>()
        : [];
    interests =
        json['interests'] != null ? json['interests'].cast<String>() : [];
    role = json['role'];
    approvedByAdmin = json['approved_by_admin'];
    fcmToken = json['fcm_token'];
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
  List<String>? relationshipGoals;
  List<String>? interests;
  String? role;
  bool? approvedByAdmin;
  String? fcmToken;

  RegisterAccountRequestBody copyWith({
    String? username,
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
    List<String>? relationshipGoals,
    List<String>? interests,
    String? role,
    bool? approvedByAdmin,
    String? fcmToken,
  }) =>
      RegisterAccountRequestBody(
        username: username ?? this.username,
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
        role: role ?? this.role,
        approvedByAdmin: approvedByAdmin ?? this.approvedByAdmin,
        fcmToken: fcmToken ?? this.fcmToken,
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
    map['relationship_goals'] = relationshipGoals;
    map['interests'] = interests;
    map['role'] = role;
    map['approved_by_admin'] = approvedByAdmin;
    map['fcm_token'] = fcmToken;
    return map;
  }
}

var _random = Random().nextInt(999999);

//Todo: Implement the Bottom Sheet and Fix those predefined placeholder values
// height, Occupation, Designation, workout, smoking, drinking,
extension RegisterUserRequestMapper on RegisterUserRequest {
  RegisterAccountRequestBody mapToData(
    String userType,
    String? fcmToken,
  ) {
    return RegisterAccountRequestBody(
      username: username,
      password: password,
      email: email,
      phoneNumber: "9876543210",
      bio: bio,
      dateOfBirth: dateOfBirthWithDateFormat,
      height: height != null ? double.tryParse(height!) : 5.6,
      education: education ?? "--",
      occupation: occupation ?? "--",
      genderPreference: genderPreference?.toLowerCase(),
      gender: gender?.toLowerCase(),
      workoutHabit: workoutHabit ?? "never",
      drinkingHabit: drinkingHabit ?? "never",
      smokingHabit: smokingHabit ?? "never",
      relationshipGoals: [
        relationShipGoals ?? "Friend",
      ],
      interests: interests,
      role: userType,
      approvedByAdmin: true,
      fcmToken: fcmToken ?? "fcm_token_random_${_random}_$_random",
    );
  }
}
