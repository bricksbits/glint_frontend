import 'package:flutter/material.dart';
import 'package:glint_frontend/design/exports.dart';
import 'package:glint_frontend/features/auth/authentication_screen.dart';
import 'package:glint_frontend/navigation/glint_route_config.dart';

class MyGlintApp extends StatelessWidget {
  const MyGlintApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: "Glint People App",
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
      routerConfig: glintMainRoutes,
      // routerConfig: glintMainRoutes,
    );
  }
}
