import 'package:flutter/material.dart';
import 'package:glint_frontend/design/exports.dart';
import 'package:glint_frontend/features/admin/admin_track_specific_event.dart';
// import 'package:glint_frontend/navigation/glint_route_config.dart';

class MyGlintApp extends StatelessWidget {
  const MyGlintApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Glint People App",
        debugShowCheckedModeBanner: false,
        theme: AppTheme.theme,
        home: const AdminTrackSpecificEvent()
        // routerConfig: glintMainRoutes,
        // routerConfig: glintMainRoutes,
        );
  }
}
