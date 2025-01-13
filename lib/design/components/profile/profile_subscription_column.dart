import 'package:flutter/material.dart';
import 'package:glint_frontend/design/exports.dart';

class ProfileSubscriptionColumn extends StatelessWidget {
  const ProfileSubscriptionColumn({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20.0,
      ),
      child: Column(
        children: [
          const FeaturesLeftCountContainer(),

          // Ensuring the subscription card takes remaining height
          Expanded(
            child: _buildSubscriptionCard(),
          ),
        ],
      ),
    );
  }

  Widget _buildSubscriptionCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: AppColours.primaryBlue,
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        child: const Center(
          child: Text(
            'Subscription Card',
            style: TextStyle(color: Colors.white, fontSize: 18.0),
          ),
        ),
      ),
    );
  }
}
