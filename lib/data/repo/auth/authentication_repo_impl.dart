import 'dart:io';

import 'package:dio/dio.dart';
import 'package:glint_frontend/data/local/db/dao/membership_dao.dart';
import 'package:glint_frontend/data/local/db/dao/profile_dao.dart';
import 'package:glint_frontend/data/local/db/entities/profile_entity.dart';
import 'package:glint_frontend/data/local/db/entities/profile_membership_entity.dart';
import 'package:glint_frontend/data/local/persist/async_encrypted_shared_preference_helper.dart';
import 'package:glint_frontend/data/local/persist/shared_pref_key.dart';
import 'package:glint_frontend/data/remote/client/http_request_enum.dart';
import 'package:glint_frontend/data/remote/client/my_dio_client.dart';
import 'package:glint_frontend/data/remote/model/request/auth/login_request_body.dart';
import 'package:glint_frontend/data/remote/model/request/auth/register_account_request_body.dart';
import 'package:glint_frontend/data/remote/model/response/auth/login_response.dart';
import 'package:glint_frontend/data/remote/model/response/chat/story_upload_response.dart';
import 'package:glint_frontend/data/remote/model/response/universal/universal_success_response_body.dart';
import 'package:glint_frontend/data/remote/utils/api_call_handler.dart';
import 'package:glint_frontend/domain/business_logic/models/auth/register_user_request.dart';
import 'package:glint_frontend/domain/business_logic/repo/auth/authentication_repo.dart';
import 'package:glint_frontend/domain/business_logic/repo/boarding/on_boarding_repo.dart';
import 'package:glint_frontend/domain/business_logic/repo/chat/chat_repo.dart';
import 'package:glint_frontend/utils/logger.dart';
import 'package:glint_frontend/utils/result_sealed.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: AuthenticationRepo)
class AuthenticationRepoImpl extends AuthenticationRepo {
  final MyDioClient httpClient;
  final AsyncEncryptedSharedPreferenceHelper sharedPreferenceHelper;
  final ProfileDao profileDao;
  final MembershipDao membershipDao;
  final ChatRepo chatRepo;

  AuthenticationRepoImpl(
    this.httpClient,
    this.sharedPreferenceHelper,
    this.profileDao,
    this.membershipDao,
    this.chatRepo,
  );

  @override
  Future<Result<void>> createAccount(
    RegisterUserRequest registerUserModel,
    String userRole,
  ) async {
    final fcmTokenLocal = await sharedPreferenceHelper
        .getString(SharedPreferenceKeys.deviceFcmTokenKey);

    final requestBody = registerUserModel.mapToData(
      userRole,
      fcmTokenLocal.isNotEmpty ? fcmTokenLocal : null,
    );
    final response = await apiCallHandler(
      httpClient: httpClient,
      requestType: HttpRequestEnum.POST,
      endpoint: "/auth/v1/register",
      requestBody: requestBody.toJson(),
      passedQueryParameters: null,
    );

    switch (response) {
      case Success():
        return Success("");
      case Failure():
        return Failure(
          Exception(response.error),
          message: response.message,
        );
    }
  }

  @override
  Future<Result<LoginResponse>> login(LoginRequestBody loginRequestBody) async {
    final response = await apiCallHandler(
      httpClient: httpClient,
      requestType: HttpRequestEnum.POST,
      endpoint: "auth/v1/login",
      requestBody: loginRequestBody.toJson(),
      passedQueryParameters: null,
    );

    try {
      switch (response) {
        case Success():
          final successResponse = LoginResponse.fromJson(response.data);
          if (successResponse.data != null && successResponse.success == true) {
            final accessToken = successResponse.data?.authToken;
            final refreshToken = successResponse.data?.refreshToken;
            final streamToken = successResponse.data?.streamAuthToken;
            final userId = successResponse.data?.userId;
            final userName = successResponse.data?.username;
            final userImageUrl =
                successResponse.data?.pictureUrlList?.firstOrNull?.presignedUrl;

            await sharedPreferenceHelper.saveUserData(
              accessToken,
              refreshToken,
              streamToken,
              userId.toString(),
              userName,
              userImageUrl,
            );

            await sharedPreferenceHelper
                .saveUserType(successResponse.data?.userRole ?? "user");

            await sharedPreferenceHelper.saveString(
              SharedPreferenceKeys.adminUserEmailKey,
              loginRequestBody.email ?? "",
            );

            await chatRepo.connectToServer();

            return Success(successResponse);
          } else {
            return Failure(Exception(successResponse.message),
                message: successResponse.message);
          }
        case Failure():
          debugLogger("LOGIN_FAILED", "Reason : ${response.error}");
          return Failure(Exception(response.error), message: response.message);
      }
    } catch (e) {
      debugLogger("LOGIN_FAILED", "Reason : $e");
      return Failure(Exception("LOGIN_FAILED Reason : $e"),
          message: "Something went wrong,");
    }
  }

  @override
  Future<Result<void>> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }

  @override
  Future<void> setAuthToken(String newAuthToken) async {
    await sharedPreferenceHelper.saveString(
      SharedPreferenceKeys.accessTokenKey,
      newAuthToken,
    );
  }

  @override
  Future<void> clearTheDbAfterRegistration() async {
    await profileDao.deleteOnBoardingProfile(NEW_ON_BOARD_USER_ID);
  }

  @override
  Future<RegisterUserRequest?> getOnBoardedUser() async {
    final user = await profileDao.getProfileData(NEW_ON_BOARD_USER_ID);
    return user?.mapToRequestUserModel();
  }

  @override
  Future<Result<void>> uploadMediaFile(List<File?> loadedFiles) async {
    FormData formData = FormData();
    for (int i = 0; i < loadedFiles.length; i++) {
      final file = loadedFiles[i];
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
        final storiesResponse =
            UniversalSuccessResponseBody<StoryUploadResponse>.fromJson(
          response.data,
          (mediaResponse) => StoryUploadResponse.fromJson(mediaResponse),
        );
        if (storiesResponse.data?.filesUploaded?.isNotEmpty == true) {
          return const Success(true);
        } else {
          return Failure(
            Exception(
                "Files ${storiesResponse.data?.filesNotUploaded} failed to upload"),
            message: storiesResponse.message,
          );
        }
      case Failure():
        return Failure(
          response.error,
          message: response.message,
        );
    }
  }

  Future<void> saveMembershipDetails(ProfileMembershipEntity entity) async {
    await membershipDao.insertMembership(entity);
  }
}
