import 'package:flutter/material.dart';
import 'package:glint_frontend/design/common/app_theme.dart';
import 'package:glint_frontend/navigation/glint_route_config.dart';
import 'package:glint_frontend/features/exports.dart';

class MyGlintApp extends StatelessWidget {
  const MyGlintApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Glint People App",
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
      home: const NotificationScreen(),
      // routerConfig: glintMainRoutes,
    );
  }
}