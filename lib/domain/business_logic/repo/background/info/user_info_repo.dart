import 'package:glint_frontend/utils/result_sealed.dart';

abstract class UserInfoRepo {
  Future<Result<void>> updateUserLocation();

  Future<Result<void>> updateUserLastActiveTime();
}
