import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:glint_frontend/design/exports.dart';

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
    return Scaffold(
      body: OnboardingSafeAreaContainer(
        assetPath: 'hello',
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
                  onTap: () => setState(() => selectedGender = 'Woman'),
                ),
                const Gap(16.0),
                GlintCustomIconChip(
                  label: 'Man',
                  assetPath: 'lib/assets/icons/male.svg',
                  isSelected: selectedGender == 'Man',
                  onTap: () => setState(() => selectedGender = 'Man'),
                ),
                const Gap(16.0),
                GlintCustomIconChip(
                  label: 'Everyone',
                  assetPath: 'lib/assets/icons/everyone.svg',
                  isSelected: selectedGender == 'Everyone',
                  onTap: () => setState(() => selectedGender = 'Everyone'),
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
                        //todo - Handle navigation or next step
                      }
                    : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
