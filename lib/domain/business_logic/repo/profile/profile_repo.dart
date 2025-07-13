import 'package:glint_frontend/utils/result_sealed.dart';

abstract class ProfileRepo {
  Future<Result<void>> fetchUserProfile();

  Future<Result<void>> updateProfileData();

  Future<Result<void>> updateMedia();

  Future<Result<void>> verifyUser();

  Future<int> getProfileProgress();

  Future<Result<void>> getUserMembershipDetails();
}
