import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:glint_frontend/design/exports.dart';
import 'package:glint_frontend/features/onboarding/on_boarding_cubit.dart';
import 'package:glint_frontend/navigation/glint_all_routes.dart';
import 'package:go_router/go_router.dart';

class GetSetGlintOnboardingScreen extends StatefulWidget {
  const GetSetGlintOnboardingScreen({super.key});

  @override
  State<GetSetGlintOnboardingScreen> createState() =>
      _GetSetGlintOnboardingScreenState();
}

class _GetSetGlintOnboardingScreenState
    extends State<GetSetGlintOnboardingScreen> {
  @override
  void initState() {
    context
        .read<OnBoardingCubit>()
        .setUpLastBoardingState(OnBoardingCompletedTill.IMAGES_SELECTED);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnBoardingCubit, OnBoardingState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColours.white,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0)
                  .copyWith(bottom: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: 'Get, Set, ',
                      style: AppTheme.headingOne.copyWith(
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal,
                      ),
                      children: [
                        TextSpan(
                          text: 'Glint',
                          style: AppTheme.headingOne.copyWith(
                            fontWeight: FontWeight.w700,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Gap(8.0),

                  // sub heading
                  const Text(
                    'Set your vibe and let the sparks fly!',
                    style: AppTheme.smallBodyText,
                  ),
                  const Gap(60.0),

                  //im looking for card
                  ImLookingForCard(
                    lookingFor: null,
                    lookingForCallback: (value) {
                      context.read<OnBoardingCubit>().setLookingFor(value);
                    },
                  ),

                  const Gap(16.0),

                  // pronouns card Not needed as already asking for Gender
                  // YourPronounsCard(pronounsSelected: (pronouns) {
                  //   context.read<OnBoardingCubit>().setPronouns("");
                  // }),

                  const Spacer(),

                  SizedBox(
                    width: double.infinity,
                    child: GlintElevatedButton(
                      label: 'Next',
                      foregroundColor: Colors.white,
                      backgroundColor: AppColours.primaryBlue,
                      onPressed: () {
                        var lookingFor = state.currentState?.relationShipGoals;
                        if (lookingFor != null) {
                          context
                              .read<OnBoardingCubit>()
                              .updateProfileLocally();
                          final target = GlintBoardingRoutes.interests.name;
                          context.go("/$target");
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
