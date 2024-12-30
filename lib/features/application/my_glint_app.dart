import 'package:flutter/material.dart';
import 'package:glint_frontend/design/common/app_theme.dart';
import 'package:glint_frontend/features/filter/filter_preference_screen.dart';

class MyGlintApp extends StatelessWidget {
  const MyGlintApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Glint People App",
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
      home: const FilterPreferenceScreen(),
      // routerConfig: glintMainRoutes,
    );
  }
}
