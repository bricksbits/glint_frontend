import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glint_frontend/features/auth/create_account_screen.dart';
import 'package:glint_frontend/features/onboarding/on_boarding_cubit.dart';
import 'package:glint_frontend/features/onboarding/setup_glint_onboarding_screen.dart';
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
    path: '/${GlintBoardingRoutes.boarding.name}',
    name: GlintBoardingRoutes.boarding.name,
    pageBuilder: (context, state) {
      var onBoardingCubit = context.read<OnBoardingCubit>();
      return MaterialPage(
        child: BlocProvider.value(
          value: onBoardingCubit,
          child: const SetupGlintOnboardingScreen(),
        ),
      );
    },
  ),
  GoRoute(
    path: '/${GlintBoardingRoutes.name.name}',
    name: GlintBoardingRoutes.name.name,
    pageBuilder: (context, state) {
      var onBoardingCubit = context.read<OnBoardingCubit>();
      return MaterialPage(
        child: BlocProvider.value(
          value: onBoardingCubit,
          child: const EnterNameOnboardingScreen(),
        ),
      );
    },
  ),
  GoRoute(
    path: '/${GlintBoardingRoutes.dob.name}',
    name: GlintBoardingRoutes.dob.name,
    pageBuilder: (context, state) {
      var onBoardingCubit = BlocProvider.of<OnBoardingCubit>(context);
      return MaterialPage(
        child: BlocProvider.value(
          value: onBoardingCubit,
          child: const DateOfBirthOnboardingScreen(),
        ),
      );
    },
  ),
  GoRoute(
    path: '/${GlintBoardingRoutes.pronouns.name}',
    name: GlintBoardingRoutes.pronouns.name,
    pageBuilder: (context, state) {
      var onBoardingCubit = BlocProvider.of<OnBoardingCubit>(context);
      return MaterialPage(
        child: BlocProvider.value(
          value: onBoardingCubit,
          child: const GetSetGlintOnboardingScreen(),
        ),
      );
    },
  ),
  GoRoute(
    path: '/${GlintBoardingRoutes.media.name}',
    name: GlintBoardingRoutes.media.name,
    pageBuilder: (context, state) {
      var onBoardingCubit = BlocProvider.of<OnBoardingCubit>(context);
      return MaterialPage(
        child: BlocProvider.value(
          value: onBoardingCubit,
          child: const UploadPhotosOnboardingScreen(),
        ),
      );
    },
  ),
  GoRoute(
    path: '/${GlintBoardingRoutes.gender.name}',
    name: GlintBoardingRoutes.gender.name,
    pageBuilder: (context, state) {
      var onBoardingCubit = BlocProvider.of<OnBoardingCubit>(context);
      return MaterialPage(
        child: BlocProvider.value(
          value: onBoardingCubit,
          child: const IdentifyYourselfOnboardingScreen(),
        ),
      );
    },
  ),
  GoRoute(
    path: '/${GlintBoardingRoutes.interestedGender.name}',
    name: GlintBoardingRoutes.interestedGender.name,
    pageBuilder: (context, state) {
      var onBoardingCubit = BlocProvider.of<OnBoardingCubit>(context);
      return MaterialPage(
        child: BlocProvider.value(
          value: onBoardingCubit,
          child: const WhoCatchesYourEyeOnboardingScreen(),
        ),
      );
    },
  ),
  GoRoute(
    path: '/${GlintBoardingRoutes.interests.name}',
    name: GlintBoardingRoutes.interests.name,
    pageBuilder: (context, state) {
      var onBoardingCubit = BlocProvider.of<OnBoardingCubit>(context);
      return MaterialPage(
        child: BlocProvider.value(
          value: onBoardingCubit,
          child: const InterestsAndVibeOnboardingScreen(),
        ),
      );
    },
  ),
  GoRoute(
    path: '/${GlintBoardingRoutes.bio.name}',
    name: GlintBoardingRoutes.bio.name,
    pageBuilder: (context, state) {
      var onBoardingCubit = BlocProvider.of<OnBoardingCubit>(context);
      return MaterialPage(
        child: BlocProvider.value(
          value: onBoardingCubit,
          child: const OneLastStepOnboardingScreen(),
        ),
      );
    },
  ),
  GoRoute(
    path: '/${GlintBoardingRoutes.register.name}',
    name: GlintBoardingRoutes.register.name,
    pageBuilder: (context, state) {
      var onBoardingCubit = BlocProvider.of<OnBoardingCubit>(context);
      return MaterialPage(
        child: BlocProvider.value(
          value: onBoardingCubit,
          child: const CreateAccounScreen(),
        ),
      );
    },
  )
];
