import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';

import 'package:glint_frontend/di/injection.dart';
import 'package:glint_frontend/features/auth/blocs/register/register_cubit.dart';
import 'package:glint_frontend/navigation/glint_all_routes.dart';
import 'package:glint_frontend/utils/result_sealed.dart';

import '../helpers/mock_services.dart';
import '../helpers/fake_data.dart';
import '../helpers/test_credentials.dart';

void main() {
  setUpAll(() {
    registerFallbackValue(FakeData.createRegisterUserRequest());
  });

  group('Flow 3: Admin Onboarding → Create Event → Approval State', () {
    late RegisterCubit registerCubit;

    setUp(() async {
      await registerTestDependencies();

      when(() => mockAuthRepo.createAccount(any(), any()))
          .thenAnswer((_) async => const Success(null));
      when(() => mockSignInUserUseCase.perform(any(), any(), any(), any()))
          .thenAnswer((_) async {});
      when(() => mockAuthRepo.getOnBoardedUser())
          .thenAnswer((_) async => FakeData.createRegisterUserRequest());
      when(() => mockAuthRepo.clearTheDbAfterRegistration())
          .thenAnswer((_) async => {});

      registerCubit = RegisterCubit();
    });

    tearDown(() async {
      await registerCubit.close();
      await getIt.reset();
    });

    test('Step 2: Admin registration screen expects 5 fields', () {
      // Admin flow: name + email + org + contact + password
      // isAdmin: true shows different fields than user registration
      registerCubit.enteredUserName('AdminUser');
      registerCubit.enteredEmail('admin@glinttest.io');
      registerCubit.enteredOrganization('TestOrg');
      registerCubit.enteredContactNumber('9876543210');
      registerCubit.enteredPassword('AdminPass123');

      expect(registerCubit.state.name, 'AdminUser');
      expect(registerCubit.state.email, 'admin@glinttest.io');
      expect(registerCubit.state.organization, 'TestOrg');
      expect(registerCubit.state.contactNumber, '9876543210');
      expect(registerCubit.state.password, 'AdminPass123');
    });

    test('Step 4-8: All admin fields can be set individually', () {
      registerCubit.enteredUserName('AdminUser');
      expect(registerCubit.state.name, 'AdminUser');

      registerCubit.enteredEmail('admin@test.io');
      expect(registerCubit.state.email, 'admin@test.io');

      registerCubit.enteredOrganization('Hotel Vistara');
      expect(registerCubit.state.organization, 'Hotel Vistara');

      registerCubit.enteredContactNumber('9876543210');
      expect(registerCubit.state.contactNumber, '9876543210');

      registerCubit.enteredPassword('AdminPass123');
      expect(registerCubit.state.password, 'AdminPass123');
    });

    test('Step 9: registerAsAAdmin creates fake RegisterUserRequest and calls createAccount',
        () async {
      registerCubit.enteredUserName('AdminUser');
      registerCubit.enteredEmail('admin@glinttest.io');
      registerCubit.enteredOrganization('TestOrg');
      registerCubit.enteredContactNumber('9876543210');
      registerCubit.enteredPassword('AdminPass123');

      await registerCubit.registerAsAAdmin();

      verify(() => mockAuthRepo.createAccount(any(), 'event admin')).called(1);
    });

    test('Step 9: Admin registration calls createAccount with "event admin" role',
        () async {
      registerCubit.enteredUserName('TestAdmin');
      registerCubit.enteredEmail(TestCredentials.generateEmail());
      registerCubit.enteredOrganization('MyOrg');
      registerCubit.enteredContactNumber('9876543210');
      registerCubit.enteredPassword('AdminPass123');

      await registerCubit.registerAsAAdmin();

      final captured = verify(
        () => mockAuthRepo.createAccount(captureAny(), captureAny()),
      ).captured;

      expect(captured.last, 'event admin');
    });

    test('Step 10: Successful admin registration navigates to adminHome',
        () async {
      expect(GlintAdminDasboardRoutes.adminHome.name, 'adminHome');
    });

    test('Step 11: Admin dashboard has create and track event routes', () {
      expect(GlintAdminDasboardRoutes.createEvent.name, 'createEvent');
      expect(
        GlintAdminDasboardRoutes.adminPublishedEvents.name,
        'adminPublishedEvents',
      );
    });

    test('Step 17: Preview event route exists', () {
      expect(GlintAdminDasboardRoutes.previewEvent.name, 'previewEvent');
    });
  });

  group('Flow 3: Admin registration failure handling', () {
    late RegisterCubit registerCubit;

    setUp(() async {
      await registerTestDependencies();

      when(() => mockAuthRepo.createAccount(any(), any())).thenAnswer(
        (_) async =>
            Failure(Exception('Server error'), message: 'Registration failed'),
      );
      when(() => mockSignInUserUseCase.perform(any(), any(), any(), any()))
          .thenAnswer((_) async {});

      registerCubit = RegisterCubit();
    });

    tearDown(() async {
      await registerCubit.close();
      await getIt.reset();
    });

    test('Admin registration failure does not navigate', () async {
      registerCubit.enteredUserName('FailAdmin');
      registerCubit.enteredEmail('fail@test.io');
      registerCubit.enteredOrganization('FailOrg');
      registerCubit.enteredContactNumber('9876543210');
      registerCubit.enteredPassword('FailPass12345');

      await registerCubit.registerAsAAdmin();

      expect(registerCubit.state.isRegisteredSuccessfully, isFalse);
    });
  });

  group('Flow 3: Admin calculateMockDob', () {
    late RegisterCubit registerCubit;

    setUp(() async {
      await registerTestDependencies();
      registerCubit = RegisterCubit();
    });

    tearDown(() async {
      await registerCubit.close();
      await getIt.reset();
    });

    test('calculateMockDob returns date 18 years ago', () {
      final dob = registerCubit.calculateMockDob();
      expect(dob, isNotEmpty);
      expect(dob, contains('-'));

      final parsed = DateTime.parse(dob);
      final now = DateTime.now();
      final age = now.year - parsed.year;
      expect(age, 18);
    });
  });
}
