import 'package:glint_frontend/data/local/db/dao/membership_dao.dart';
import 'package:glint_frontend/data/local/db/entities/profile_membership_entity.dart';
import 'package:glint_frontend/data/local/persist/async_encrypted_shared_preference_helper.dart';
import 'package:glint_frontend/data/local/persist/shared_pref_key.dart';
import 'package:glint_frontend/data/remote/client/http_request_enum.dart';
import 'package:glint_frontend/data/remote/client/my_dio_client.dart';
import 'package:glint_frontend/data/remote/model/request/auth/fcm_token_request.dart';
import 'package:glint_frontend/data/remote/model/request/background/update_user_lcoation_request_body.dart';
import 'package:glint_frontend/data/remote/model/response/membership/get_membership_response_body.dart';
import 'package:glint_frontend/data/remote/utils/api_call_handler.dart';
import 'package:glint_frontend/domain/business_logic/repo/background/info/user_info_repo.dart';
import 'package:glint_frontend/utils/logger.dart';
import 'package:glint_frontend/utils/result_sealed.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: UserInfoRepo)
class UserInfoRepoImpl extends UserInfoRepo {
  final MyDioClient httpClient;
  final AsyncEncryptedSharedPreferenceHelper sharedPreferenceHelper;
  final MembershipDao membershipDao;

  UserInfoRepoImpl(
    this.httpClient,
    this.sharedPreferenceHelper,
    this.membershipDao,
  );

  @override
  Future<Result<void>> updateFcmTokenToServer() async {
    final fcmToken = await sharedPreferenceHelper.getString(
      SharedPreferenceKeys.deviceFcmTokenKey,
    );
    if (fcmToken.isNotEmpty) {
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
          return Failure(
            Exception("Error : ${response.error} Failed to update FCM"),
          );
      }
    } else {
      return Failure(
        Exception("Error : Can't update FCM Token, as there is no token"),
      );
    }
  }

  @override
  Future<Result<void>> updateUserLastActiveTime() {
    // TODO: implement updateUserLastActiveTime
    throw UnimplementedError();
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

    var updateLocationRequestBody = UpdateUserLcoationRequestBody(
      userId: int.parse(userId),
      latitide: userLat,
      longitude: userLong,
    );

    final response = await apiCallHandler(
      httpClient: httpClient,
      requestType: HttpRequestEnum.GET,
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

  /// Get the User Premium info and update the DB
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
        final membershipEntity = membershipDataFromRemote.mapToEntity(userId);
        membershipDao.updateTheMembershipDetails(membershipEntity);
        return Success("");
      case Failure():
        debugLogger("Membership", "Failed to get the perks");
        return Failure(Exception("Error: ${response.error}"));
    }
  }

  /// Whenever the User uses the perks update the db and put it to server
  @override
  Future<Result<void>> updateCurrentPremiumInfo(
      ProfileMembershipEntity entity) async {
    var requestBody = entity.mapToRequestBody();
    final response = await apiCallHandler(
      httpClient: httpClient,
      requestType: HttpRequestEnum.PUT,
      endpoint: "/user/premium-info",
      requestBody: requestBody.toJson(),
    );

    switch (response) {
      case Success():
        debugLogger("Membership", "New values updated");
        await membershipDao.updateTheMembershipDetails(entity);
        return Success("");
      case Failure():
        debugLogger("Membership", "Failed to update the perks");
        return Failure(Exception("Error : ${response.error}"));
    }
  }

  @override
  Future<Result<ProfileMembershipEntity>> getCurrentUserPremiumInfo() async {
    //Todo: What if user is not premium user, disable unwanted calls,
    fetchCurrentPremiumInfo();
    final userId =
        await sharedPreferenceHelper.getString(SharedPreferenceKeys.userIdKey);
    final membershipEntity = await membershipDao.getMembership(userId);
    if (membershipEntity != null) {
      return Success(membershipEntity);
    } else {
      return Failure(Exception("No Membership data found"));
    }
  }

  @override
  Future<void> updateFcmTokenLocally(String fcmTokenGenerated) async {
    await sharedPreferenceHelper.saveString(
      SharedPreferenceKeys.deviceFcmTokenKey,
      fcmTokenGenerated,
    );
  }
}
