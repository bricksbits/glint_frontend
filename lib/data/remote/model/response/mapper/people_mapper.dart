import 'package:glint_frontend/data/local/db/entities/profile_entity.dart';
import 'package:glint_frontend/data/remote/model/response/people/get_people_response.dart';
import 'package:glint_frontend/features/people/model/people_card_model.dart';

extension GetPeopleResponseMapper on GetPeopleResponse {
  List<ProfileEntity>? mapToProfileEntity() {
    return profiles
        ?.map(
          (element) => ProfileEntity(
            userId: element.userId.toString(),
            username: element.username ?? "",
            age: element.dateOfBirth ?? "",
            gender: element.gender ?? "",
            genderPreference: element.genderPreference ?? "",
            interests: element.interests ?? [],
            lookingFor: element.relationshipGoals?.first ?? "",
            bio: element.bio ?? "",
            height: element.height.toString(),
            occupation: element.occupation,
            education: element.education,
            workoutHabit: element.workoutHabit,
            drinkingHabit: element.drinkingHabit,
            smokingHabit: element.smokingHabit,
            profileViews: element.profileViews.toString(),
            profileLikes: element.profileLikes.toString(),
            pictureUrlList: element.pictureUrlList
                    ?.where((picture) =>
                        picture.fileExtension != null &&
                        picture.presignedUrl != null)
                    .map((filterPicture) =>
                        "${filterPicture.presignedUrl}.${filterPicture.fileExtension}")
                    .toList() ??
                [],
            profileTag: "NO PROFILE TAG",
            lastLocation: "NO LOCATION",
            location: "NO LOCATION",
          ),
        )
        .toList();
  }

  List<PeopleCardModel> mapToUiModel()  {
    return profiles.map((element) =>
    PeopleCardModel(userId: element.userId.toString(), username: username, age: age, distanceAway: distanceAway, profileViews: profileViews, about: about, bio: bio, lookingFor: lookingFor, location: location, interests: interests, pictureUrlList: pictureUrlList, gender: gender, genderPreference: genderPreference, profileLikes: profileLikes, isVerified: isVerified, profileTag: profileTag, occupation: occupation))
  }
}
