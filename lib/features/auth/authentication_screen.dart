import 'package:flutter/material.dart';
import 'package:glint_frontend/navigation/glint_all_routes.dart';
import 'package:go_router/go_router.dart';

class AuthenticationScreen extends StatelessWidget {
  const AuthenticationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          context.goNamed(GlintProfileRoutes.name.name);
        },
        child: const Text(
            'Auth Screen using Firebase Auth for Google and Apple SignIn, we have to work with Access Tokens and Refresh tokens, If User is already signed in we have to save the users data to locally, and delete the data once the user is logged out'),
      ),
    );
  }
}
