import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:glint_frontend/design/components/glint_custom_app_bar.dart';
import 'package:glint_frontend/design/exports.dart';
import 'package:glint_frontend/domain/business_logic/repo/boarding/on_boarding_repo.dart';
import 'package:glint_frontend/features/onboarding/on_boarding_cubit.dart';
import 'package:glint_frontend/navigation/glint_all_routes.dart';
import 'package:go_router/go_router.dart';

class SetupGlintOnboardingScreen extends StatelessWidget {
  const SetupGlintOnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OnBoardingCubit(),
      child: BlocBuilder<OnBoardingCubit, OnBoardingState>(
        builder: (context, state) {
          return Scaffold(
            body: OnboardingSafeAreaContainer(
              assetPath:
                  'lib/assets/images/onboarding/male_female_phone_illustration.png',
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Spacer(
                    flex: 8,
                  ),
                  RichText(
                    text: TextSpan(
                      text: 'Setup your ',
                      style: AppTheme.headingOne.copyWith(
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal,
                      ),
                      children: [
                        TextSpan(
                          text: 'Glint',
                          style: AppTheme.headingOne.copyWith(
                            fontWeight: FontWeight.w900,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Gap(12.0),
                  Text(
                    'Single life’s cool, but maybe\nit’s time to mix things up.',
                    style: AppTheme.simpleBodyText.copyWith(
                      fontWeight: FontWeight.w300,
                      fontSize: 18.0,
                    ),
                  ),
                  const Spacer(),
                  SizedBox(
                    width: double.infinity,
                    child: GlintElevatedButton(
                      label: 'Next',
                      foregroundColor: Colors.white,
                      backgroundColor: AppColours.primaryBlue,
                      onPressed: () {
                        final isNewUserCreated = state.currentState;
                        if (isNewUserCreated?.userId == NEW_ON_BOARD_USER_ID) {
                          final base = GlintMainRoutes.onBoarding.name;
                          final target = GlintBoardingRoutes.name.name;
                          context.go("/$base/$target");
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
