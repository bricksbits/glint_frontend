import 'package:glint_frontend/data/local/db/entities/profile_entity.dart';

class RegisterUserRequest {
  final String? tempUserId;
  final String? username;
  final String? dob;
  final String? gender;
  final String? genderPreference;
  final String? email;
  final String? password;
  final String? bio;
  final String? height;
  final String? education;
  final String? occupation;
  final String? workoutHabit;
  final String? drinkingHabit;
  final String? smokingHabit;
  final String? relationShipGoals;
  final List<String>? interests;

  RegisterUserRequest(
    this.tempUserId,
    this.username,
    this.email,
    this.password,
    this.bio,
    this.dob,
    this.height,
    this.education,
    this.occupation,
    this.gender,
    this.genderPreference,
    this.workoutHabit,
    this.drinkingHabit,
    this.smokingHabit,
    this.relationShipGoals,
    this.interests,
  );

  RegisterUserRequest copyWith({
    String? tempUserId,
    String? username,
    String? email,
    String? password,
    String? bio,
    String? dob,
    String? height,
    String? education,
    String? occupation,
    String? gender,
    String? genderPreference,
    String? workoutHabit,
    String? drinkingHabit,
    String? smokingHabit,
    String? relationShipGoals,
    List<String>? interests,
  }) {
    return RegisterUserRequest(
      tempUserId ?? this.tempUserId,
      username ?? this.username,
      email ?? this.email,
      password ?? this.password,
      bio ?? this.bio,
      dob ?? this.dob,
      height ?? this.height,
      education ?? this.education,
      occupation ?? this.occupation,
      gender ?? this.gender,
      genderPreference ?? this.genderPreference,
      workoutHabit ?? this.workoutHabit,
      drinkingHabit ?? this.drinkingHabit,
      smokingHabit ?? this.smokingHabit,
      relationShipGoals ?? this.relationShipGoals,
      interests ?? this.interests,
    );
  }
}

extension RegisterRequestToEntityMapper on RegisterUserRequest {
  ProfileEntity mapToEntity() {
    return ProfileEntity(
      userId: tempUserId ?? "",
      username: username ?? "",
      age: dob ?? "",
      gender: gender ?? "",
      genderPreference: genderPreference ?? "",
      interests: interests ?? [],
      lookingFor: relationShipGoals ?? "",
      bio: bio ?? "",
      height: height,
      occupation: occupation,
      education: education,
      workoutHabit: workoutHabit,
      drinkingHabit: drinkingHabit,
      smokingHabit: smokingHabit,
      profileViews: "0",
      profileLikes: "0",
      pictureUrlList: [],
      profileTag: "",
      lastLocation: "",
      location: "",
    );
  }
}
