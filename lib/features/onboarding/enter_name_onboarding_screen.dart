import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:glint_frontend/design/components/glint_custom_app_bar.dart';
import 'package:glint_frontend/design/exports.dart';
import 'package:glint_frontend/features/onboarding/on_boarding_cubit.dart';
import 'package:glint_frontend/navigation/glint_all_routes.dart';
import 'package:go_router/go_router.dart';

class EnterNameOnboardingScreen extends StatefulWidget {
  const EnterNameOnboardingScreen({super.key});

  @override
  State<EnterNameOnboardingScreen> createState() =>
      _EnterNameOnboardingScreenState();
}

class _EnterNameOnboardingScreenState extends State<EnterNameOnboardingScreen> {
  final _nameController = TextEditingController();
  bool _showInitialsPreference = false;

  bool _allowSubmit = false;

  @override
  void initState() {
    context.read<OnBoardingCubit>()
        .setUpLastBoardingState(OnBoardingCompletedTill.NOT_STARTED);

    _nameController.addListener(() {
      context.read<OnBoardingCubit>().setName(_nameController.text);
    });
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return BlocBuilder<OnBoardingCubit, OnBoardingState>(
      builder: (context, state) {
        return Scaffold(
          body: OnboardingSafeAreaContainer(
            assetPath:
                'lib/assets/images/onboarding/enter_name_background_illustration.png',
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Spacer(),
                Column(
                  children: [
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text: 'Please Enter\nyour ',
                        style: AppTheme.headingOne.copyWith(
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
                        ),
                        children: [
                          TextSpan(
                            text: 'First Name',
                            style: AppTheme.headingOne.copyWith(
                              fontWeight: FontWeight.w700,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Gap(40.0),
                    SizedBox(
                      width: screenSize.width * 0.65,
                      child: GlintTextInputField(
                        controller: _nameController,
                        isCenter: true,
                        onChanged: (value) {
                          if (value.trim().isEmpty) {
                            setState(() {
                              _allowSubmit = false;
                            });
                          }
                          if (value.trim().isNotEmpty) {
                            setState(() {
                              _allowSubmit = true;
                            });
                          }
                        },
                      ),
                    ),
                    const Gap(28.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _showInitialsPreference =
                                  !_showInitialsPreference;
                            });
                          },
                          child: SvgPicture.asset(
                            _showInitialsPreference
                                ? 'lib/assets/icons/glint_checkbox_checked.svg'
                                : 'lib/assets/icons/glint_checkbox_unchecked.svg',
                            height: 20.0,
                            width: 20.0,
                          ),
                        ),
                        const Gap(8.0),
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            style: AppTheme.smallBodyText.copyWith(
                              fontWeight: FontWeight.w300,
                              fontSize: 14.0,
                            ),
                            children: [
                              const TextSpan(
                                text: 'Show only ',
                              ),
                              TextSpan(
                                text: 'initials',
                                style: AppTheme.simpleBodyText.copyWith(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14.0,
                                ),
                              ),
                              const TextSpan(
                                text: ' of my name to others',
                              ),
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
                const Spacer(
                  flex: 8,
                ),
                SizedBox(
                  width: double.infinity,
                  child: GlintElevatedButton(
                    label: 'Next',
                    foregroundColor: Colors.white,
                    backgroundColor: AppColours.primaryBlue,
                    onPressed: _allowSubmit
                        ? () {
                            final currentName = state.currentState?.username;
                            if (currentName != null && _allowSubmit) {
                              final base = GlintMainRoutes.onBoarding.name;
                              final target = GlintBoardingRoutes.dob.name;
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
