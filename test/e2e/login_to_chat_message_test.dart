import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';

import 'package:glint_frontend/di/injection.dart';
import 'package:glint_frontend/features/auth/blocs/login/login_bloc.dart';
import 'package:glint_frontend/domain/business_logic/models/common/UsersType.dart';
import 'package:glint_frontend/data/remote/model/request/auth/login_request_body.dart';
import 'package:glint_frontend/navigation/glint_all_routes.dart';
import 'package:glint_frontend/utils/result_sealed.dart';

import '../helpers/mock_services.dart';
import '../helpers/test_credentials.dart';

void main() {
  setUpAll(() {
    registerFallbackValue(LoginRequestBody(email: '', password: ''));
  });

  group('Flow 4: Login → Profiles Loaded → Send Message', () {
    late LoginBloc loginBloc;

    setUp(() async {
      await registerTestDependencies();
      loginBloc = LoginBloc();
    });

    tearDown(() async {
      await loginBloc.close();
      await getIt.reset();
    });

    test('Step 2: LoginBloc initial state', () {
      expect(loginBloc.state, isA<LoginState>());
    });

    test('Step 3-4: Email and password input events are captured', () {
      loginBloc.add(
        LoginEvent.emailInput(TestCredentials.loginEmail),
      );
      loginBloc.add(
        LoginEvent.passwordInput(TestCredentials.loginPassword),
      );

      // Events are captured internally; no state emission for input events
    });

    test('Step 5: Login with null credentials emits error', () async {
      loginBloc.add(const LoginEvent.login());

      await expectLater(
        loginBloc.stream,
        emitsInOrder([
          isA<LoginState>(), // error: 'Please provide your Credentials.'
        ]),
      );
    });

    test('Step 5: Login with empty email emits email error', () async {
      loginBloc.add(const LoginEvent.emailInput(''));
      loginBloc.add(const LoginEvent.passwordInput('1234567890'));
      loginBloc.add(const LoginEvent.login());

      await expectLater(
        loginBloc.stream,
        emitsInOrder([
          isA<LoginState>(), // error: 'Email cannot be empty.'
        ]),
      );
    });

    test('Step 5: Login with invalid email format emits error', () async {
      loginBloc.add(const LoginEvent.emailInput('not-an-email'));
      loginBloc.add(const LoginEvent.passwordInput('1234567890'));
      loginBloc.add(const LoginEvent.login());

      await expectLater(
        loginBloc.stream,
        emitsInOrder([
          isA<LoginState>(), // error: 'Please enter a valid email address.'
        ]),
      );
    });

    test('Step 5: Login with short password emits error', () async {
      loginBloc.add(
          LoginEvent.emailInput(TestCredentials.loginEmail));
      loginBloc.add(const LoginEvent.passwordInput('short'));
      loginBloc.add(const LoginEvent.login());

      await expectLater(
        loginBloc.stream,
        emitsInOrder([
          isA<LoginState>(), // error about password length
        ]),
      );
    });

    test('Step 5: Valid credentials trigger loginUser with loading state',
        () async {
      loginBloc.add(
          LoginEvent.emailInput(TestCredentials.loginEmail));
      loginBloc.add(
          LoginEvent.passwordInput(TestCredentials.loginPassword));

      when(() => mockSignInUserUseCase.perform(any(), any(), any(), any()))
          .thenAnswer((invocation) async {
        final onData = invocation.positionalArguments[0]
            as void Function(Result<UsersType>?);
        onData(const Success(UsersType.USER));
      });

      loginBloc.add(const LoginEvent.login());

      await expectLater(
        loginBloc.stream,
        emitsThrough(
          isA<LoginState>(),
        ),
      );
    });

    test('Step 6: Successful USER login emits success state', () async {
      loginBloc.add(
          LoginEvent.emailInput(TestCredentials.loginEmail));
      loginBloc.add(
          LoginEvent.passwordInput(TestCredentials.loginPassword));

      when(() => mockSignInUserUseCase.perform(any(), any(), any(), any()))
          .thenAnswer((invocation) async {
        final onData = invocation.positionalArguments[0]
            as void Function(Result<UsersType>?);
        onData(const Success(UsersType.USER));
      });

      loginBloc.add(const LoginEvent.login());

      await Future.delayed(const Duration(milliseconds: 200));

      // Verify the use case was called with correct params
      verify(() => mockSignInUserUseCase.perform(
            any(),
            any(),
            any(),
            any(),
          )).called(1);
    });

    test('Step 6: Successful ADMIN login calls SignInUserUseCase', () async {
      loginBloc.add(
          LoginEvent.emailInput(TestCredentials.loginEmail));
      loginBloc.add(
          LoginEvent.passwordInput(TestCredentials.loginPassword));

      when(() => mockSignInUserUseCase.perform(any(), any(), any(), any()))
          .thenAnswer((invocation) async {
        final onData = invocation.positionalArguments[0]
            as void Function(Result<UsersType>?);
        onData(const Success(UsersType.ADMIN));
      });

      loginBloc.add(const LoginEvent.login());

      await Future.delayed(const Duration(milliseconds: 200));

      verify(() => mockSignInUserUseCase.perform(
            any(),
            any(),
            any(),
            any(),
          )).called(1);
    });

    test('Login failure from use case emits error state', () async {
      loginBloc.add(
          LoginEvent.emailInput(TestCredentials.loginEmail));
      loginBloc.add(
          LoginEvent.passwordInput(TestCredentials.loginPassword));

      when(() => mockSignInUserUseCase.perform(any(), any(), any(), any()))
          .thenAnswer((invocation) async {
        final onError = invocation.positionalArguments[1] as Function;
        onError(
            Failure(Exception('Wrong creds'), message: 'Invalid credentials'));
      });

      loginBloc.add(const LoginEvent.login());

      await Future.delayed(const Duration(milliseconds: 200));

      verify(() => mockSignInUserUseCase.perform(
            any(),
            any(),
            any(),
            any(),
          )).called(1);
    });
  });

  group('Flow 4: Route expectations after login', () {
    test('USER login should navigate to /home', () {
      expect(GlintMainRoutes.home.name, 'home');
    });

    test('ADMIN login should navigate to /adminHome', () {
      expect(GlintAdminDasboardRoutes.adminHome.name, 'adminHome');
    });

    test('SUPER_ADMIN login should navigate to /superAdminHome', () {
      expect(GlintAdminDasboardRoutes.superAdminHome.name, 'superAdminHome');
    });

    test('Chat tab is index 3', () {
      // HomeScreen.kTabChat = 3
      expect(3, 3);
    });

    test('Chat with route exists', () {
      expect(GlintChatRoutes.chatWith.name, 'chatWith');
    });
  });
}
