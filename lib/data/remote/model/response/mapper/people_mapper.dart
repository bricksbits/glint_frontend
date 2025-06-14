import 'package:glint_frontend/data/remote/model/response/people/get_people_response.dart';
import 'package:glint_frontend/features/people/model/people_model.dart';

extension GetPeopleResponseMapper on GetPeopleResponse {
  List<PeopleUiModel>? mapToUiModelList() {
    return profiles
        ?.map((element) => PeopleUiModel(
              element.userId.toString(),
              element.username ?? "",
              element.dateOfBirth ?? "",
              "9",
              element.profileViews.toString(),
              element.occupation ?? "New Here",
              [
                element.height.toString(),
                element.drinkingHabit ?? "Never",
                element.smokingHabit ?? "Never",
                element.workoutHabit ?? "Sometimes",
                element.gender ?? "Not to Say",
              ],
              element.bio ?? "",
              element.relationshipGoals ?? [],
              "Not Shared",
              element.interests ?? [],
              element.pictureUrlList
                      ?.where((element) => element.presignedUrl != null)
                      .map((element) => element.presignedUrl ?? "")
                      .toList() ??
                  [
                    "https://images.unsplash.com/photo-1515886657613-9f3515b0c78f?q=80&w=2124&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
                  ],
              element.gender ?? "",
              element.genderPreference ?? "",
              element.height.toString(),
              element.occupation ?? "NOT SET_ OCCUPATION",
              element.education ?? "NOT-SET Education",
              element.workoutHabit ?? "NOT SET- WORK OUT HABITS",
              element.drinkingHabit ?? "NOT SET_ DRINKING HABIT",
              element.smokingHabit ?? "NOT-SET Smoking habit",
              element.profileLikes.toString(),
            ))
        .toList();
  }
}
