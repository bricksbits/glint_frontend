import 'package:flutter/material.dart';
import 'package:glint_frontend/design/exports.dart';
import 'package:glint_frontend/features/onboarding/get_set_glint_onboarding_screen.dart';

class MyGlintApp extends StatelessWidget {
  const MyGlintApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Glint People App",
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
      home: const GetSetGlintOnboardingScreen(),
      // routerConfig: glintMainRoutes,
      // routerConfig: glintMainRoutes,
    );
  }
}
