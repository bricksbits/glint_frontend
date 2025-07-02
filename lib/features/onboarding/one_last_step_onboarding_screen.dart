import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:glint_frontend/design/exports.dart';
import 'package:glint_frontend/navigation/glint_all_routes.dart';
import 'package:go_router/go_router.dart';

import 'on_boarding_cubit.dart';

class OneLastStepOnboardingScreen extends StatefulWidget {
  const OneLastStepOnboardingScreen({super.key});

  @override
  State<OneLastStepOnboardingScreen> createState() =>
      _OneLastStepOnboardingScreenState();
}

class _OneLastStepOnboardingScreenState
    extends State<OneLastStepOnboardingScreen> {

  @override
  void initState() {
    context.read<OnBoardingCubit>()
        .setUpLastBoardingState(OnBoardingCompletedTill.INTERESTS_DONE);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnBoardingCubit, OnBoardingState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColours.white,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0).copyWith(
                bottom: 16.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text: 'One Last ',
                        style: AppTheme.headingOne.copyWith(
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
                        ),
                        children: [
                          TextSpan(
                            text: 'Step',
                            style: AppTheme.headingOne.copyWith(
                              fontWeight: FontWeight.w700,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Gap(44.0),

                  // Bio field label
                  EnterYourBio(
                    onBioCompleted: (bioValue) {
                      context.read<OnBoardingCubit>().setBio(bioValue);
                    },
                  ),

                  // Additional info
                  const Gap(24.0),
                  const AdditionalInfoContainer(),

                  // Spacer
                  const Spacer(),

                  // Submit button
                  SizedBox(
                    width: double.infinity,
                    child: GlintElevatedButton(
                      label: 'Next',
                      foregroundColor: Colors.white,
                      backgroundColor: AppColours.primaryBlue,
                      onPressed: () {
                        final bioValue = state.currentState?.bio;
                        if (bioValue != null && bioValue.isNotEmpty) {
                          // Handle button press
                          final base = GlintMainRoutes.onBoarding.name;
                          final target = GlintBoardingRoutes.register.name;
                          context.go("/$base/$target");
                        } else {
                          //Todo: Show Error
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
