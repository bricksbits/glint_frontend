import 'package:flutter/material.dart';
import 'package:glint_frontend/design/exports.dart';
import 'package:glint_frontend/features/chat/story/view_story_screen.dart';

class MyGlintApp extends StatelessWidget {
  const MyGlintApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Glint People App",
        debugShowCheckedModeBanner: false,
        theme: AppTheme.theme,
        home: const ViewStoryScreen()
        // routerConfig: glintMainRoutes,
        // routerConfig: glintMainRoutes,
        );
  }
}
