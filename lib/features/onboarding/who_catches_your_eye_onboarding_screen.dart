import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:glint_frontend/design/components/glint_custom_app_bar.dart';
import 'package:glint_frontend/design/exports.dart';
import 'package:glint_frontend/features/onboarding/on_boarding_cubit.dart';
import 'package:glint_frontend/navigation/glint_all_routes.dart';
import 'package:go_router/go_router.dart';

class WhoCatchesYourEyeOnboardingScreen extends StatefulWidget {
  const WhoCatchesYourEyeOnboardingScreen({super.key});

  @override
  State<WhoCatchesYourEyeOnboardingScreen> createState() =>
      _OnboardingScreenState();
}

class _OnboardingScreenState extends State<WhoCatchesYourEyeOnboardingScreen> {
  String? selectedGender;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnBoardingCubit, OnBoardingState>(
      builder: (context, state) {
        return Scaffold(
          body: OnboardingSafeAreaContainer(
            assetPath:
                'lib/assets/images/onboarding/hand_holding_eye_illustration.png',
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Spacer(flex: 1),
                Column(
                  children: [
                    Text(
                      'Who Catches',
                      style: AppTheme.headingOne.copyWith(
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal,
                      ),
                    ),
                    const Text(
                      'Your eye?',
                      style: AppTheme.headingOne,
                    ),
                    const Gap(64.0),
                    GlintCustomIconChip(
                      label: 'Woman',
                      assetPath: 'lib/assets/icons/female.svg',
                      isSelected: selectedGender == 'Woman',
                      onTap: () {
                        setState(() => selectedGender = 'Woman');
                        if (selectedGender != null) {
                          context
                              .read<OnBoardingCubit>()
                              .setGenderPreferences("Female");
                        }
                      },
                    ),
                    const Gap(16.0),
                    GlintCustomIconChip(
                      label: 'Man',
                      assetPath: 'lib/assets/icons/male.svg',
                      isSelected: selectedGender == 'Man',
                      onTap: () {
                        setState(() => selectedGender = 'Man');
                        if (selectedGender != null) {
                          context
                              .read<OnBoardingCubit>()
                              .setGenderPreferences("Male");
                        }
                      },
                    ),
                    const Gap(16.0),
                    GlintCustomIconChip(
                      label: 'Everyone',
                      assetPath: 'lib/assets/icons/everyone.svg',
                      isSelected: selectedGender == 'Everyone',
                      onTap: () {
                        setState(() => selectedGender = 'Everyone');
                        if (selectedGender != null) {
                          context
                              .read<OnBoardingCubit>()
                              .setGenderPreferences("Everyone");
                        }
                      },
                    ),
                  ],
                ),
                const Spacer(flex: 3),
                SizedBox(
                  width: double.infinity,
                  child: GlintElevatedButton(
                    label: 'Next',
                    foregroundColor: Colors.white,
                    backgroundColor: AppColours.primaryBlue,
                    onPressed: selectedGender != null
                        ? () {
                            final selectedGenderPreferences =
                                state.currentState?.genderPreference;
                            if (selectedGenderPreferences != null) {
                              final base = GlintMainRoutes.onBoarding.name;
                              final target = GlintBoardingRoutes.media.name;
                              context.go("/$base/$target");
                            }
                          }
                        : null,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
