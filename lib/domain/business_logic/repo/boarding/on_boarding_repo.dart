import 'package:glint_frontend/domain/business_logic/models/auth/register_user_request.dart';
import 'package:glint_frontend/features/onboarding/on_boarding_cubit.dart';
import 'package:glint_frontend/utils/result_sealed.dart';

const String NEW_ON_BOARD_USER_ID = "NEW_ON_BOARD_USER_ID";

abstract class OnBoardingRepo {
  Future<Result<void>> registerNewUser();

  Future<Result<void>> updateUserDetailsLocally(RegisterUserRequest updatedModel);

  Future<void> clearDb();

  Future<Result<void>> uploadMedia();

  Future<OnBoardingCompletedTill> getCurrentBoardingState();

  Future<Result<RegisterUserRequest>> getCurrentUserState();

  Future<void> setupCurrentBoardingState(OnBoardingCompletedTill currentBoardingStep);

  Future<Result<void>> updateLocation();
}
