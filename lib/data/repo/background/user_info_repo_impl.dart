import 'package:glint_frontend/data/local/db/dao/membership_dao.dart';
import 'package:glint_frontend/data/local/db/dao/profile_dao.dart';
import 'package:glint_frontend/data/local/db/entities/profile_membership_entity.dart';
import 'package:glint_frontend/data/local/persist/async_encrypted_shared_preference_helper.dart';
import 'package:glint_frontend/data/local/persist/shared_pref_key.dart';
import 'package:glint_frontend/data/remote/client/http_request_enum.dart';
import 'package:glint_frontend/data/remote/client/my_dio_client.dart';
import 'package:glint_frontend/data/remote/model/request/auth/fcm_token_request.dart';
import 'package:glint_frontend/data/remote/model/request/background/update_user_lcoation_request_body.dart';
import 'package:glint_frontend/data/remote/model/request/chat/super_dm_on_request_body.dart';
import 'package:glint_frontend/data/remote/model/response/chat/super_dm_response_body.dart';
import 'package:glint_frontend/data/remote/model/response/mapper/memebership_mapper.dart';
import 'package:glint_frontend/data/remote/model/response/membership/get_membership_response_body.dart';
import 'package:glint_frontend/data/remote/model/response/profile/its_me_body_mapper.dart';
import 'package:glint_frontend/data/remote/utils/api_call_handler.dart';
import 'package:glint_frontend/domain/business_logic/repo/background/info/user_info_repo.dart';
import 'package:glint_frontend/utils/logger.dart';
import 'package:glint_frontend/utils/result_sealed.dart';
import 'package:injectable/injectable.dart';

import '../../remote/model/response/profile/its_me_response_body.dart';

@LazySingleton(as: UserInfoRepo)
class UserInfoRepoImpl extends UserInfoRepo {
  final MyDioClient httpClient;
  final AsyncEncryptedSharedPreferenceHelper sharedPreferenceHelper;
  final MembershipDao membershipDao;
  final ProfileDao profileDao;

  UserInfoRepoImpl(
    this.httpClient,
    this.sharedPreferenceHelper,
    this.membershipDao,
    this.profileDao,
  );

  @override
  Future<Result<void>> updateFcmTokenToServer() async {
    final userId =
        await sharedPreferenceHelper.getString(SharedPreferenceKeys.userIdKey);
    final fcmToken = await sharedPreferenceHelper.getString(
      SharedPreferenceKeys.deviceFcmTokenKey,
    );
    if (fcmToken.isNotEmpty && userId.isNotEmpty) {
      var requestBody = FcmTokenRequest(fcmToken: fcmToken).toJson();
      final response = await apiCallHandler(
        httpClient: httpClient,
        requestType: HttpRequestEnum.PUT,
        endpoint: "/user/fcm-token",
        requestBody: requestBody,
        passedQueryParameters: null,
      );

      switch (response) {
        case Success():
          debugLogger("FCM_TOKEN", "Token updated");
          return Success("");
        case Failure():
          debugLogger("FCM_TOKEN", "Token failed to updated");
          return Failure(response.error);
      }
    } else {
      return Failure(
        Exception("Error : Can't update FCM Token, as there is no token"),
      );
    }
  }

  /// Get the Current Location and User Id from Shared Pref and make the API request
  /// Should be called whenever users enters the app
  @override
  Future<Result<void>> updateUserLocation() async {
    final userId =
        await sharedPreferenceHelper.getString(SharedPreferenceKeys.userIdKey);
    final userLat = await sharedPreferenceHelper
        .getDouble(SharedPreferenceKeys.userLatitudeKey);
    final userLong = await sharedPreferenceHelper
        .getDouble(SharedPreferenceKeys.userLongitudeKey);

    if (userId.isNotEmpty && userLong != 0 && userLat != 0) {
      var updateLocationRequestBody = UpdateUserLcoationRequestBody(
        userId: int.parse(userId),
        latitide: userLat,
        longitude: userLong,
      );

      final response = await apiCallHandler(
        httpClient: httpClient,
        requestType: HttpRequestEnum.PUT,
        endpoint: "/user/location",
        requestBody: updateLocationRequestBody.toJson(),
        passedQueryParameters: null,
      );

      switch (response) {
        case Success():
          debugLogger("LOCATION",
              "User location updated, with value ${updateLocationRequestBody.latitide} & ${updateLocationRequestBody.longitude}");
          return Success("");
        case Failure():
          debugLogger("LOCATION", "Failed to update the user location");
          return Failure(Exception("Error: ${response.error}"));
      }
    }
    return Failure(Exception("No Users ID allocated yet"));
  }

