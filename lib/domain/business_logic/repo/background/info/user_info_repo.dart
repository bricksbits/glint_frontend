import 'package:glint_frontend/utils/result_sealed.dart';

abstract class UserInfoRepo {
  Future<Result<void>> updateUserLocation();

  Future<Result<void>> updateUserLastActiveTime();

  Future<Result<void>> updateFcmToken(String fcmTokenGenerated);

  // To showcase in the Profile Screen and let user use their perks
  Future<Result<void>> getCurrentPremiumInfo();

  // Once any perks used update the premium information
  Future<Result<void>> updateCurrentPremiumInfo();
}
