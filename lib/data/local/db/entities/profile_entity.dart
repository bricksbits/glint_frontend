import 'package:floor/floor.dart';
import 'package:glint_frontend/data/local/db/database/string_type_converter.dart';
import 'package:glint_frontend/domain/business_logic/models/auth/register_user_request.dart';
import 'package:glint_frontend/features/people/model/people_card_model.dart';

//Todo : Cross check if all those SP items are adding or not
/// Data Like
/// AccessToken, RefreshToken, StreamToken,
/// IsPremiumUser, Email, Current Role, Profile Views
///
/// All are put via the SharedPref Encrypted
///
/// This ProfileEntity works as the base for
/// - User Profile, Update and Read
/// - Registration process
/// - Fetching Profiles for matching
///
/// Model for each usecase can change as per requirement
@Entity(tableName: 'profiles')
class ProfileEntity {
  @primaryKey
  final String userId;
  final String username;
  final String age;
  final String gender;
  final String genderPreference;

  @TypeConverters([StringTypeConverter])
  final List<String> interests;

  final String lookingFor;
  final String bio;

  final String? height;
  final String? occupation;
  final String? education;
  final String? workoutHabit;
  final String? drinkingHabit;
  final String? smokingHabit;
  final String profileViews;
  final String profileLikes;

  @TypeConverters([StringTypeConverter])
  final List<String> pictureUrlList;

  final String? profileTag;
  final String? lastLocation;
  final String? location;

  ProfileEntity({
    required this.userId,
    required this.username,
    required this.age,
    required this.gender,
    required this.genderPreference,
    required this.interests,
    required this.lookingFor,
    required this.bio,
    required this.height,
    required this.occupation,
    required this.education,
    required this.workoutHabit,
    required this.drinkingHabit,
    required this.smokingHabit,
    required this.profileViews,
    required this.profileLikes,
    required this.pictureUrlList,
    required this.profileTag,
    required this.lastLocation,
    required this.location,
  });
}

extension ProfileToPeopleMapper on ProfileEntity {
  PeopleCardModel mapToPeopleUiModel() {
    final aboutMap = {
      "height": height ?? "",
      "occupation": occupation ?? "",
      "education": education ?? "",
      "workout": workoutHabit ?? "",
      "drinking": drinkingHabit ?? "",
      "smoking": smokingHabit ?? "",
    };
    return PeopleCardModel(
        userId: userId,
        username: username,
        age: age,
        profileViews: profileViews,
        bio: bio,
        lookingFor: lookingFor,
        location: location ?? "",
        interests: interests,
        pictureUrlList: pictureUrlList,
        gender: gender,
        genderPreference: genderPreference,
        profileLikes: profileLikes,
        isVerified: false,
        distanceAway: "",
        about: aboutMap,
        profileTag: profileTag ?? "",
        occupation: occupation ?? ""
    );
  }

  RegisterUserRequest mapToRequestUserModel() {
    return RegisterUserRequest(
      userId,
      username,
      "",
      "",
      bio,
      age,
      height ?? "",
      education ?? "",
      occupation ?? "",
      gender,
      genderPreference,
      workoutHabit ?? "",
      drinkingHabit ?? "",
      smokingHabit ?? "",
      lookingFor,
      interests,
    );
  }
}
