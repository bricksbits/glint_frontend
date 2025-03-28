import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:glint_frontend/navigation/glint_all_routes.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool isAuthenticated = true;
    return Center(
      child: SizedBox(
        height: 200,
        width: 200,
        child: ElevatedButton(
          onPressed: () {
            if (isAuthenticated) {
              final targetRoute = kIsWeb
                  ? "/${GlintAdminDasboardRoutes.auth.name}"
                  : "/${GlintMainRoutes.auth.name}";
              context.go(targetRoute);
            } else {
              final targetRoute = kIsWeb
                  ? "/${GlintAdminDasboardRoutes.home.name}"
                  : "/${GlintMainRoutes.home.name}";
              context.go(targetRoute);
            }
          },
          child: const Text(kIsWeb ? "On Web" : "On Mobile"),
        ),
      ),
    );
  }
}
