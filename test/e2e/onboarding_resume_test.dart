import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:glint_frontend/di/injection.dart';
import 'package:glint_frontend/domain/business_logic/models/auth/register_user_request.dart';
import 'package:glint_frontend/domain/business_logic/repo/boarding/on_boarding_repo.dart';
import 'package:glint_frontend/features/onboarding/on_boarding_cubit.dart';
import 'package:glint_frontend/navigation/glint_all_routes.dart';
import 'package:glint_frontend/utils/result_sealed.dart';

import '../helpers/mock_services.dart';
import '../helpers/fake_data.dart';

void main() {
  late OnBoardingCubit cubit;

  setUpAll(() {
    registerFallbackValue(OnBoardingCompletedTill.NOT_STARTED);
    registerFallbackValue(FakeData.createRegisterUserRequest());
  });

  tearDown(() async {
    await cubit.close();
    await getIt.reset();
  });

  final resumeTestCases = <(OnBoardingCompletedTill, String, String)>[
    (
      OnBoardingCompletedTill.NOT_STARTED,
      GlintBoardingRoutes.name.name,
      'NOT_STARTED → /name',
    ),
    (
      OnBoardingCompletedTill.NAME_PROVIDED,
      GlintBoardingRoutes.dob.name,
      'NAME_PROVIDED → /dob',
    ),
    (
      OnBoardingCompletedTill.AGE_CALCULATED,
      GlintBoardingRoutes.gender.name,
      'AGE_CALCULATED → /gender',
    ),
    (
      OnBoardingCompletedTill.GENDER_SELECTED,
      GlintBoardingRoutes.interestedGender.name,
      'GENDER_SELECTED → /interestedGender',
    ),
    (
      OnBoardingCompletedTill.CHOICE_OF_GENDER_SELECTED,
      GlintBoardingRoutes.media.name,
      'CHOICE_OF_GENDER_SELECTED → /media',
    ),
    (
      OnBoardingCompletedTill.IMAGES_SELECTED,
      GlintBoardingRoutes.pronouns.name,
      'IMAGES_SELECTED → /pronouns',
    ),
    (
      OnBoardingCompletedTill.PRONOUNS_DONE,
      GlintBoardingRoutes.interests.name,
      'PRONOUNS_DONE → /interests',
    ),
    (
      OnBoardingCompletedTill.INTERESTS_DONE,
      GlintBoardingRoutes.bio.name,
      'INTERESTS_DONE → /bio',
    ),
    (
      OnBoardingCompletedTill.BIO_DONE,
      GlintBoardingRoutes.location.name,
      'BIO_DONE → /location',
    ),
    (
      OnBoardingCompletedTill.COMPLETED,
      GlintMainRoutes.register.name,
      'COMPLETED → /register',
    ),
  ];

  group('Onboarding Resume: each saved state maps to correct screen', () {
    for (final testCase in resumeTestCases) {
      final savedState = testCase.$1;
      final expectedRoute = testCase.$2;
      final label = testCase.$3;

      test('Resume from $label', () async {
        await registerTestDependencies();

        when(() => mockOnBoardingRepo.getCurrentBoardingState())
            .thenAnswer((_) async => savedState);
        when(() => mockOnBoardingRepo.getCurrentUserState()).thenAnswer(
          (_) async => Success(FakeData.createRegisterUserRequest()),
        );
        when(() => mockOnBoardingRepo.updateUserDetailsLocally(any()))
            .thenAnswer((_) async => const Success(null));
        when(() => mockOnBoardingRepo.setupCurrentBoardingState(any()))
            .thenAnswer((_) async => {});
        when(() => mockSharedPrefs.saveDouble(any(), any()))
            .thenAnswer((_) async => {});
        when(() => mockLocationPermissionService.requestPermission())
            .thenAnswer((_) async => true);

        cubit = OnBoardingCubit();

        // Allow cubit initialization to complete
        await Future.delayed(const Duration(milliseconds: 100));

        expect(
          cubit.state.currentDestination,
          expectedRoute,
          reason: 'State $savedState should resume at route $expectedRoute',
        );
      });
    }
  });

  group('Onboarding Resume: state progression tracking', () {
    test('getLatestUpdatedState returns current boarding status', () async {
      await registerTestDependencies();

      when(() => mockOnBoardingRepo.getCurrentBoardingState())
          .thenAnswer((_) async => OnBoardingCompletedTill.GENDER_SELECTED);
      when(() => mockOnBoardingRepo.getCurrentUserState()).thenAnswer(
        (_) async => Success(FakeData.createRegisterUserRequest()),
      );
      when(() => mockOnBoardingRepo.updateUserDetailsLocally(any()))
          .thenAnswer((_) async => const Success(null));

      cubit = OnBoardingCubit();
      await Future.delayed(const Duration(milliseconds: 100));

      final status = await cubit.getLatestUpdatedState();
      expect(status, OnBoardingCompletedTill.GENDER_SELECTED);
    });

    test('setUpLastBoardingState persists state to repo', () async {
      await registerTestDependencies();

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

      cubit = OnBoardingCubit();
      await Future.delayed(const Duration(milliseconds: 100));

      await cubit
          .setUpLastBoardingState(OnBoardingCompletedTill.NAME_PROVIDED);

      verify(() => mockOnBoardingRepo
              .setupCurrentBoardingState(OnBoardingCompletedTill.NAME_PROVIDED))
          .called(1);
    });
  });
}
