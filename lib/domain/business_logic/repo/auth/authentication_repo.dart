import 'package:glint_frontend/utils/network_response.dart';

abstract class AuthenticationRepo {
  Future<NetworkResponse<void>> login();

  Future<NetworkResponse<void>> createAccount();
}
