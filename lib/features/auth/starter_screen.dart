import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:glint_frontend/design/exports.dart';
import 'package:glint_frontend/navigation/glint_all_routes.dart';
import 'package:go_router/go_router.dart';

class StarterScreen extends StatelessWidget {
  const StarterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(bottom: 20.0),
        child: Column(
          children: [
            // picture asset here
            // todo - glint (fix this image rendering)
            SvgPicture.asset(
              'lib/assets/images/auth/auth-screen-grouped.svg',
            ),
            const Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _AuthHeader(),
                    Gap(16.0),
                    Text(
                      'Why wait? Dive into a world of potential matches and discover the chemistry you\'ve been looking for',
                      style: AppTheme.simpleText,
                    ),
                    Spacer(),
                    _AuthButtons(),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

/// Header section with title and subtitle
class _AuthHeader extends StatelessWidget {
  const _AuthHeader();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Ready to Glint',
              style: AppTheme.headingOne.copyWith(
                fontWeight: FontWeight.w400,
                fontStyle: FontStyle.normal,
              ),
            ),
            const Gap(8.0),
            SvgPicture.asset('lib/assets/icons/sparkling_stars.svg'),
          ],
        ),
        RichText(
          text: TextSpan(
            text: 'Something ',
            style: AppTheme.headingOne.copyWith(
              fontWeight: FontWeight.w400,
              fontStyle: FontStyle.normal,
            ),
            children: const [
              TextSpan(
                text: 'Unexpected?',
                style: AppTheme.headingOne,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// Authentication buttons container
class _AuthButtons extends StatelessWidget {
  const _AuthButtons();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColours.primaryBlue,
        borderRadius: BorderRadius.circular(30.0),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomCenter,
          colors: [
            AppColours.primaryBlue,
            AppColours.primaryBlue,
            AppColours.primaryBlue.withAlpha(200),
            AppColours.primaryBlue.withAlpha(200),
          ],
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 22.0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          // Create account elevated button
          SizedBox(
            width: double.infinity,
            child: GlintElevatedButton(
              label: 'Create Account',
              backgroundColor: AppColours.white,
              customBorderRadius: 30.0,
              customTextStyle: AppTheme.simpleBodyText,
              onPressed: () {
                context.go("/${GlintMainRoutes.onBoarding.name}");
              },
            ),
          ),
          const Gap(12.0),
          // Login elevated button
          GlintCustomBorderedElevatedButton(
            label: 'Login',
            customBorderRadius: 30.0,
            backgroundColor: Colors.transparent,
            customTextStyle: AppTheme.simpleBodyText.copyWith(
              color: AppColours.white,
            ),
            onPressed: () {
              context.go("/${GlintMainRoutes.auth.name}");
            },
          ),
          const Gap(24.0),
          const _AuthTerms(),
        ],
      ),
    );
  }
}

// Terms and conditions + privacy policy section
class _AuthTerms extends StatelessWidget {
  const _AuthTerms();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: AppTheme.simpleText.copyWith(
              fontSize: 10.0,
              color: AppColours.white,
            ),
            children: [
              const TextSpan(text: "By signing up, you agree to our "),
              TextSpan(
                text: "Terms & Conditions.",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    // TODO - Handle Terms & Conditions tap
                  },
              ),
            ],
          ),
        ),
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: AppTheme.simpleText.copyWith(
              fontSize: 10.0,
              color: AppColours.white,
            ),
            children: [
              const TextSpan(text: "See how we use your data in our "),
              TextSpan(
                text: "Privacy Policy.",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    // TODO - Handle Privacy Policy tap
                  },
              ),
            ],
          ),
        ),
        Text(
          "We never post to Facebook.",
          textAlign: TextAlign.center,
          style: AppTheme.simpleText.copyWith(
            fontSize: 10.0,
            color: AppColours.white,
          ),
        ),
      ],
    );
  }
}
