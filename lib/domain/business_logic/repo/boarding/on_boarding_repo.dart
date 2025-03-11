import 'package:glint_frontend/utils/network_response.dart';

abstract class OnBoardingRepo {
  Future<Result<void>> setUpUser();

  Future<Result<void>> uploadMedia();

  Future<Result<void>> getLastUpdateState();

  Future<Result<void>> updateLocation();
}
