import 'package:glint_frontend/data/remote/model/request/auth/login_request_body.dart';
import 'package:glint_frontend/utils/network_response.dart';

abstract class AuthenticationRepo {
  Future<NetworkResponse<void>> login(LoginRequestBody loginRequestBody);

  Future<NetworkResponse<void>> createAccount();

  Future<void> setAuthToken(String newAuthToken);

  Future<NetworkResponse<void>> logout();
}
