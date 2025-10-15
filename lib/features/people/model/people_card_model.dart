import 'package:glint_frontend/data/local/db/entities/profile_entity.dart';

/// This Model is used for displaying the People
/// As Card only
class PeopleCardModel {
  final String userId;
  final String username;
  final String age;
  final String gender;
  final String genderPreference;
  final List<String> interests;
  final String lookingFor;
  final String bio;
  final String? profileViews;
  final String? profileLikes;
  final List<String> pictureUrlList;
  final String distanceAway;
  final Map<String, String> about;
  final String location;
  final bool isVerified;
  final String profileTag;
  final String occupation;

  PeopleCardModel({
    required this.userId,
    required this.username,
    required this.age,
    required this.distanceAway,
    required this.profileViews,
    required this.about,
    required this.bio,
    required this.lookingFor,
    required this.location,
    required this.interests,
    required this.pictureUrlList,
    required this.gender,
    required this.genderPreference,
    required this.profileLikes,
    required this.isVerified,
    required this.profileTag,
    required this.occupation,
  });

  PeopleCardModel copyWith(
      {String? userId,
      String? username,
      String? age,
      String? distanceAway,
      String? profileViews,
      Map<String, String>? about,
      String? bio,
      String? lookingFor,
      String? location,
      List<String>? interests,
      List<String>? pictureUrlList,
      String? gender,
      String? genderPreference,
      String? profileLikes,
      bool? isVerified,
      String? profileTag,
      String? occupation}) {
    return PeopleCardModel(
        userId: userId ?? this.userId,
        username: username ?? this.username,
        age: age ?? this.age,
        distanceAway: distanceAway ?? this.distanceAway,
        profileViews: profileViews ?? this.profileViews,
        about: about ?? this.about,
        bio: bio ?? this.bio,
        lookingFor: lookingFor ?? this.lookingFor,
        location: location ?? this.location,
        interests: interests ?? this.interests,
        pictureUrlList: pictureUrlList ?? this.pictureUrlList,
        gender: gender ?? this.gender,
        genderPreference: genderPreference ?? this.genderPreference,
        profileLikes: profileLikes ?? this.profileLikes,
        isVerified: isVerified ?? this.isVerified,
        profileTag: profileTag ?? this.profileTag,
        occupation: occupation ?? this.occupation);
  }

  @override
  String toString() {
    return 'PeopleCardModel(userId: $userId, username: $username, age: $age, distanceAway: $distanceAway, '
        'profileViews: $profileViews, about: $about, bio: $bio, lookingFor: $lookingFor, '
        'location: $location, interests: $interests, pictureUrlList: $pictureUrlList, '
        'gender: $gender, genderPreference: $genderPreference, profileLikes: $profileLikes, '
        'isVerified: $isVerified, profileTag: $profileTag, occupation : $occupation)';
  }
}

extension PeopleCardToEntity on PeopleCardModel {
  ProfileEntity mapToEntity() {
    return ProfileEntity(
      userId: userId,
      username: username,
      age: age,
      gender: gender,
      genderPreference: genderPreference,
      interests: interests,
      lookingFor: lookingFor,
      bio: bio,
      height: about["height"],
      occupation: occupation,
      education: about["education"],
      workoutHabit: about["workout"],
      drinkingHabit: about["drinking"],
      smokingHabit: about["smoking"],
      profileViews: profileViews ?? "0",
      profileLikes: profileLikes ?? "0",
      pictureUrlList: pictureUrlList,
      profileTag: profileTag,
      location: location,
    );
  }

  double get profileCompletion {
    final Map<String, double> fieldWeights = {
      'username': 5,
      'age': 5,
      'gender': 5,
      'genderPreference': 5,
      'interests': 5,
      'lookingFor': 5,
      'bio': 10,
      'height': 5,
      'occupation': 5,
      'education': 5,
      'workoutHabit': 5,
      'drinkingHabit': 5,
      'smokingHabit': 5,
    };

    double totalWeight = fieldWeights.values.reduce((a, b) => a + b);

    double filledWeight = 0;

    if (username.isNotEmpty) filledWeight += fieldWeights['username']!;
    if (age.isNotEmpty) filledWeight += fieldWeights['age']!;
    if (gender.isNotEmpty) filledWeight += fieldWeights['gender']!;
    if (genderPreference.isNotEmpty) filledWeight += fieldWeights['genderPreference']!;
    if (interests.isNotEmpty) filledWeight += fieldWeights['interests']!;
    if (lookingFor.isNotEmpty) filledWeight += fieldWeights['lookingFor']!;
    if (bio.isNotEmpty) filledWeight += fieldWeights['bio']!;
    if (about["height"] != null) filledWeight += fieldWeights['height']!;
    if (occupation != null) filledWeight += fieldWeights['occupation']!;
    if (about["education"] != null) filledWeight += fieldWeights['education']!;
    if (about["workout"] != null) filledWeight += fieldWeights['workoutHabit']!;
    if (about["drinking"] != null) filledWeight += fieldWeights['drinkingHabit']!;
    if (about["smoking"] != null) filledWeight += fieldWeights['smokingHabit']!;

    int picCount = pictureUrlList.length;
    double pictureScore = 0;
    totalWeight += 30;

    if (picCount >= 1 && picCount < 3) {
      pictureScore = 10;
    } else if (picCount >= 3 && picCount < 6) {
      pictureScore = 20;
    } else if (picCount >= 6 && picCount < 9) {
      pictureScore = 25;
    } else if (picCount >= 9) {
      pictureScore = 30;
    }

    filledWeight += pictureScore;

    return (filledWeight / totalWeight);
  }
}
