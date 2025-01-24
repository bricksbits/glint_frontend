import 'package:flutter/material.dart';
import 'package:glint_frontend/design/exports.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColours.white,
      body: Center(
        child: Column(
          children: [
            //profile info
            Expanded(
              child: ProfileInfoColumn(),
            ),
            // subscription cards
            Expanded(
              child: ProfileSubscriptionColumn(),
            ),
          ],
        ),
      ),
    );
  }
}
