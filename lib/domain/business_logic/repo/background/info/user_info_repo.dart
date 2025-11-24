import 'package:glint_frontend/data/local/db/entities/profile_membership_entity.dart';
import 'package:glint_frontend/utils/result_sealed.dart';

abstract class UserInfoRepo {
  Future<Result<void>> updateUserLocation();

  Future<Result<void>> updateUserLastActiveTime();

  Future<Result<void>> updateFcmToken(String fcmTokenGenerated);

  Future<Result<void>> fetchCurrentPremiumInfo();

  Future<Result<void>> updateCurrentPremiumInfo(ProfileMembershipEntity entity);

  Future<Result<ProfileMembershipEntity>> getCurrentUserPremiumInfo();
}
