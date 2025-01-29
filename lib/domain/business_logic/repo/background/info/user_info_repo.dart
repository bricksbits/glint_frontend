import 'package:glint_frontend/utils/network_response.dart';

abstract class UserInfoRepo {
  Future<NetworkResponse<void>> updateUserLocation();

  Future<NetworkResponse<void>> updateUserLastActiveTime();
}
