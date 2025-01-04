import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:glint_frontend/design/exports.dart';

class UploadPhotosOnboardingScreen extends StatefulWidget {
  const UploadPhotosOnboardingScreen({super.key});

  @override
  State<UploadPhotosOnboardingScreen> createState() =>
      _UploadPhotosOnboardingScreenState();
}

class _UploadPhotosOnboardingScreenState
    extends State<UploadPhotosOnboardingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColours.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0)
              .copyWith(bottom: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Top Content Section
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // Heading
                      Text(
                        'Make a Great',
                        style: AppTheme.headingOne.copyWith(
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
                        ),
                      ),
                      const Text(
                        'First Impression!',
                        style: AppTheme.headingOne,
                      ),
                      const Gap(24.0),
                      // Description
                      const Text(
                        'Upload a clear, recent photo or video where you’re being your true self. Let them see who they’re swiping for!',
                        textAlign: TextAlign.center,
                        style: AppTheme.simpleText,
                      ),
                      const Gap(32.0),
                      // Upload Pictures Containers
                      const UploadPicturesContainers(),
                      const Gap(12.0),
                    ],
                  ),
                ),
              ),

              // Hint Tip
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'lib/assets/icons/sparkling_stars.svg',
                  ),
                  const Gap(8.0),
                  Expanded(
                    child: Text(
                      'People with more than 3 pictures in their profile have higher chances of getting a match',
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.clip,
                      style: AppTheme.simpleText.copyWith(
                        fontWeight: FontWeight.w300,
                        fontSize: 12.5,
                      ),
                    ),
                  ),
                ],
              ),
              const Gap(24.0),

              // Submit Button
              SizedBox(
                width: double.infinity,
                child: GlintElevatedButton(
                  label: 'Next',
                  foregroundColor: Colors.white,
                  backgroundColor: AppColours.primaryBlue,
                  onPressed: () {
                    // TODO: Handle navigation or next step
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
