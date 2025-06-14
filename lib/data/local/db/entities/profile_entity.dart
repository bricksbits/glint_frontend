import 'package:floor/floor.dart';
import 'package:glint_frontend/data/local/db/database/string_type_converter.dart';
import 'package:glint_frontend/domain/business_logic/models/auth/register_user_request.dart';
import 'package:glint_frontend/features/people/model/people_model.dart';

// TODO: Find a Way to setup the Membership and Event related details as well.
@entity
class ProfileEntity {
  @primaryKey
  final String userId;
  final String tag;
  final String name;
  final String age;
  final String designation;
  final String profileViews;
  final String lastLocation;
  final String pronouns;
  final String location;
  final String bio;
  final String lookingFor;
  final String choiceOfGender;

  @TypeConverters([StringTypeConverter])
  final List<String> about;

  @TypeConverters([StringTypeConverter])
  final List<String> interests;

  @TypeConverters([StringTypeConverter])
  final List<String> profilePics;

  ProfileEntity({
    required this.userId,
    required this.tag,
    required this.name,
    required this.age,
    required this.designation,
    required this.profileViews,
    required this.lastLocation,
    required this.pronouns,
    required this.location,
    required this.bio,
    required this.lookingFor,
    required this.about,
    required this.interests,
    required this.profilePics,
    required this.choiceOfGender,
  });
}

extension ProfileToPeopleMapper on ProfileEntity {
  PeopleUiModel mapToPeopleUiModel() {
    return PeopleUiModel(
      userId.toString(),
      name,
      age,
      location,
      profileViews,
      designation,
      about,
      bio,
      [lookingFor, lookingFor],
      lastLocation,
      interests,
      profilePics,
      pronouns,
      choiceOfGender,
      "NOT SET- HEIGHT",
      "NOT SET_ OCCUPATION",
      "NOT-SET Education",
      "NOT SET- WORK OUT HABITS",
      "NOT SET_ DRINKING HABIT",
      "NOT-SET Smoking habit",
      "NOT SET PROFILE LIKES",
    );
  }

  RegisterUserRequest mapToDomain() {
    return RegisterUserRequest(
      name,
      "email",
      "password",
      "phoneNumber",
      bio,
      age,
      "height",
      "education",
      designation,
      pronouns,
      choiceOfGender,
      "workoutHabit",
      "drinkingHabit",
      "smokingHabit",
      lookingFor,
      interests,
    );
  }
}
