import 'package:glint_frontend/data/local/db/entities/profile_entity.dart';

import '../../../utils/calculate_age.dart';
import 'login_response.dart';

extension LoginMapper on LoginResponse {
  ProfileEntity mapToEntity() {
    var profile = this.profile;
    var pics = profile?.pictureUrlList
            ?.map((e) => e.presignedUrl)
            .whereType<String>()
            .toList() ??
        [];

    return ProfileEntity(
      userId: profile?.userId.toString() ?? "",
      username: profile?.username ?? "",
      age: calculateAge(profile?.dateOfBirth ?? "").toString(),
      gender: profile?.gender ?? "",
      genderPreference: profile?.genderPreference ?? "",
      interests: profile?.interests ?? [],
      lookingFor: profile?.relationshipGoals?.first ?? "",
      bio: profile?.bio ?? "",
      height: profile?.height.toString(),
      occupation: profile?.occupation,
      education: profile?.education,
      workoutHabit: profile?.workoutHabit,
      drinkingHabit: profile?.drinkingHabit,
      smokingHabit: profile?.smokingHabit,
      profileViews: profile?.profileViews.toString() ?? "",
      profileLikes: profile?.profileLikes.toString() ?? "",
      pictureUrlList: pics,
      profileTag: "New User",
      lastLocation: "NOT Updated",
      location: "Not Provided yet",
      dateOfBirthFormatted: profile?.dateOfBirth,
    );
  }
}
