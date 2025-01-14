import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:glint_frontend/design/exports.dart';

class ProfileSubscriptionColumn extends StatelessWidget {
  const ProfileSubscriptionColumn({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: [
          // Displays the remaining features count
          const FeaturesLeftCountContainer(),

          // Carousel for subscription cards
          Expanded(
            child: CarouselSlider(
              items: [
                _buildSubscriptionCard(
                  title: "Platinum plan",
                  logoPath:
                      'lib/assets/icons/profile/platinum_card_glint_logo.svg',
                  leftFeatures: [
                    '8 Superlikes',
                    '7 SuperDM',
                    '7 Rewinds',
                    'Unlimited Likes',
                    'See Who Likes You',
                  ],
                  rightFeatures: [
                    'Profile Boost',
                    '15 AI Chat Suggestion',
                    'Message First',
                    'Hide Ads',
                  ],
                  price: '₹ 249',
                  gradient: AppColours.platinumSubscriptionCardBackground,
                  textGradient: AppColours.platinumSubscriptionTextGradient,
                  isGoldPlan: false,
                ),
                _buildSubscriptionCard(
                  title: "Gold plan",
                  logoPath: 'lib/assets/icons/profile/gold_card_glint_logo.svg',
                  leftFeatures: [
                    '5 Superlikes',
                    '3 SuperDM',
                    '3 Rewinds',
                    'Unlimited Likes',
                    'See Who Likes You',
                  ],
                  rightFeatures: [
                    '7 AI Chat Suggestion',
                    'Hide Ads',
                    'Message First',
                  ],
                  price: '₹ 249',
                  gradient: AppColours.goldSubscriptionCardBackground,
                  textGradient: AppColours.goldSubscriptionTextGradient,
                  isGoldPlan: true,
                ),
              ],
              options: CarouselOptions(
                height: double.infinity,
                viewportFraction: 1.0,
                enableInfiniteScroll: true,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 3),
                enlargeCenterPage: true,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // subscription card widget
  Widget _buildSubscriptionCard({
    required String title,
    required String logoPath,
    required List<String> leftFeatures,
    required List<String> rightFeatures,
    required String price,
    required Gradient gradient,
    required LinearGradient textGradient,
    required bool isGoldPlan,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: const BorderRadius.all(Radius.circular(20.0)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Card header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: AppTheme.headingThree.copyWith(
                    fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.normal,
                    color: isGoldPlan ? AppColours.black : AppColours.white,
                  ),
                ),
                SvgPicture.asset(logoPath),
              ],
            ),

            // Features section
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Left column
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: leftFeatures
                        .map(
                          (feature) => _buildTickLabel(feature, isGoldPlan),
                        )
                        .toList(),
                  ),
                ),
                // Right column
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: rightFeatures
                        .map(
                          (feature) => _buildTickLabel(feature, isGoldPlan),
                        )
                        .toList(),
                  ),
                ),
              ],
            ),

            // Footer section
            Row(
              children: [
                // Pricing
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GlintGradientTextWidget(
                      text: price,
                      gradient: textGradient,
                      style: AppTheme.simpleBodyText.copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: 20.0,
                        fontStyle: FontStyle.normal,
                      ),
                    ),
                    Text(
                      'per month',
                      style: AppTheme.smallBodyText.copyWith(
                        fontStyle: FontStyle.italic,
                        color: isGoldPlan ? AppColours.black : AppColours.white,
                      ),
                    ),
                  ],
                ),
                const Gap(24.0),
                // Upgrade button
                Expanded(
                  child: GlintGradientElevatedButton(
                    label: 'Upgrade Plan',
                    gradient: textGradient,
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // feature tick label
  Widget _buildTickLabel(String text, bool isGoldPlan) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.check,
          color: isGoldPlan ? const Color(0xFFEAA74A) : AppColours.white,
          size: 18,
        ),
        const Gap(8.0),
        Text(
          text,
          style: TextStyle(
            color: isGoldPlan ? AppColours.black : AppColours.white,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
