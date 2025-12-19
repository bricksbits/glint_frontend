import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:glint_frontend/design/common/custom_snackbar.dart';
import 'package:glint_frontend/features/payment/model/payment_argument_model.dart';
import 'package:glint_frontend/navigation/glint_all_routes.dart';
import 'package:go_router/go_router.dart';

import '../../exports.dart';

class ProfileSubscriptionColumn extends StatelessWidget {
  const ProfileSubscriptionColumn(
      {super.key, required this.superLikeCounts, required this.rewindCounts, required this.superDmCounts});

  final int superLikeCounts;
  final int rewindCounts;
  final int superDmCounts;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Displays the remaining features count
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: FeaturesLeftCountContainer(
            superLikeCounts: superLikeCounts,
            rewindCounts: rewindCounts,
            superDmCounts: superDmCounts,
          ),
        ),

        // Carousel for subscription cards
        SizedBox(
          height: 280.0,
          width: double.infinity,
          child: CarouselSlider(
            items: [
              // Platinum card
              _buildSubscriptionCard(
                context: context,
                onTap: () {
                  showCustomSnackbar(
                    context,
                    message: "Subscriptions not available, please update the app for newer version.",
                  );
                  // context.pushNamed(
                  //   GlintMainRoutes.payment.name,
                  //   extra: PaymentArgumentModel(
                  //     membershipType: MembershipType.PLATINUM,
                  //     amountOfSelectedMembership: "359",
                  //     timePeriod: "30",
                  //     eventId: null,
                  //     matchId: null,
                  //     userOne: null,
                  //     userTwo: null,
                  //     eventTicketPrice: null,
                  //   ),
                  // );
                },
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
                price: '₹ 349',
                gradient: AppColours.platinumSubscriptionCardBackground,
                textGradient: AppColours.platinumSubscriptionTextGradient,
                isGoldPlan: false,
              ),

              // Gold card
              _buildSubscriptionCard(
                context: context,
                onTap: () {
                  showCustomSnackbar(
                    context,
                    message: "Subscriptions not available, please update the app for newer version.",
                  );
                  // context.pushNamed(
                  //   GlintMainRoutes.payment.name,
                  //   extra: PaymentArgumentModel(
                  //     membershipType: MembershipType.GOLD,
                  //     amountOfSelectedMembership: "359",
                  //     timePeriod: "30",
                  //     eventId: null,
                  //     matchId: null,
                  //     userOne: null,
                  //     userTwo: null,
                  //     eventTicketPrice: null,
                  //   ),
                  // );
                },
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
    );
  }

  // subscription card widget
  Widget _buildSubscriptionCard({
    required BuildContext context,
    required String title,
    required String logoPath,
    required List<String> leftFeatures,
    required List<String> rightFeatures,
    required String price,
    required Gradient gradient,
    required LinearGradient textGradient,
    required bool isGoldPlan,
    required VoidCallback? onTap,
  }) {
    final screenSize = MediaQuery
        .of(context)
        .size;
    final isSmallScreen = screenSize.width < 400;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 18.0),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 18.0),
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: gradient,
          border: Border.all(
            color: const Color(0xFFF1F1F1),
            width: 1,
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(20.0),
          ),
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
                  style: AppTheme.headingFour.copyWith(
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
                          (feature) =>
                          _buildTickLabel(
                              feature, isGoldPlan, isSmallScreen),
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
                          (feature) =>
                          _buildTickLabel(
                            feature,
                            isGoldPlan,
                            isSmallScreen,
                          ),
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
                    onPressed: onTap,
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
  Widget _buildTickLabel(String text, bool isGoldPlan, bool isSmallScreen) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.check,
          color: isGoldPlan ? const Color(0xFFEAA74A) : AppColours.white,
          size: isSmallScreen ? 16.0 : 18.0,
        ),
        const Gap(4.0),
        Expanded(
          child: Text(
            text,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              overflow: TextOverflow.ellipsis,
              color: isGoldPlan ? AppColours.black : AppColours.white,
              fontSize: isSmallScreen ? 12.0 : 14.0,
            ),
          ),
        ),
      ],
    );
  }
}
