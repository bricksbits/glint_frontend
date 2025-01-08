import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:glint_frontend/design/components/glint_custom_app_bar.dart';
import 'package:glint_frontend/design/exports.dart';
import 'package:glint_frontend/navigation/glint_all_routes.dart';
import 'package:go_router/go_router.dart';

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
  Widget build(BuildContext context) {
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
                  onTap: () => setState(() => selectedIdentity = 'Woman'),
                ),
                const Gap(16.0),
                GlintCustomIconChip(
                  label: "I'm Male",
                  assetPath: 'lib/assets/icons/male.svg',
                  isSelected: selectedIdentity == 'Man',
                  onTap: () => setState(() => selectedIdentity = 'Man'),
                ),
                const Gap(16.0),
                GlintCustomIconChip(
                  label: 'Prefer not to say',
                  assetPath: 'lib/assets/icons/everyone.svg',
                  isSelected: selectedIdentity == 'Everyone',
                  onTap: () => setState(() => selectedIdentity = 'Everyone'),
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
                        context
                            .goNamed(GlintProfileRoutes.interestedGender.name);
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
