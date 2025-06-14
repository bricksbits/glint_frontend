import 'package:glint_frontend/features/onboarding/on_boarding_cubit.dart';
import 'package:glint_frontend/features/people/model/people_model.dart';
import 'package:glint_frontend/utils/result_sealed.dart';

const String NEW_ON_BOARD_USER_ID = "NEW_ON_BOARD_USER_ID";

abstract class OnBoardingRepo {
  Future<Result<void>> registerNewUser();

  Future<Result<void>> updateUserDetailsLocally(PeopleUiModel updatedModel);

  Future<void> clearDb();

  Future<Result<void>> uploadMedia();

  Future<OnBoardingCompletedTill> getLastUpdateState();

  Future<Result<void>> updateLocation();
}
