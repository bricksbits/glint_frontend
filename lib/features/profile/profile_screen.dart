import 'package:flutter/material.dart';
import 'package:glint_frontend/navigation/glint_all_routes.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  final bool isAuthenticated = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (isAuthenticated) {
          const Text('Main Profile view');
        } else {
          context.goNamed(GlintProfileRoutes.name.name);
        }
      },
      child: const Center(
        child: Text(
            'This will be the entry point of Profile, if logged in show the actual profile or showcase the oSetup Screen.'
            '\n Respective screens will have the inner route system in it.'),
      ),
    );
  }
}
