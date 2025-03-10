import 'package:glint_frontend/utils/network_response.dart';

abstract class UserInfoRepo {
  Future<Result<void>> updateUserLocation();

  Future<Result<void>> updateUserLastActiveTime();
}
