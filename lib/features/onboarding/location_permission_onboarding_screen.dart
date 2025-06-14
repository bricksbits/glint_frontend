import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:glint_frontend/design/exports.dart';

class LocationPermissionOnboardingScreen extends StatelessWidget {
  const LocationPermissionOnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Stack(
          children: [
            // Background Image
            Positioned.fill(
              child: Image.asset(
                'lib/assets/images/onboarding/location_background.png',
                fit: BoxFit.cover,
              ),
            ),

            // Main content goes here
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 48.0),
                child: Column(
                  children: [
                    const Spacer(),
                    // Add more widgets here

                    _locationPermissionContainer(context),

                    const Gap(20.0),

                    Text(
                      'We value your privacy and only use your location to enhance your experience.',
                      style: AppTheme.simpleText.copyWith(
                        fontWeight: FontWeight.w300,
                        fontSize: 12.0,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    const Spacer(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _locationPermissionContainer(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 24.0,
        vertical: 32.0,
      ).copyWith(bottom: 20.0),
      decoration: BoxDecoration(
        color: AppColours.backgroundShade,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Column(
        children: [
          SizedBox.square(
            dimension: 72.0,
            child: Image.asset('lib/assets/icons/location_onboarding_icon.png'),
          ),
          const Gap(24.0),
          const Text(
            "See Who’s Close to You!",
            style: AppTheme.headingThree,
          ),
          const Gap(10.0),
          const Text(
            'Enabling location helps us find matches closer to you!',
            style: AppTheme.simpleText,
            textAlign: TextAlign.center,
          ),
          const Gap(40.0),
          SizedBox(
            width: double.infinity,
            child: GlintElevatedButton(
              label: 'Enable Location',
              onPressed: () {
                //todo - add location permission setup
              },
            ),
          )
        ],
      ),
    );
  }
}
