import 'package:glint_frontend/data/remote/model/request/auth/login_request_body.dart';
import 'package:glint_frontend/data/remote/model/response/auth/login_response.dart';
import 'package:glint_frontend/domain/business_logic/models/auth/register_user_request.dart';
import 'package:glint_frontend/features/onboarding/on_boarding_cubit.dart';
import 'package:glint_frontend/utils/result_sealed.dart';

abstract class AuthenticationRepo {
  Future<Result<LoginResponse>> login(LoginRequestBody loginRequestBody);

  Future<Result<void>> createAccount(
    RegisterUserRequest registerUserModel,
    String userRole,
  );

  Future<void> setAuthToken(String newAuthToken);

  Future<Result<void>> logout();

  Future<RegisterUserRequest?> getOnBoardedUser();

  Future<void> clearTheDbAfterRegistration();

  Future<OnBoardingCompletedTill> getOnBoardingStatusTillNow();
}
