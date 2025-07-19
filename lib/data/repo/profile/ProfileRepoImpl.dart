import 'package:glint_frontend/data/remote/client/http_request_enum.dart';
import 'package:glint_frontend/data/remote/client/my_dio_client.dart';
import 'package:glint_frontend/data/remote/model/request/profile/profile_delete_media_request_body.dart';
import 'package:glint_frontend/data/remote/model/request/profile/update_profile_request_body.dart';
import 'package:glint_frontend/data/remote/utils/api_call_handler.dart';
import 'package:glint_frontend/domain/business_logic/repo/profile/profile_repo.dart';
import 'package:glint_frontend/utils/logger.dart';
import 'package:glint_frontend/utils/result_sealed.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: ProfileRepo)
class ProfileRepoImpl extends ProfileRepo {
  final MyDioClient httpClient;

  ProfileRepoImpl(this.httpClient);

  @override
  Future<Result<void>> deleteUserMedia(
    List<String> fileNames,
  ) async {
    var deleteRequestBody =
        ProfileDeleteMediaRequestBody(pictureList: fileNames, videoList: []);

    final response = await apiCallHandler(
        httpClient: httpClient,
        requestType: HttpRequestEnum.GET,
        endpoint: "/user/premium-info",
        requestBody: deleteRequestBody.toJson());

    //Todo : When Success update the File Structure
    switch (response) {
      case Success():
        debugLogger("Profile", "Successfully deleted profiles");
        return Success("");
      case Failure():
        debugLogger("Profile", ": Failed to delete the content");
        return Failure(Exception("Error: ${response.error}"));
    }
  }

  @override
  Future<Result<void>> fetchUserProfile() {
    // TODO: implement fetchUserProfile
    throw UnimplementedError();
  }

  @override
  Future<Result<void>> updateMedia() {
    // TODO: implement updateMedia
    throw UnimplementedError();
  }

  @override
  Future<Result<void>> updateProfileData() async {
    //Todo : Create the new mapper for this to implement the Delete Interests
    var updatedProfileRequestBody = UpdateProfileRequestBody(
        username: "username",
        password: "password",
        email: "",
        phoneNumber: "",
        bio: "",
        dateOfBirth: "",
        height: 150,
        education: "",
        occupation: "",
        gender: "",
        genderPreference: "",
        workoutHabit: "",
        drinkingHabit: "",
        smokingHabit: "",
        relationshipGoals: RelationshipGoals(
          addGoals: [],
          deleteGoals: [],
        ),
        interests: Interests(addInterests: [], deleteInterests: []));

    final response = await apiCallHandler(
        httpClient: httpClient,
        requestType: HttpRequestEnum.GET,
        endpoint: "/user/premium-info",
        requestBody: updatedProfileRequestBody.toJson());

    switch (response) {
      case Success():
        //Todo : Update the DB on Success
        debugLogger("Profile", "Successfully deleted profiles");
        return Success("");
      case Failure():
        debugLogger("Profile", ": Failed to delete the content");
        return Failure(Exception("Error: ${response.error}"));
    }
  }

  @override
  Future<Result<void>> verifyUser() {
    // TODO: implement verifyUser
    throw UnimplementedError();
  }
}
