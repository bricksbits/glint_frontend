import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:glint_frontend/design/exports.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColours.white,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            //profile info
            ProfileInfoColumn(),

            Gap(12.0),

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
