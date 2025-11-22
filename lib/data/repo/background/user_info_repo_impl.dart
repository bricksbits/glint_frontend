import 'package:glint_frontend/data/local/persist/async_encrypted_shared_preference_helper.dart';
import 'package:glint_frontend/data/local/persist/shared_pref_key.dart';
import 'package:glint_frontend/data/remote/client/http_request_enum.dart';
import 'package:glint_frontend/data/remote/client/my_dio_client.dart';
import 'package:glint_frontend/data/remote/model/request/auth/fcm_token_request.dart';
import 'package:glint_frontend/data/remote/model/request/background/update_premium_request_body.dart';
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

  UserInfoRepoImpl(
    this.httpClient,
    this.sharedPreferenceHelper,
  );

  @override
  Future<Result<void>> updateFcmToken(String fcmTokenGenerated) async {
    var requestBody = FcmTokenRequest(fcmToken: fcmTokenGenerated).toJson();
    await sharedPreferenceHelper.saveString(
        SharedPreferenceKeys.deviceFcmTokenKey, fcmTokenGenerated);
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
    var updateLocationRequestBody = UpdateUserLcoationRequestBody(
      userId: 0,
      latitide: 12.45,
      longitude: 43.32,
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
  Future<Result<void>> getCurrentPremiumInfo() async {
    final response = await apiCallHandler(
      httpClient: httpClient,
      requestType: HttpRequestEnum.GET,
      endpoint: "/user/premium-info",
    );

    switch (response) {
      case Success():
        var membershipData = GetMembershipResponseBody.fromJson(response.data);
        //Todo: Update this data to DB
        return Success("");
      case Failure():
        debugLogger("Membership", "Failed to get the perks");
        return Failure(Exception("Error: ${response.error}"));
    }
  }

  /// Whenever the User uses the perks update the db and put it to server
  @override
  Future<Result<void>> updateCurrentPremiumInfo() async {
    // Todo: Get this data from DB and update the server.
    var requestBody = UpdatePremiumRequestBody(
      aiMessagesRemaining: 5,
      directDmRemaining: 2,
      rewindsRemaining: 2,
      superLikesRemaining: 1,
    );

    final response = await apiCallHandler(
        httpClient: httpClient,
        requestType: HttpRequestEnum.PUT,
        endpoint: "/user/premium-info",
        requestBody: requestBody.toJson());

    switch (response) {
      case Success():
        debugLogger("Membership", "New values updated");
        // Todo: New Value provided now update the db as well.
        return Success("");
      case Failure():
        debugLogger("Membership", "Failed to update the perks");
        return Failure(Exception("Error : ${response.error}"));
    }
  }
}
