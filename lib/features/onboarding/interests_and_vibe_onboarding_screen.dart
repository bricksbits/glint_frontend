import 'package:flutter/material.dart';
import 'package:glint_frontend/design/components/glint_custom_app_bar.dart';
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
    return ElevatedButton(
      onPressed: () {
        context.goNamed(GlintProfileRoutes.bio.name);
      },
      child: const Text('Select your Interests'),
    );
  }
}
