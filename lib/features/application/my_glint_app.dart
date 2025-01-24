import 'package:flutter/material.dart';
import 'package:glint_frontend/design/exports.dart';
import 'package:glint_frontend/features/event/event_detail_screen.dart';
import 'package:glint_frontend/features/event/event_main_screen.dart';

class MyGlintApp extends StatelessWidget {
  const MyGlintApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Glint People App",
        debugShowCheckedModeBanner: false,
        theme: AppTheme.theme,
        home: const EventMainScreen()
        // routerConfig: glintMainRoutes,
        // routerConfig: glintMainRoutes,
        );
  }
}
