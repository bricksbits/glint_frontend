import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:glint_frontend/design/exports.dart';
import 'package:glint_frontend/features/onboarding/on_boarding_cubit.dart';
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
  void initState() {
    context.read<OnBoardingCubit>()
        .setUpLastBoardingState(OnBoardingCompletedTill.PRONOUNS_DONE);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnBoardingCubit, OnBoardingState>(
      builder: (context, state) {
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
                            InterestAndVibeSelection(
                              selectedInterests: (interestsList) {
                                context
                                    .read<OnBoardingCubit>()
                                    .setInterests(interestsList);
                              },
                            ),

                            const Spacer(),

                            // submit
                            SizedBox(
                              width: double.infinity,
                              child: GlintElevatedButton(
                                label: 'Next',
                                foregroundColor: Colors.white,
                                backgroundColor: AppColours.primaryBlue,
                                onPressed: () {
                                  final interestListLength =
                                      state.currentState?.interests;
                                  if (interestListLength != null) {
                                    if (interestListLength.length >= 5) {
                                      // Handle button press
                                      final base =
                                          GlintMainRoutes.onBoarding.name;
                                      final target =
                                          GlintBoardingRoutes.bio.name;
                                      context.go("/$base/$target");
                                    } else {
                                      //Todo: Show Snackbar to select more items
                                    }
                                  } else {
                                    //Todo : Disable the Next Button.
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
            ),
          ),
        );
      },
    );
  }
}