  @override
  Future<Result<void>> fetchCurrentPremiumInfo() async {
    final response = await apiCallHandler(
      httpClient: httpClient,
      requestType: HttpRequestEnum.GET,
      endpoint: "/user/premium-info",
    );

    final userId =
        await sharedPreferenceHelper.getString(SharedPreferenceKeys.userIdKey);
    switch (response) {
      case Success():
        final membershipDataFromRemote =
            GetMembershipResponseBody.fromJson(response.data);
        if (membershipDataFromRemote.data != null &&
            membershipDataFromRemote.success == true) {
          final membershipEntity =
              membershipDataFromRemote.mapToEntity(userId);
          membershipDao.updateTheMembershipDetails(membershipEntity);
          return Success("");
        }
        return Failure(Exception(membershipDataFromRemote.message));
      case Failure():
        debugLogger("Membership", "Failed to get the perks");
        return Failure(Exception("Error: ${response.error}"));
    }
  }

  /// Whenever the User uses the perks update the db and put it to server
  @override
  Future<Result<void>> setLocalUserPremiumInfo(
    ProfileMembershipEntity entity,
  ) async {
    await membershipDao.updateTheMembershipDetails(entity);
    return Success("");
  }

  @override
  Future<Result<ProfileMembershipEntity>> getLocalUserPremiumInfo() async {
    final isPremiumUser = await sharedPreferenceHelper
        .getBoolean(SharedPreferenceKeys.premiumUserKey);
    if (isPremiumUser) {
      final userId = await sharedPreferenceHelper
          .getString(SharedPreferenceKeys.userIdKey);
      final membershipEntity = await membershipDao.getMembership(userId);
      if (membershipEntity != null) {
        return Success(membershipEntity);
      } else {
        return Failure(Exception("No Membership data found"));
      }
    }

    return Failure(Exception("Current user is not a premium user."));
  }

  @override
  Future<void> updateFcmTokenLocally(String fcmTokenGenerated) async {
    await sharedPreferenceHelper.saveString(
      SharedPreferenceKeys.deviceFcmTokenKey,
      fcmTokenGenerated,
    );
  }

  @override
  Future<Result<void>> getAndCacheUserInfo() async {
    final getProfileAsResponse = await apiCallHandler(
      httpClient: httpClient,
      requestType: HttpRequestEnum.GET,
      endpoint: "user/profile/me",
    );

    switch (getProfileAsResponse) {
      case Success():
        final itsMeBody = ItsMeResponseBody.fromJson(getProfileAsResponse.data);
        if (itsMeBody.success == true && itsMeBody.data != null) {
          cacheUserProfile(itsMeBody);
          return Success("");
        } else {
          return Failure(Exception(itsMeBody.message),
              message: itsMeBody.message);
        }
      case Failure():
        return Failure(getProfileAsResponse.error,
            message: getProfileAsResponse.message);
    }
  }

  Future<void> cacheUserProfile(ItsMeResponseBody successResponse) async {
    await profileDao.insertProfile(successResponse.mapToEntity());
    final userId = successResponse.data?.userId;
    final userName = successResponse.data?.username;
    final userImageUrl =
        successResponse.data?.pictureUrlList?.firstOrNull?.presignedUrl;
    if (successResponse.data != null) {
      saveMembershipDetails(
        ProfileMembershipEntity(
          userId: successResponse.data?.userId.toString() ?? "user_id",
          superLikes: successResponse.data?.superLikesLeft ?? 0,
          aiMessages: successResponse.data?.aiMessagesRemaining ?? 0,
          rewinds: successResponse.data?.rewindsRemaining ?? 0,
          superDm: successResponse.data?.directDmRemaining ?? 0,
        ),
      );
    }
    await sharedPreferenceHelper.saveUserData(
      null,
      null,
      null,
      userId.toString(),
      userName,
      userImageUrl,
    );

    await sharedPreferenceHelper
        .saveUserType(successResponse.data?.userRole ?? "user");

    await sharedPreferenceHelper.saveString(
      SharedPreferenceKeys.adminUserOrganizationKey,
      successResponse.data?.occupation ?? "Event Manager",
    );

    await sharedPreferenceHelper.saveBoolean(
      SharedPreferenceKeys.premiumUserKey,
      successResponse.data?.isPremiumUser ?? false,
    );
  }

  Future<void> saveMembershipDetails(ProfileMembershipEntity entity) async {
    await membershipDao.insertMembership(entity);
  }

  @override
  Future<bool> isPremiumUser() async {
    final isPremium = await sharedPreferenceHelper
        .getBoolean(SharedPreferenceKeys.premiumUserKey);
    return isPremium;
  }

  @override
  Future<String?> fetchDirectDmChannelIdWithUserId(String onUserId) async {
    final superDmRequest =
        SuperDmOnRequestBody(onUserId: int.parse(onUserId)).toJson();
    final getProfileAsResponse = await apiCallHandler(
      httpClient: httpClient,
      requestType: HttpRequestEnum.POST,
      endpoint: "user/chat/direct-message",
      requestBody: superDmRequest,
    );

    switch (getProfileAsResponse) {
      case Success():
        final superDmResponse =
            SuperDmResponseBody.fromJson(getProfileAsResponse.data);
        if (superDmResponse.success == true) {
          return superDmResponse.data?.streamChatChannelId;
        }
        break;
      case Failure():
        return null;
    }
    return null;
  }
}
