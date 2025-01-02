import 'package:flutter/material.dart';
import 'package:glint_frontend/design/exports.dart';

class OnboardingSafeAreaContainer extends StatelessWidget {
  const OnboardingSafeAreaContainer({
    super.key,
    required this.child,
    required this.assetPath,
  });

  final Widget child;
  final String assetPath;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20.0,
          vertical: 20.0,
        ),
        child: Container(
          width: double.infinity,
          height: double.infinity,
          padding: const EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 20.0,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.0),
            color: AppColours.backgroundShade,
            image: const DecorationImage(
              image: AssetImage(
                'lib/assets/images/onboarding/hand_holding_eye_illustration.png',
              ),
              fit: BoxFit.fill,
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}
