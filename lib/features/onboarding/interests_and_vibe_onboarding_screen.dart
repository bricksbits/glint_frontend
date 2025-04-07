import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:glint_frontend/design/exports.dart';
import 'package:glint_frontend/navigation/glint_all_routes.dart';
import 'package:go_router/go_router.dart';

class InterestsAndVibeOnboardingScreen extends StatefulWidget {
  const InterestsAndVibeOnboardingScreen({super.key});

  @override
  State<InterestsAndVibeOnboardingScreen> createState() =>
      _InterestsAndVibeOnboardingScreenState();
}

class _InterestsAndVibeOnboardingScreenState
    extends State<InterestsAndVibeOnboardingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColours.white,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: IntrinsicHeight(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0)
                        .copyWith(bottom: 16.0),
                    child: Column(
                      children: [
                        // heading
                        Text(
                          'Your Interests, Your Vibe',
                          style: AppTheme.headingOne.copyWith(
                            fontWeight: FontWeight.w700,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        const Gap(8.0),

                        // sub heading
                        const Text(
                          'The more we know, the better your matches!',
                          style: AppTheme.smallBodyText,
                        ),
                        const Gap(44.0),

                        // chips column
                        const InterestAndVibeSelection(),

                        const Spacer(),

                        // submit
                        SizedBox(
                          width: double.infinity,
                          child: GlintElevatedButton(
                            label: 'Next',
                            foregroundColor: Colors.white,
                            backgroundColor: AppColours.primaryBlue,
                            onPressed: () {
                              // Handle button press
                              final base = GlintMainRoutes.onBoarding.name;
                              final target = GlintBoardingRoutes.bio.name;
                              context.go("/$base/$target");
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
        ),
      ),
    );
  }
}
