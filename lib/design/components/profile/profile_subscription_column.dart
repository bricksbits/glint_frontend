import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
          padding: const EdgeInsets.symmetric(
            vertical: 20.0,
            horizontal: 20.0,
          ),
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: AppColours.goldSubscriptionCardBackground,
            borderRadius: const BorderRadius.all(
              Radius.circular(20.0),
            ),
          ),
          child: Column(
            children: [
              // heading 1
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Gold plan",
                    style: AppTheme.headingThree.copyWith(
                      fontWeight: FontWeight.w700,
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                  SvgPicture.asset(
                      'lib/assets/icons/profile/gold_card_glint_logo.svg')
                ],
              )
            ],
          )),
    );
  }
}
