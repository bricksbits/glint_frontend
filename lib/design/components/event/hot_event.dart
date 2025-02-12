import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:glint_frontend/design/exports.dart';

class HotEvent extends StatelessWidget {
  const HotEvent({
    super.key,
    this.showDiscount = true,
  });

  final bool showDiscount;

  @override
  Widget build(BuildContext context) {
    final cardHeight = showDiscount ? 220.0 : 128.0;
    final screenSize = MediaQuery.of(context).size;
    const eventName = 'The Local Food Fest';
    const eventDate = '20 Feb 2023';
    const eventImage =
        'https://media.istockphoto.com/id/1806011581/photo/overjoyed-happy-young-people-dancing-jumping-and-singing-during-concert-of-favorite-group.jpg?s=612x612&w=0&k=20&c=cMFdhX403-yKneupEN-VWSfFdy6UWf1H0zqo6QBChP4%3D';
    const eventLocation = 'Shriram business park';
    const eventOldPrice = 150;
    const eventNewPrice = 200;
    const eventDiscountDaysLeft = 7;
    const interactedUsers = [
      'https://avatars.githubusercontent.com/u/70279771?v=4',
      'https://avatars.githubusercontent.com/u/70279771?v=4',
      'https://avatars.githubusercontent.com/u/70279771?v=4',
    ];
    return Stack(
      children: [
        // Blurred background image
        Container(
          width: double.infinity,
          height: cardHeight,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            image: const DecorationImage(
              image: NetworkImage(eventImage),
              fit: BoxFit.cover,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24.0,
                  vertical: 20.0,
                ),
                color: Colors.black.withAlpha(
                  160,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // event name
                    Text(
                      eventName,
                      style: AppTheme.headingFour.copyWith(
                        fontStyle: FontStyle.normal,
                        color: AppColours.white,
                        fontWeight: FontWeight.w900,
                      ),
                    ),

                    // event Location and Date
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GlintIconLabel(
                          iconPath: 'lib/assets/icons/calendar_icon.svg',
                          svgColor: AppColours.vibrantYellow,
                          label: eventDate,
                          style: AppTheme.simpleText.copyWith(
                            fontSize: 12.0,
                            color: AppColours.white,
                          ),
                        ),
                        const Gap(10.0),
                        GlintIconLabel(
                          iconPath: 'lib/assets/icons/location_icon.svg',
                          svgColor: AppColours.vibrantYellow,
                          label: eventLocation,
                          style: AppTheme.simpleText.copyWith(
                            fontSize: 12.0,
                            color: AppColours.white,
                          ),
                        ),
                      ],
                    ),

                    // pricing and interested profiles
                    if (showDiscount)
                      const _HotEventDiscountAndInterestedProfiles(
                        eventOldPrice: eventOldPrice,
                        eventNewPrice: eventNewPrice,
                        eventDiscountDaysLeft: eventDiscountDaysLeft,
                        interactedUsers: interactedUsers,
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),

        // event image overlay container
        Positioned(
          right: 0,
          child: Container(
            width: kIsWeb ? 300.0 : screenSize.width * 0.35,
            height: cardHeight,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(eventImage),
                fit: BoxFit.cover,
              ),
              border: Border(
                left: BorderSide(
                  color: AppColours.white,
                  width: 1.5,
                ),
              ),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(20.0),
                bottomRight: Radius.circular(20.0),
              ),
            ),
          ),
        ),

        // info icon button
        Positioned(
          top: 12.0,
          right: 14.0,
          child: SvgPicture.asset(
            'lib/assets/icons/info_icon.svg',
          ),
        ),
      ],
    );
  }
}

class _HotEventDiscountAndInterestedProfiles extends StatelessWidget {
  const _HotEventDiscountAndInterestedProfiles({
    required this.eventOldPrice,
    required this.eventNewPrice,
    required this.eventDiscountDaysLeft,
    required this.interactedUsers,
  });

  final int eventOldPrice;
  final int eventNewPrice;
  final int eventDiscountDaysLeft;
  final List<String> interactedUsers;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // old price and new price and days left
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  '₹ ',
                  style: AppTheme.simpleText.copyWith(
                    color: AppColours.white,
                  ),
                ),
                Text(
                  eventOldPrice.toString(),
                  style: AppTheme.simpleText.copyWith(
                    decoration: TextDecoration.lineThrough,
                    decorationColor: AppColours.white,
                    color: AppColours.white,
                  ),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: '₹ $eventNewPrice',
                        style: AppTheme.heavyBodyText.copyWith(
                          color: AppColours.vibrantYellow,
                        ),
                      ),
                    ],
                  ),
                ),
                const Gap(8.0),
                Container(
                  decoration: BoxDecoration(
                    color: AppColours.black,
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                    vertical: 3.0,
                  ),
                  child: Text(
                    '$eventDiscountDaysLeft days left',
                    style: const TextStyle(
                      fontFamily: 'AlbertSans',
                      fontSize: 10.0,
                      fontWeight: FontWeight.w500,
                      color: AppColours.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),

        const Gap(16.0),

        // see profiles widget
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ...interactedUsers.map(
              (userImage) => Align(
                widthFactor: 0.5,
                child: Padding(
                  padding: const EdgeInsets.only(left: 6),
                  child: CircleAvatar(
                    radius: 10.0,
                    backgroundImage: NetworkImage(userImage),
                  ),
                ),
              ),
            ),
            const Gap(20.0),
            Text(
              'See profiles',
              style: AppTheme.simpleText.copyWith(
                fontWeight: FontWeight.w500,
                color: AppColours.white,
              ),
            ),
            const Gap(2.0),
            const Icon(
              Icons.chevron_right,
              color: AppColours.vibrantYellow,
            ),
          ],
        ),
      ],
    );
  }
}
