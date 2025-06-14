import 'package:glint_frontend/data/local/db/entities/profile_entity.dart';

class PeopleUiModel {
  final String userId;
  final String name;
  final String age;
  final String distanceAway;
  final String profileViews;
  final String designation;
  final List<String> about;
  final String bio;
  final List<String> lookingFor;
  final String location;
  final List<String> interests;
  final List<String> images;
  final String gender;
  final String genderPreference;
  final String height;
  final String occupation;
  final String education;
  final String workoutHabit;
  final String drinkingHabit;
  final String smokingHabit;
  final String profileLikes;

  PeopleUiModel(
    this.userId,
    this.name,
    this.age,
    this.distanceAway,
    this.profileViews,
    this.designation,
    this.about,
    this.bio,
    this.lookingFor,
    this.location,
    this.interests,
    this.images,
    this.gender,
    this.genderPreference,
    this.height,
    this.occupation,
    this.education,
    this.workoutHabit,
    this.drinkingHabit,
    this.smokingHabit,
    this.profileLikes,
  );

  PeopleUiModel copyWith({
    String? userId,
    String? name,
    String? age,
    String? distanceAway,
    String? profileViews,
    String? designation,
    List<String>? about,
    String? bio,
    List<String>? lookingFor,
    String? location,
    List<String>? interests,
    List<String>? images,
    // New fields in copyWith
    String? gender,
    String? genderPreference,
    String? height,
    String? occupation,
    String? education,
    String? workoutHabit,
    String? drinkingHabit,
    String? smokingHabit,
    String? profileLikes,
  }) {
    return PeopleUiModel(
      userId ?? this.userId,
      name ?? this.name,
      age ?? this.age,
      distanceAway ?? this.distanceAway,
      profileViews ?? this.profileViews,
      designation ?? this.designation,
      about ?? this.about,
      bio ?? this.bio,
      lookingFor ?? this.lookingFor,
      location ?? this.location,
      interests ?? this.interests,
      images ?? this.images,
      // New fields assignment
      gender ?? this.gender,
      genderPreference ?? this.genderPreference,
      height ?? this.height,
      occupation ?? this.occupation,
      education ?? this.education,
      workoutHabit ?? this.workoutHabit,
      drinkingHabit ?? this.drinkingHabit,
      smokingHabit ?? this.smokingHabit,
      profileLikes ?? this.profileLikes,
    );
  }

  @override
  String toString() {
    return 'PeopleUiModel(\n'
        '  userId: $userId,\n'
        '  name: $name,\n'
        '  age: $age,\n'
        '  distanceAway: $distanceAway,\n'
        '  views: $profileViews,\n'
        '  designation: $designation,\n'
        '  about: $about,\n'
        '  bio: $bio,\n'
        '  lookingFor: $lookingFor,\n'
        '  location: $location,\n'
        '  interests: $interests,\n'
        '  images: $images,\n'
    // New fields in toString
        '  gender: $gender,\n'
        '  genderPreferences: $genderPreference,\n'
        '  height: $height,\n'
        '  occupation: $occupation,\n'
        '  education: $education,\n'
        '  workingHabit: $workoutHabit,\n'
        '  drinkingHabit: $drinkingHabit,\n'
        '  smokingHabit: $smokingHabit,\n'
        '  profileLikes: $profileLikes,\n'
        ')';
  }
}

extension UiToDataModel on PeopleUiModel {
  ProfileEntity mapToEntity() {
    return ProfileEntity(
      userId: userId,
      tag: "",
      name: name,
      age: age,
      designation: designation,
      profileViews: "0",
      lastLocation: location,
      pronouns: "Not Specified",
      location: location,
      bio: bio,
      lookingFor: lookingFor.first,
      about: about,
      interests: interests,
      profilePics: images,
      choiceOfGender: "NOT_SPECIFIED",
    );
  }
}
