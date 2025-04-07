import 'package:flutter_test/flutter_test.dart';
import 'package:glint_frontend/data/remote/client/my_dio_client.dart';
import 'package:glint_frontend/di/injection.dart';
import 'package:glint_frontend/domain/application_logic/auth/sign_in_user_use_case.dart';
import 'package:glint_frontend/domain/business_logic/repo/auth/authentication_repo.dart';

void main() {
  test('Dependencies should be registered', () {
    configureDependencies(); // Initialize DI

    // expect(getIt.isRegistered<AuthenticationRepo>(), true, reason: "AuthenticationRepo should be registered");
    // expect(getIt.isRegistered<SignInUserUseCase>(), true, reason: "SignInUseCase should be registered");
    expect(getIt.isRegistered<MyDioClient>(), true, reason: "Dio Client should be registered");
  });
}
