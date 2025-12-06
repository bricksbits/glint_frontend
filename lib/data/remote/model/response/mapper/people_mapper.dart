import 'package:glint_frontend/data/local/db/entities/profile_entity.dart';
import 'package:glint_frontend/data/remote/model/response/admin/get_published_event_response.dart';
import 'package:glint_frontend/data/remote/model/response/people/get_people_response.dart';
import 'package:glint_frontend/features/people/model/people_card_model.dart';
import 'package:intl/intl.dart';

extension GetPeopleResponseMapper on GetPeopleResponse {
  List<ProfileEntity>? mapToProfileEntity() {
    return profiles
        ?.map(
          (element) => ProfileEntity(
            userId: element.userId.toString(),
            username: element.username ?? "",
            age: calculateAge(element.dateOfBirth ?? "").toString(),
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
                    ?.where((picture) => picture.presignedUrl != null)
                    .map((filterPicture) => "${filterPicture.presignedUrl}")
                    .toList() ??
                [],
            profileTag: "New",
            lastLocation: "Hidden",
            location: "Hidden",
            dateOfBirthFormatted: element.dateOfBirth,
          ),
        )
        .toList();
  }

  List<PeopleCardModel> mapToUiModel() {
    return profiles?.map((element) {
          final dobValue = element.dateOfBirth;
          var age = "";
          if (dobValue != null) {
            age = calculateAge(dobValue).toString();
          }

          //Todo:Create the Common Maps for About section
          Map<String, String> aboutSection = {
            "height": element.height.toString(),
            "smokingHabits": element.smokingHabit ?? "",
            "drinkingHabits": element.drinkingHabit ?? "",
            "workoutHabits": element.workoutHabit ?? "",
          };

          return PeopleCardModel(
              userId: element.userId.toString(),
              username: element.username ?? "",
              age: age,
              distanceAway: "--",
              profileViews: element.profileViews.toString(),
              about: aboutSection,
              bio: element.bio ?? "--",
              lookingFor: element.relationshipGoals?.first ?? "--",
              location: "--",
              interests: element.interests ?? [],
              pictureUrlList: element.pictureUrlList
                      ?.map((pic) => "${pic.presignedUrl}")
                      .toList() ??
                  [],
              gender: element.gender ?? "",
              genderPreference: element.genderPreference ?? "",
              profileLikes: element.profileLikes.toString(),
              isVerified: false,
              profileTag: "New Here",
              occupation: element.occupation ?? "");
        }).toList() ??
        [];
  }
}

int calculateAge(String birthDateStr) {
  DateTime birthDate = DateFormat('yyyy-MM-dd HH:mm:ss').parse(birthDateStr);
  DateTime today = DateTime.now();

  int age = today.year - birthDate.year;

  // If birthday hasn't occurred yet this year, subtract 1
  if (today.month < birthDate.month ||
      (today.month == birthDate.month && today.day < birthDate.day)) {
    age--;
  }

  return age;
}
