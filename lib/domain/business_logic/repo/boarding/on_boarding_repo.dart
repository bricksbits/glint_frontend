import 'package:glint_frontend/utils/network_response.dart';

abstract class OnBoardingRepo {
  Future<NetworkResponse<void>> setUpUser();

  Future<NetworkResponse<void>> uploadMedia();

  Future<NetworkResponse<void>> getLastUpdateState();

  Future<NetworkResponse<void>> updateLocation();
}
