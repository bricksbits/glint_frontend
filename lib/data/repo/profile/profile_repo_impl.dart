import 'package:dio/dio.dart';
import 'package:glint_frontend/data/local/db/dao/membership_dao.dart';
import 'package:glint_frontend/data/local/db/dao/profile_dao.dart';
import 'package:glint_frontend/data/local/db/entities/profile_entity.dart';
import 'package:glint_frontend/data/local/db/entities/profile_membership_entity.dart';
import 'package:glint_frontend/data/local/persist/async_encrypted_shared_preference_helper.dart';
import 'package:glint_frontend/data/local/persist/shared_pref_key.dart';
import 'package:glint_frontend/data/remote/client/http_request_enum.dart';
import 'package:glint_frontend/data/remote/client/my_dio_client.dart';
import 'package:glint_frontend/data/remote/model/response/chat/story_upload_response.dart';
import 'package:glint_frontend/data/remote/utils/api_call_handler.dart';
import 'package:glint_frontend/domain/business_logic/repo/profile/profile_repo.dart';
import 'package:glint_frontend/features/people/model/people_card_model.dart';
import 'package:glint_frontend/services/image_manager_service.dart';
import 'package:glint_frontend/utils/result_sealed.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ProfileRepo)
class ProfileRepoImpl extends ProfileRepo {
  final MyDioClient httpClient;
  final AsyncEncryptedSharedPreferenceHelper sharedPreferenceHelper;
  final ProfileDao profileDao;
  final MembershipDao membershipDao;
  final ImageService imageService;

  ProfileRepoImpl({
    required this.httpClient,
    required this.sharedPreferenceHelper,
    required this.profileDao,
    required this.membershipDao,
    required this.imageService,
  });

  @override
  Future<Result<PeopleCardModel>> fetchUserProfile() async {
    var getCurrentUserid =
        await sharedPreferenceHelper.getString(SharedPreferenceKeys.userIdKey);
    var currentUser = await profileDao.getProfileData(getCurrentUserid);
    if (currentUser != null) {
      return Success(currentUser.mapToPeopleUiModel());
    } else {
      return Failure(Exception("Error: User doesn't exists, login again"));
    }
  }

  @override
  Future<Result<void>> getAllPaymentHistory() {
    // TODO: implement getAllPaymentHistory
    throw UnimplementedError();
  }

  @override
  Future<Result<ProfileMembershipEntity>> getUserMembershipDetails() async {
    var getCurrentUserid =
        await sharedPreferenceHelper.getString(SharedPreferenceKeys.userIdKey);
    final membershipEntity =
        await membershipDao.getMembership(getCurrentUserid);
    if (membershipEntity != null) {
      return Success(membershipEntity);
    } else {
      return Failure(Exception("Error: No membership data Found"));
    }
  }

  @override
  Future<Result<void>> updateMedia() async {
    final savedImages = await imageService.loadSavedImages();
    final mediaFiles = savedImages.map((file) => file.file).toList();
    FormData formData = FormData();
    for (int i = 0; i < mediaFiles.length; i++) {
      final file = mediaFiles[i];
      if (file != null) {
        formData.files.add(
          MapEntry(
            "profile-picture",
            await MultipartFile.fromFile(
              file.path,
              filename: file.path.split('/').last, // or keep your custom name
            ),
          ),
        );
      }
    }

    final response = await apiCallHandler(
      httpClient: httpClient,
      requestType: HttpRequestEnum.UPLOAD,
      endpoint: "user/content/profile",
      uploadFilesFormData: formData,
    );

    switch (response) {
      case Success():
        final storiesResponse = StoryUploadResponse.fromJson(response.data);
        if (storiesResponse.filesUploaded?.isNotEmpty == true) {
          return const Success(true);
        } else {
          return Failure(
            Exception(
                "Files ${storiesResponse.filesNotUploaded} failed to upload"),
          );
        }
      case Failure():
        return Failure(
          Exception("Not able to upload files currently, please try again."),
        );
    }
  }

  @override
  Future<Result<void>> updateProfileData(
      PeopleCardModel updatedPeopleCardModel) async {
    var peopleEntity = updatedPeopleCardModel.mapToEntity();
    await profileDao.updateProfileData(peopleEntity);
    return const Success("");
  }

  @override
  Future<Result<void>> verifyUser() async {
    return Failure(Exception("Verification mode is not available"));
  }

  @override
  Future<Result<void>> updateProfile(String userId) async {
    final getUpdatedProfile = await profileDao.getProfileData(userId);
    if (getUpdatedProfile == null) {
      return Failure(Exception("Local user profile not available"));
    }

    final updateProfileResponse = await apiCallHandler(
        httpClient: httpClient,
        requestType: HttpRequestEnum.PUT,
        endpoint: "user/profile",
        requestBody: getUpdatedProfile.mapToUpdateProfileRequestModel());

    switch (updateProfileResponse) {
      case Success():
        return const Success("");
      case Failure():
        return Failure(Exception(
            "Failed to update profile, : ${updateProfileResponse.error}"));
    }
  }
}
