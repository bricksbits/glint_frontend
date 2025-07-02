import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:glint_frontend/design/components/glint_custom_app_bar.dart';
import 'package:glint_frontend/design/exports.dart';
import 'package:glint_frontend/features/onboarding/on_boarding_cubit.dart';
import 'package:glint_frontend/navigation/glint_all_routes.dart';
import 'package:go_router/go_router.dart';

//Todo: Remove this Screen its not needed.
class IdentifyYourselfOnboardingScreen extends StatefulWidget {
  const IdentifyYourselfOnboardingScreen({super.key});

  @override
  State<IdentifyYourselfOnboardingScreen> createState() =>
      _IdentifyYourselfOnboardingScreenState();
}

class _IdentifyYourselfOnboardingScreenState
    extends State<IdentifyYourselfOnboardingScreen> {
  String? selectedIdentity;

  @override
  void initState() {
    context.read<OnBoardingCubit>()
        .setUpLastBoardingState(OnBoardingCompletedTill.AGE_CALCULATED);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnBoardingCubit, OnBoardingState>(
      builder: (context, state) {
        return Scaffold(
          body: OnboardingSafeAreaContainer(
            assetPath:
                'lib/assets/images/onboarding/identify_yourself_background_illustration.png',
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Spacer(),
                Column(
                  children: [
                    Text(
                      'How do you',
                      style: AppTheme.headingOne.copyWith(
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal,
                      ),
                    ),
                    const Text(
                      'Identify Yourself?',
                      style: AppTheme.headingOne,
                    ),
                    const Gap(32.0),
                    GlintCustomIconChip(
                      label: "I'm Female",
                      assetPath: 'lib/assets/icons/female.svg',
                      isSelected: selectedIdentity == 'Woman',
                      onTap: () {
                        setState(() => selectedIdentity = 'Woman');
                        if (selectedIdentity != null) {
                          context.read<OnBoardingCubit>().setGender("Male");
                        }
                      },
                    ),
                    const Gap(16.0),
                    GlintCustomIconChip(
                      label: "I'm Male",
                      assetPath: 'lib/assets/icons/male.svg',
                      isSelected: selectedIdentity == 'Man',
                      onTap: () {
                        setState(() => selectedIdentity = 'Man');
                        if (selectedIdentity != null) {
                          context.read<OnBoardingCubit>().setGender("Female");
                        }
                      },
                    ),
                    const Gap(16.0),
                    GlintCustomIconChip(
                      label: 'Prefer not to say',
                      assetPath: 'lib/assets/icons/everyone.svg',
                      isSelected: selectedIdentity == 'Everyone',
                      onTap: () {
                        setState(() => selectedIdentity = 'Everyone');
                        if (selectedIdentity != null) {
                          context.read<OnBoardingCubit>().setGender("Everyone");
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
                    onPressed: selectedIdentity != null
                        ? () {
                            final selectedGender = state.currentState?.gender;
                            if (selectedGender != null) {
                              final base = GlintMainRoutes.onBoarding.name;
                              final target =
                                  GlintBoardingRoutes.interestedGender.name;
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
