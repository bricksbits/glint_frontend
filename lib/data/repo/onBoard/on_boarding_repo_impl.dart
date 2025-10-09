import 'dart:math';

import 'package:glint_frontend/data/local/db/dao/profile_dao.dart';
import 'package:glint_frontend/data/local/db/entities/profile_entity.dart';
import 'package:glint_frontend/data/local/persist/async_encrypted_shared_preference_helper.dart';
import 'package:glint_frontend/data/local/persist/shared_pref_key.dart';
import 'package:glint_frontend/data/remote/client/http_request_enum.dart';
import 'package:glint_frontend/data/remote/client/my_dio_client.dart';
import 'package:glint_frontend/data/remote/model/request/on_board/on_board_request_body.dart';
import 'package:glint_frontend/data/remote/utils/api_call_handler.dart';
import 'package:glint_frontend/domain/business_logic/models/auth/register_user_request.dart';
import 'package:glint_frontend/domain/business_logic/repo/boarding/on_boarding_repo.dart';
import 'package:glint_frontend/features/onboarding/on_boarding_cubit.dart';
import 'package:glint_frontend/utils/result_sealed.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: OnBoardingRepo)
class OnBoardRepoImpl extends OnBoardingRepo {
  final ProfileDao profileDao;
  final AsyncEncryptedSharedPreferenceHelper sharedPreferenceHelper;
  final MyDioClient httpClient;

  OnBoardRepoImpl(
    this.profileDao,
    this.sharedPreferenceHelper,
    this.httpClient,
  );

  @override
  Future<void> clearDb() async {
    await profileDao.deleteOnBoardingProfile(NEW_ON_BOARD_USER_ID);
  }

  @override
  Future<OnBoardingCompletedTill> getCurrentBoardingState() async {
    final currentUpdatedState = await sharedPreferenceHelper
        .getString(SharedPreferenceKeys.lastOnBoardingState);
    if (currentUpdatedState.isEmpty || currentUpdatedState == "") {
      return OnBoardingCompletedTill.NOT_STARTED;
    } else {
      return OnBoardingCompletedTill.values.byName(currentUpdatedState);
    }
  }

  @override
  Future<Result<void>> updateUserDetailsLocally(
      RegisterUserRequest updatedModel) async {
    await profileDao.updateProfileData(updatedModel.mapToEntity());
    return const Result.success("");
  }

  @override
  Future<void> setupCurrentBoardingState(
      OnBoardingCompletedTill currentBoardingStep) async {
    await sharedPreferenceHelper.saveString(
        SharedPreferenceKeys.lastOnBoardingState, currentBoardingStep.name);
  }

  @override
  Future<Result<RegisterUserRequest>> getCurrentUserState() async {
    final currentUser = await profileDao.getProfileData(NEW_ON_BOARD_USER_ID);
    final registerUserModel = currentUser?.mapToRequestUserModel();
    if (registerUserModel != null) {
      return Success(registerUserModel);
    } else {
      return Failure(Exception("User doesn't exists, create new one"));
    }
  }

  @override
  Future<void> insertUser(RegisterUserRequest newTempUser) async {
    await profileDao.insertProfile(newTempUser.mapToEntity());
  }
}

//Todo: How to manage the Date of Birth here,
//todo: New request body is needed to be used here,
extension ProfileEntityToRequestMapper on ProfileEntity {
  OnBoardRequestBody mapTo(String encryptedPassword) {
    var random = Random().nextInt(999);
    return OnBoardRequestBody(
        username: username,
        password: encryptedPassword,
        phoneNumber: "NOT_PROVIDED",
        bio: bio,
        dateOfBirth: age,
        height: 180.2,
        education: education,
        occupation: occupation,
        gender: gender,
        genderPreference: genderPreference,
        workoutHabit: workoutHabit,
        drinkingHabit: drinkingHabit,
        smokingHabit: smokingHabit,
        relationshipGoals: [lookingFor],
        interests: interests,
        role: "",
        approvedByAdmin: true,
        fcmToken: "fcm_$random");
  }
}
