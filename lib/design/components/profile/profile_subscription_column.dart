import 'package:flutter/material.dart';

import 'exports.dart';

class ProfileSubscriptionColumn extends StatelessWidget {
  const ProfileSubscriptionColumn({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 20.0,
      ),
      child: Column(
        children: [
          FeaturesLeftCountContainer(),
        ],
      ),
    );
  }
}
