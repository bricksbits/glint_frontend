import 'package:glint_frontend/data/remote/model/request/auth/login_request_body.dart';
import 'package:glint_frontend/data/remote/model/response/auth/login_response.dart';
import 'package:glint_frontend/utils/network_response.dart';

abstract class AuthenticationRepo {
  Future<Result<LoginResponse>> login(LoginRequestBody loginRequestBody);

  Future<Result<void>> createAccount();

  Future<void> setAuthToken(String newAuthToken);

  Future<Result<void>> logout();
}
