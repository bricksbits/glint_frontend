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
import 'package:glint_frontend/data/remote/model/response/auth/login_mapper.dart';
import 'package:glint_frontend/data/remote/model/response/auth/login_response.dart';
import 'package:glint_frontend/data/remote/model/response/chat/story_upload_response.dart';
import 'package:glint_frontend/data/remote/utils/api_call_handler.dart';
import 'package:glint_frontend/domain/business_logic/models/auth/register_user_request.dart';
import 'package:glint_frontend/domain/business_logic/models/common/UsersType.dart';
import 'package:glint_frontend/domain/business_logic/repo/auth/authentication_repo.dart';
import 'package:glint_frontend/domain/business_logic/repo/boarding/on_boarding_repo.dart';
import 'package:glint_frontend/utils/result_sealed.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: AuthenticationRepo)
class AuthenticationRepoImpl extends AuthenticationRepo {
  final MyDioClient httpClient;
  final AsyncEncryptedSharedPreferenceHelper sharedPreferenceHelper;
  final ProfileDao profileDao;
  final MembershipDao membershipDao;

  AuthenticationRepoImpl(
    this.httpClient,
    this.sharedPreferenceHelper,
    this.profileDao,
    this.membershipDao,
  );

  //Todo: Save the new Data to the Local \
  // Tokens
  // Profile Response to Db
  @override
  Future<Result<void>> createAccount(
    RegisterUserRequest registerUserModel,
    String userRole,
  ) async {
    final requestBody = registerUserModel.mapToData(userRole);
    final response = await apiCallHandler(
      httpClient: httpClient,
      requestType: HttpRequestEnum.POST,
      endpoint: "/auth/v1/register",
      requestBody: requestBody.toJson(),
      passedQueryParameters: null,
    );

    switch (response) {
      case Success():
        return Success(response.data);
      case Failure():
        return Failure(Exception(response.error));
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

    switch (response) {
      case Success():
        final successResponse = LoginResponse.fromJson(response.data);
        await profileDao.insertProfile(successResponse.mapToEntity());
        final accessToken = successResponse.profile?.authToken;
        final refreshToken = successResponse.profile?.refreshToken;
        final streamToken = successResponse.profile?.streamAuthToken;
        final userId = successResponse.profile?.userId;
        final userName = successResponse.profile?.username;
        if (successResponse.profile != null) {
          saveMembershipDetails(
            ProfileMembershipEntity(
              userId: successResponse.profile!.userId.toString(),
              superLikes: successResponse.profile!.superLikesLeft ?? 0,
              aiMessages: successResponse.profile!.aiMessagesRemaining ?? 0,
              rewinds: successResponse.profile!.rewindsRemaining ?? 0,
              superDm: successResponse.profile!.directDmRemaining ?? 0,
            ),
          );
        }
        sharedPreferenceHelper.saveUserData(accessToken, refreshToken,
            streamToken, userId.toString(), userName);

        return Success(successResponse);
      case Failure():
        return Failure(Exception());
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

  Future<void> saveMembershipDetails(ProfileMembershipEntity entity) async {
    await membershipDao.insertMembership(entity);
  }
}
