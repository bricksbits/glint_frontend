import 'package:encrypt_shared_preferences/provider.dart';
import 'package:glint_frontend/data/local/db/dao/profile_dao.dart';
import 'package:glint_frontend/data/local/db/entities/profile_entity.dart';
import 'package:glint_frontend/data/local/persist/async_encrypted_shared_preference_helper.dart';
import 'package:glint_frontend/data/local/persist/shared_pref_key.dart';
import 'package:glint_frontend/data/remote/client/http_request_enum.dart';
import 'package:glint_frontend/data/remote/client/my_dio_client.dart';
import 'package:glint_frontend/data/remote/model/request/auth/login_request_body.dart';
import 'package:glint_frontend/data/remote/model/request/auth/register_account_request_body.dart';
import 'package:glint_frontend/data/remote/model/response/auth/login_response.dart';
import 'package:glint_frontend/data/remote/utils/api_call_handler.dart';
import 'package:glint_frontend/domain/business_logic/models/auth/register_user_request.dart';
import 'package:glint_frontend/domain/business_logic/repo/auth/authentication_repo.dart';
import 'package:glint_frontend/domain/business_logic/repo/boarding/on_boarding_repo.dart';
import 'package:glint_frontend/features/onboarding/on_boarding_cubit.dart';
import 'package:glint_frontend/utils/result_sealed.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: AuthenticationRepo)
class AuthenticationRepoImpl extends AuthenticationRepo {
  final MyDioClient httpClient;
  final AsyncEncryptedSharedPreferenceHelper sharedPreferenceHelper;
  final ProfileDao profileDao;

  AuthenticationRepoImpl(
    this.httpClient,
    this.sharedPreferenceHelper,
    this.profileDao,
  );

  @override
  Future<Result<void>> createAccount(
    RegisterUserRequest registerUserModel,
    String userRole,
  ) async {
    final requestBody = registerUserModel.mapToData(userRole);
    final response = await apiCallHandler(
      httpClient: httpClient,
      requestType: HttpRequestEnum.POST,
      endpoint: "/registerUser",
      requestBody: requestBody.toJson(),
      passedQueryParameters: null,
    );

    return Future.value(Failure(Exception()));
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
        final accessToken = successResponse.profile?.authToken;
        if (accessToken != null) {
          if (accessToken.isNotEmpty) {
            await sharedPreferenceHelper.saveString(
                SharedPreferenceKeys.accessTokenKey, accessToken);
          }
        }

        final refreshToken = successResponse.profile?.refreshToken;
        if (refreshToken != null) {
          if (refreshToken.isNotEmpty) {
            await sharedPreferenceHelper.saveString(
                SharedPreferenceKeys.refreshTokenKey, refreshToken);
          }
        }

        final tokenBufferTime = DateTime.now()
            .add(const Duration(minutes: 55))
            .microsecondsSinceEpoch;

        await sharedPreferenceHelper.saveInt(
            SharedPreferenceKeys.lastSavedTimeKey, tokenBufferTime);

        return Future.value(Success(successResponse));

      case Failure():
        return Future.value(Failure(Exception()));
    }
  }

  @override
  Future<Result<void>> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }

  @override
  Future<void> setAuthToken(String newAuthToken) async {
    const key = "";
    await EncryptedSharedPreferencesAsync.initialize(key);
    final sharedPreferencesAsync =
        EncryptedSharedPreferencesAsync.getInstance();
    sharedPreferencesAsync.setString("authToken", newAuthToken);
  }

  @override
  Future<void> clearTheDbAfterRegistration() async {
    await profileDao.deleteOnBoardingProfile(NEW_ON_BOARD_USER_ID);
  }

  @override
  Future<RegisterUserRequest?> getOnBoardedUser() async {
    final user = await profileDao.getProfileData(NEW_ON_BOARD_USER_ID);
    return user?.mapToDomain();
  }

  @override
  Future<OnBoardingCompletedTill> getOnBoardingStatusTillNow() async {
    OnBoardingCompletedTill currentState = OnBoardingCompletedTill.NOT_STARTED;
    final user = await profileDao.getProfileData(NEW_ON_BOARD_USER_ID);
    if (user?.name == null) {
      currentState = OnBoardingCompletedTill.NOT_STARTED;
    } else if (user?.age == null) {
      currentState = OnBoardingCompletedTill.NAME_PROVIDED;
    } else if (user?.pronouns == null) {
      currentState = OnBoardingCompletedTill.AGE_CALCULATED;
    } else if (user?.choiceOfGender == null) {
      currentState = OnBoardingCompletedTill.GENDER_SELECTED;
    } else if (user?.profilePics == null) {
      currentState = OnBoardingCompletedTill.CHOICE_OF_GENDER_SELECTED;
    } else if (user?.lookingFor == null) {
      currentState = OnBoardingCompletedTill.IMAGES_SELECTED;
    } else if (user?.interests == null) {
      currentState = OnBoardingCompletedTill.PRONOUNS_DONE;
    } else if (user?.bio == null) {
      currentState = OnBoardingCompletedTill.INTERESTS_DONE;
    } else {
      currentState = OnBoardingCompletedTill.COMPLETED;
    }

    return currentState;
  }
}
