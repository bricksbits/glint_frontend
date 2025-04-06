import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:glint_frontend/design/exports.dart';
import 'package:glint_frontend/features/splash/splash_screen.dart';
import 'package:glint_frontend/navigation/glint_admin_route_config.dart';
import 'package:glint_frontend/navigation/glint_main_route_config.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class MyGlintApp extends StatelessWidget {
  const MyGlintApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: "Glint People App",
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
      routerConfig: kIsWeb ? glintAdminRoutes : glintMainRoutes,
    );
  }
}
