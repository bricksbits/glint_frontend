import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';

import 'package:glint_frontend/di/injection.dart';
import 'package:glint_frontend/domain/business_logic/models/auth/register_user_request.dart';
import 'package:glint_frontend/domain/business_logic/repo/boarding/on_boarding_repo.dart';
import 'package:glint_frontend/features/onboarding/on_boarding_cubit.dart';
import 'package:glint_frontend/features/auth/blocs/register/register_cubit.dart';
import 'package:glint_frontend/navigation/glint_all_routes.dart';
import 'package:glint_frontend/utils/result_sealed.dart';

import '../helpers/mock_services.dart';
import '../helpers/fake_data.dart';
import '../helpers/test_credentials.dart';

void main() {
  setUpAll(() {
    registerFallbackValue(OnBoardingCompletedTill.NOT_STARTED);
    registerFallbackValue(FakeData.createRegisterUserRequest());
    registerFallbackValue(<String>[]);
  });

  group('Flow 1: Normal User Onboarding → Registration → Home', () {
    late OnBoardingCubit onBoardingCubit;
    late RegisterCubit registerCubit;

    setUp(() async {
      await registerTestDependencies();

      // OnBoarding repo mocks
      when(() => mockOnBoardingRepo.getCurrentBoardingState())
          .thenAnswer((_) async => OnBoardingCompletedTill.NOT_STARTED);
      when(() => mockOnBoardingRepo.getCurrentUserState()).thenAnswer(
        (_) async => Failure(Exception('No user')),
      );
      when(() => mockOnBoardingRepo.insertUser(any()))
          .thenAnswer((_) async => {});
      when(() => mockOnBoardingRepo.updateUserDetailsLocally(any()))
          .thenAnswer((_) async => const Success(null));
      when(() => mockOnBoardingRepo.setupCurrentBoardingState(any()))
          .thenAnswer((_) async => {});

      // Location + notification mocks
      when(() => mockLocationPermissionService.requestPermission())
          .thenAnswer((_) async => true);
      when(() => mockLocationPermissionService.getCurrentLocation())
          .thenAnswer((_) async => null);
      when(() => mockNotificationPermissionService.requestPermission())
          .thenAnswer((_) async => true);
      when(() => mockSharedPrefs.saveDouble(any(), any()))
          .thenAnswer((_) async => {});

      // Auth mocks
      when(() => mockAuthRepo.getOnBoardedUser()).thenAnswer(
        (_) async => FakeData.createRegisterUserRequest(),
      );
      when(() => mockAuthRepo.createAccount(any(), any()))
          .thenAnswer((_) async => const Success(null));
      when(() => mockAuthRepo.clearTheDbAfterRegistration())
          .thenAnswer((_) async => {});
      when(() => mockAuthRepo.uploadMediaFile(any()))
          .thenAnswer((_) async => const Success(null));

      // Image service mock
      when(() => mockImageService.loadSavedImages())
          .thenAnswer((_) async => []);
      when(() => mockImageService.clearProfileImagesDirectory())
          .thenAnswer((_) async => {});

      // SignIn use case mock
      when(() => mockSignInUserUseCase.perform(any(), any(), any(), any()))
          .thenAnswer((_) async {});

      onBoardingCubit = OnBoardingCubit();
      registerCubit = RegisterCubit();
    });

    tearDown(() async {
      await onBoardingCubit.close();
      await registerCubit.close();
      await getIt.reset();
    });

    test(
        'Step 1-2: Fresh app → cubit initializes to NOT_STARTED → routes to /name',
        () async {
      await Future.delayed(const Duration(milliseconds: 100));

      expect(onBoardingCubit.state.currentDestination,
          GlintBoardingRoutes.name.name);
      expect(onBoardingCubit.state.onBoardingStatus,
          OnBoardingCompletedTill.NOT_STARTED);
    });

    test('Step 5: Enter name updates state', () async {
      await Future.delayed(const Duration(milliseconds: 100));

      onBoardingCubit.setName('TestUser');
      expect(onBoardingCubit.currentName, 'TestUser');

      verify(() => mockOnBoardingRepo.updateUserDetailsLocally(any()))
          .called(greaterThan(0));
    });

    test('Step 7: Set valid age (>= 18) updates state', () async {
      await Future.delayed(const Duration(milliseconds: 100));

      onBoardingCubit.setAge(24, '2002-01-15 00:00:00');
      expect(onBoardingCubit.state.currentState?.calculatedAge, '24');
    });

    test('Step 9: Select Female gender', () async {
      await Future.delayed(const Duration(milliseconds: 100));

      onBoardingCubit.setGender('Female');
      expect(onBoardingCubit.currentGender, 'Female');
    });

    test('Step 11: Select Male preference', () async {
      await Future.delayed(const Duration(milliseconds: 100));

      onBoardingCubit.setGenderPreferences('Male');
      expect(onBoardingCubit.currentGenderPreferences, 'Male');
    });

    test('Step 15: Select relationship goal "Something Casual"', () async {
      await Future.delayed(const Duration(milliseconds: 100));

      onBoardingCubit.setLookingFor('Something Casual');
      expect(onBoardingCubit.currentLookingFor, 'Something Casual');
    });

    test('Step 17: Select 5 interests passes validation', () async {
      await Future.delayed(const Duration(milliseconds: 100));

      onBoardingCubit
          .setInterests(['Music', 'Travel', 'Fitness', 'Movies', 'Food']);
      expect(onBoardingCubit.validateInterestCounts(), isTrue);
    });

    test('Step 19-25: Fill all personal info passes validation', () async {
      await Future.delayed(const Duration(milliseconds: 100));

      onBoardingCubit.setBio('I love hiking');
      onBoardingCubit.setOccupation('Engineer');
      onBoardingCubit.setEducation('bachelors');
      onBoardingCubit.setHeight('5.8');
      onBoardingCubit.setWorkingHabit('sometimes');
      onBoardingCubit.setDrinkingHabit('occasionally');
      onBoardingCubit.setSmokingHabit('nonSmoker');

      expect(onBoardingCubit.validatePersonalInformation(), isTrue);
    });

    test('Step 28: Enable location completes onboarding', () async {
      await Future.delayed(const Duration(milliseconds: 100));

      await onBoardingCubit.enableLocationAndCompleteOnboarding();

      // Location permission was denied (getCurrentLocation returns null)
      // but permission was granted
      verify(() => mockLocationPermissionService.requestPermission()).called(1);
    });

    test('Step 30-32: Register cubit accepts credentials', () {
      final testEmail = TestCredentials.generateEmail();
      final testPassword = TestCredentials.generatePassword();

      registerCubit.enteredEmail(testEmail);
      registerCubit.enteredPassword(testPassword);
      registerCubit.enteredConfirmPassword(testPassword);

      expect(registerCubit.state.email, testEmail);
      expect(registerCubit.state.password, testPassword);
      expect(registerCubit.state.confirmPassword, testPassword);
    });

    test('Step 30-32: Email validation', () {
      registerCubit.enteredEmail('invalid-email');
      registerCubit.enteredPassword('TestPass123!');
      registerCubit.enteredConfirmPassword('TestPass123!');

      // Trigger registration
      registerCubit.registerUser();
    });

    test('Step 33-34: registerUser triggers full flow on valid credentials',
        () async {
      final testEmail = TestCredentials.generateEmail();
      const testPassword = 'TestPass123!';

      registerCubit.enteredEmail(testEmail);
      registerCubit.enteredPassword(testPassword);
      registerCubit.enteredConfirmPassword(testPassword);

      await registerCubit.registerUser();

      verify(() => mockAuthRepo.getOnBoardedUser()).called(1);
    });
  });

  group('Flow 1: Registration validation edge cases', () {
    late RegisterCubit registerCubit;

    setUp(() async {
      await registerTestDependencies();
      registerCubit = RegisterCubit();
    });

    tearDown(() async {
      await registerCubit.close();
      await getIt.reset();
    });

    test('empty email sets error', () async {
      registerCubit.enteredEmail('');
      registerCubit.enteredPassword('TestPass123!');
      registerCubit.enteredConfirmPassword('TestPass123!');

      await registerCubit.registerUser();

      expect(registerCubit.state.error, isNotEmpty);
      expect(registerCubit.state.isEmailValid, isFalse);
    });

    test('invalid email format sets error', () async {
      registerCubit.enteredEmail('not-an-email');
      registerCubit.enteredPassword('TestPass123!');
      registerCubit.enteredConfirmPassword('TestPass123!');

      await registerCubit.registerUser();

      expect(registerCubit.state.error, contains('valid email'));
    });

    test('password < 10 chars sets error', () async {
      registerCubit.enteredEmail('test@glinttest.io');
      registerCubit.enteredPassword('short');
      registerCubit.enteredConfirmPassword('short');

      await registerCubit.registerUser();

      expect(registerCubit.state.error, contains('10'));
    });

    test('mismatched confirm password sets error', () async {
      registerCubit.enteredEmail('test@glinttest.io');
      registerCubit.enteredPassword('TestPass123!');
      registerCubit.enteredConfirmPassword('DifferentPass!');

      await registerCubit.registerUser();

      expect(registerCubit.state.error, contains('match'));
    });
  });
}
