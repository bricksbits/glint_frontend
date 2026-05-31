import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:glint_frontend/di/injection.dart';
import 'package:glint_frontend/domain/business_logic/models/auth/register_user_request.dart';
import 'package:glint_frontend/domain/business_logic/repo/boarding/on_boarding_repo.dart';
import 'package:glint_frontend/features/auth/blocs/register/register_cubit.dart';
import 'package:glint_frontend/features/onboarding/on_boarding_cubit.dart';
import 'package:glint_frontend/utils/result_sealed.dart';
import 'package:glint_frontend/navigation/glint_all_routes.dart';

import '../helpers/mock_services.dart';
import '../helpers/fake_data.dart';

void main() {
  late OnBoardingCubit cubit;

  setUpAll(() {
    registerFallbackValue(OnBoardingCompletedTill.NOT_STARTED);
    registerFallbackValue(FakeData.createRegisterUserRequest());
  });

  setUp(() async {
    await registerTestDependencies();

    when(() => mockOnBoardingRepo.getCurrentBoardingState())
        .thenAnswer((_) async => OnBoardingCompletedTill.NOT_STARTED);
    when(() => mockOnBoardingRepo.getCurrentUserState()).thenAnswer(
      (_) async => Failure(Exception('No user'), message: 'Not found'),
    );
    when(() => mockOnBoardingRepo.insertUser(any()))
        .thenAnswer((_) async => {});
    when(() => mockOnBoardingRepo.updateUserDetailsLocally(any()))
        .thenAnswer((_) async => const Success(null));
    when(() => mockOnBoardingRepo.setupCurrentBoardingState(any()))
        .thenAnswer((_) async => {});
    when(() => mockLocationPermissionService.requestPermission())
        .thenAnswer((_) async => true);
    when(() => mockLocationPermissionService.getCurrentLocation())
        .thenAnswer((_) async => null);
    when(() => mockSharedPrefs.saveDouble(any(), any()))
        .thenAnswer((_) async => {});

    cubit = OnBoardingCubit();
  });

  tearDown(() async {
    await cubit.close();
    await getIt.reset();
  });

  group('Onboarding Variations: User gender + preference + relationship goal',
      () {
    final genderOptions = [
      ('Female', 'Female'),
      ('Male', 'Male'),
    ];

    final preferenceOptions = [
      ('Woman', 'Female'),
      ('Man', 'Male'),
    ];

    final relationshipGoals = [
      'Long Term',
      'Something Casual',
      'New Friends',
      'Not Sure',
    ];

    for (final gender in genderOptions) {
      for (final preference in preferenceOptions) {
        for (final goal in relationshipGoals) {
          final comboId =
              '${gender.$1[0]}-${preference.$1[0]}-${goal.split(' ').first}-U';

          test('Combo $comboId: ${gender.$1}/${preference.$1}/$goal', () async {
            // Wait for cubit initialization
            await Future.delayed(Duration.zero);

            // Step 1: Set name
            cubit.setName('TestUser');
            expect(cubit.currentName, 'TestUser');

            // Step 2: Set age (must be >= 18)
            cubit.setAge(24, '2000-01-01 00:00:00');
            expect(cubit.currentAge, '2000-01-01 00:00:00');

            // Step 3: Set gender
            cubit.setGender(gender.$2);
            expect(cubit.currentGender, gender.$2);

            // Step 4: Set gender preference
            cubit.setGenderPreferences(preference.$2);
            expect(cubit.currentGenderPreferences, preference.$2);

            // Step 5: Set relationship goals
            cubit.setLookingFor(goal);
            expect(cubit.currentLookingFor, goal);

            // Step 6: Set required personal info
            cubit.setBio('I love hiking');
            expect(cubit.currentBio, 'I love hiking');

            cubit.setOccupation('Engineer');
            expect(cubit.currentOccupation, 'Engineer');

            cubit.setEducation('bachelors');
            expect(cubit.currentEducation, 'bachelors');

            cubit.setHeight('5.8');
            expect(cubit.currentHeight, '5.8');

            cubit.setWorkingHabit('sometimes');
            expect(cubit.currentWorkingHabit, 'sometimes');

            cubit.setDrinkingHabit('occasionally');
            expect(cubit.currentDrinkingHabit, 'occasionally');

            cubit.setSmokingHabit('nonSmoker');
            expect(cubit.currentSmokingHabit, 'nonSmoker');

            // Step 7: Set interests (minimum 5)
            cubit.setInterests(
                ['Music', 'Travel', 'Fitness', 'Movies', 'Food']);
            expect(cubit.currentInterests?.length, 5);

            // Step 8: Validate personal information
            expect(cubit.validatePersonalInformation(), isTrue);
            expect(cubit.validateInterestCounts(), isTrue);
            expect(cubit.validateIfRelationGoalsProvidedOrNot(), isTrue);

            // Verify the final state has correct values
            final currentState = cubit.state;
            expect(currentState.currentState?.gender, gender.$2);
            expect(currentState.currentState?.genderPreference, preference.$2);
            expect(currentState.currentState?.relationShipGoals, goal);
          });
        }
      }
    }
  });

  group('Onboarding Variations: Admin registration (D combo)', () {
    late RegisterCubit registerCubit;

    setUp(() async {
      when(() => mockAuthRepo.createAccount(any(), any()))
          .thenAnswer((_) async => const Success(null));
      when(() => mockSignInUserUseCase.perform(any(), any(), any(), any()))
          .thenAnswer((_) async {});

      registerCubit = RegisterCubit();
    });

    tearDown(() async {
      await registerCubit.close();
    });

    test('Admin combo: name + email + org + contact + password', () {
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
  });

  group('Onboarding: Validation edge cases', () {
    test('age < 18 should emit error', () async {
      await Future.delayed(Duration.zero);
      cubit.setAge(16, '2008-01-01 00:00:00');
      expect(cubit.state.error, contains('young'));
    });

    test('empty bio fails validatePersonalInformation', () async {
      await Future.delayed(Duration.zero);
      expect(cubit.validatePersonalInformation(), isFalse);
    });

    test('< 5 interests fails validateInterestCounts', () async {
      await Future.delayed(Duration.zero);
      cubit.setInterests(['Music', 'Travel']);
      expect(cubit.validateInterestCounts(), isFalse);
    });

    test('null relationship goals fails validation', () async {
      await Future.delayed(Duration.zero);
      expect(cubit.validateIfRelationGoalsProvidedOrNot(), isFalse);
    });

    test('no images fails validateIfImageProvidedOrNot', () async {
      await Future.delayed(Duration.zero);
      expect(cubit.validateIfImageProvidedOrNot(), isFalse);
    });
  });
}
