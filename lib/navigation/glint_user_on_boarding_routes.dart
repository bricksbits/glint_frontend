import 'package:glint_frontend/features/auth/create_account_screen.dart';
import 'package:go_router/go_router.dart';

import 'package:glint_frontend/features/onboarding/date_of_birth_onboarding_screen.dart';
import 'package:glint_frontend/features/onboarding/enter_name_onboarding_screen.dart';
import 'package:glint_frontend/features/onboarding/get_set_glint_onboarding_screen.dart';
import 'package:glint_frontend/features/onboarding/identify_yourself_onboarding_screen.dart';
import 'package:glint_frontend/features/onboarding/interests_and_vibe_onboarding_screen.dart';
import 'package:glint_frontend/features/onboarding/one_last_step_onboarding_screen.dart';
import 'package:glint_frontend/features/onboarding/upload_photos_onboarding_screen.dart';
import 'package:glint_frontend/features/onboarding/who_catches_your_eye_onboarding_screen.dart';
import 'glint_all_routes.dart';

final glintUserOnBoardingInnerRoutes = [
  GoRoute(
    path: '/${GlintBoardingRoutes.name.name}',
    name: GlintBoardingRoutes.name.name,
    builder: (context, state) => const EnterNameOnboardingScreen(),
  ),
  GoRoute(
    path: '/${GlintBoardingRoutes.dob.name}',
    name: GlintBoardingRoutes.dob.name,
    builder: (context, state) => const DateOfBirthOnboardingScreen(),
  ),
  GoRoute(
    path: '/${GlintBoardingRoutes.pronouns.name}',
    name: GlintBoardingRoutes.pronouns.name,
    builder: (context, state) => const GetSetGlintOnboardingScreen(),
  ),
  GoRoute(
    path: '/${GlintBoardingRoutes.media.name}',
    name: GlintBoardingRoutes.media.name,
    builder: (context, state) => const UploadPhotosOnboardingScreen(),
  ),
  GoRoute(
    path: '/${GlintBoardingRoutes.gender.name}',
    name: GlintBoardingRoutes.gender.name,
    builder: (context, state) =>
    const IdentifyYourselfOnboardingScreen(),
  ),
  GoRoute(
    path: '/${GlintBoardingRoutes.interestedGender.name}',
    name: GlintBoardingRoutes.interestedGender.name,
    builder: (context, state) =>
    const WhoCatchesYourEyeOnboardingScreen(),
  ),
  GoRoute(
    path: '/${GlintBoardingRoutes.interests.name}',
    name: GlintBoardingRoutes.interests.name,
    builder: (context, state) =>
    const InterestsAndVibeOnboardingScreen(),
  ),
  GoRoute(
    path: '/${GlintBoardingRoutes.bio.name}',
    name: GlintBoardingRoutes.bio.name,
    builder: (context, state) => const OneLastStepOnboardingScreen(),
  ),
  GoRoute(
    path: '/${GlintBoardingRoutes.register.name}',
    name: GlintBoardingRoutes.register.name,
    builder: (context, state) => const CreateAccounScreen(),
  )
];