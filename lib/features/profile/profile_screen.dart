import 'package:flutter/material.dart';
import 'package:glint_frontend/design/exports.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  final bool isAuthenticated = false;

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColours.white,
      appBar: GlintAppBar(
        isProfileScreen: true,
      ),
      body: Text("heelo"),
    );
  }
}
