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
    context
        .read<OnBoardingCubit>()
        .setUpLastBoardingState(OnBoardingCompletedTill.INTERESTS_DONE);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnBoardingCubit, OnBoardingState>(
      builder: (context, state) {
        return Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: AppColours.white,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0).copyWith(
                bottom: 16.0,
              ),
              child: SingleChildScrollView(
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
                      bio: "",
                    ),

                    // Additional info
                    const Gap(24.0),

                    AdditionalInfoContainer(
                      occupation: state.currentState?.occupation,
                      education: state.currentState?.education,
                      height: state.currentState?.height,
                      workoutHabits: state.currentState?.workoutHabit,
                      drinkingHabits: state.currentState?.drinkingHabit,
                      smokingHabits: state.currentState?.smokingHabit,
                      occupationProvided: (occupation) {
                        context
                            .read<OnBoardingCubit>()
                            .setOccupation(occupation);
                      },
                      educationSelected: (education) {
                        context.read<OnBoardingCubit>().setEducation(education);
                      },
                      heightProvided: (height) {
                        context
                            .read<OnBoardingCubit>()
                            .setHeight(height.toString());
                      },
                      workoutHabitSelected: (workoutHabit) {
                        context
                            .read<OnBoardingCubit>()
                            .setWorkingHabit(workoutHabit);
                      },
                      drinkingHabitSelected: (drinkingHabit) {
                        context
                            .read<OnBoardingCubit>()
                            .setDrinkingHabit(drinkingHabit);
                      },
                      smokingHabitSelected: (smokingHabit) {
                        context
                            .read<OnBoardingCubit>()
                            .setSmokingHabit(smokingHabit);
                      },
                    ),

                    const SizedBox(
                      height: 180,
                    ),

                    SizedBox(
                      width: double.infinity,
                      child: GlintElevatedButton(
                        label: 'Next',
                        foregroundColor: Colors.white,
                        backgroundColor: AppColours.primaryBlue,
                        onPressed: () {
                          final bioValue = state.currentState?.bio;
                          if (bioValue != null && bioValue.isNotEmpty) {
                            context
                                .read<OnBoardingCubit>()
                                .updateProfileLocally();
                            final target = GlintMainRoutes.register.name;
                            context.go("/$target", extra: false);
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
          ),
        );
      },
    );
  }
}
