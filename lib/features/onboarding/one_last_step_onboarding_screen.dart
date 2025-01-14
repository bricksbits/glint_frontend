import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:glint_frontend/design/exports.dart';

class OneLastStepOnboardingScreen extends StatefulWidget {
  const OneLastStepOnboardingScreen({super.key});

  @override
  State<OneLastStepOnboardingScreen> createState() =>
      _OneLastStepOnboardingScreenState();
}

class _OneLastStepOnboardingScreenState
    extends State<OneLastStepOnboardingScreen> {
  @override
  Widget build(BuildContext context) {
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
              const EnterYourBio(),

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
                    // Handle button press
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
