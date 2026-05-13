import 'package:glint_frontend/data/local/db/entities/profile_entity.dart';
import 'package:glint_frontend/data/remote/model/response/profile/its_me_response_body.dart';
import '../../../utils/calculate_age.dart';

extension ItsMeBodyMapper on ItsMeResponseBody {
  ProfileEntity mapToEntity() {
    var profile = data;
    var pics = profile?.pictureUrlList
            ?.map((e) => e.presignedUrl)
            .whereType<String>()
            .toList() ??
        [];

    return ProfileEntity(
      userId: profile?.userId.toString() ?? "",
      username: profile?.username ?? "",
      age: _safeCalculateAge(profile?.dateOfBirth),
      gender: profile?.gender ?? "",
      genderPreference: profile?.genderPreference ?? "",
      interests: profile?.interests ?? [],
      lookingFor: profile?.relationshipGoals?.firstOrNull ?? "",
      bio: profile?.bio ?? "",
      height: profile?.height?.toString(),
      occupation: profile?.occupation,
      education: profile?.education,
      workoutHabit: profile?.workoutHabit,
      drinkingHabit: profile?.drinkingHabit,
      smokingHabit: profile?.smokingHabit,
      profileViews: profile?.profileViews?.toString() ?? "",
      profileLikes: profile?.profileLikes?.toString() ?? "",
      pictureUrlList: pics,
      profileTag: "New User",
      lastLocation: "NOT Updated",
      location: "Not Provided yet",
      dateOfBirthFormatted: profile?.dateOfBirth,
    );
  }
}

String _safeCalculateAge(String? dateOfBirth) {
  if (dateOfBirth == null || dateOfBirth.isEmpty) return "0";
  try {
    return calculateAge(dateOfBirth).toString();
  } catch (_) {
    return "0";
  }
}
