import 'package:glint_frontend/utils/network_response.dart';

abstract class ForgotPasswordRepo {
  Future<NetworkResponse<void>> provideEmailId();

  Future<NetworkResponse<void>> provideOtp();

  Future<NetworkResponse<void>> resetPassword();
}
