import 'package:flutter/material.dart';
import 'package:glint_frontend/design/exports.dart';

class OnboardingSafeAreaContainer extends StatelessWidget {
  const OnboardingSafeAreaContainer({
    super.key,
    required this.assetPath,
    required this.child,
  });

  final String assetPath;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
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
            image: DecorationImage(
              image: AssetImage(
                assetPath,
              ),
              fit: screenSize.width > 560 ? BoxFit.fitWidth : BoxFit.fill,
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}
