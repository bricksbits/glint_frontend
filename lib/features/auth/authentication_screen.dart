import 'package:flutter/material.dart';

class AuthenticationScreen extends StatelessWidget {
  const AuthenticationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
          'Auth Screen using Firebase Auth for Google and Apple SignIn, we have to work with Access Tokens and Refresh tokens, If User is already signed in we have to save the users data to locally, and delete the data once the user is logged out'),
    );
  }
}
