import 'package:glint_frontend/utils/result_sealed.dart';

abstract class OnBoardingRepo {
  Future<Result<void>> setUpUser();

  Future<Result<void>> uploadMedia();

  Future<Result<void>> getLastUpdateState();

  Future<Result<void>> updateLocation();
}
