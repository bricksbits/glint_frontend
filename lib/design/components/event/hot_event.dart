import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:glint_frontend/design/exports.dart';
import 'package:glint_frontend/domain/business_logic/models/event/event_list_domain_model.dart';

class HotEvent extends StatelessWidget {
  const HotEvent({
    super.key,
    required this.eventModel,
    required this.getEventInfo,
    required this.fetchProfiles,
  });

  final EventListDomainModel eventModel;
  final Function(String) getEventInfo;
  final Function(String) fetchProfiles;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    const interactedUsers = [
      'https://avatars.githubusercontent.com/u/70279771?v=4',
      'https://avatars.githubusercontent.com/u/70279771?v=4',
      'https://avatars.githubusercontent.com/u/70279771?v=4',
    ];
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Stack(
        children: [
          // Blurred background image
          GestureDetector(
            onTap: () {
              fetchProfiles(eventModel.eventId);
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Stack(
                children: [
                  // Background image
                  SizedBox(
                    width: double.infinity,
                    height: 220,
                    child: CachedNetworkImage(
                      imageUrl: eventModel.eventCoverImageUrl,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Image.asset(
                        "lib/assets/images/event/event_banner_placeholder.png",
                        fit: BoxFit.cover,
                        height: 200,
                      ),
                      errorWidget: (context, url, error) => Image.asset(
                        "lib/assets/images/event/event_banner_placeholder.png",
                        fit: BoxFit.cover,
                        height: 200,
                      ),
                    ),
                  ),

                  // Blur & overlay
                  Positioned.fill(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: Container(
                        color: Colors.black.withAlpha(160),
                      ),
                    ),
                  ),

                  // Content
                  Positioned.fill(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Event name
                          Text(
                            eventModel.eventName,
                            style: AppTheme.headingFour.copyWith(
                              fontStyle: FontStyle.normal,
                              color: AppColours.white,
                              fontWeight: FontWeight.w900,
                            ),
                          ),

                          // Date and location
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GlintIconLabel(
                                iconPath: 'lib/assets/icons/calendar_icon.svg',
                                svgColor: AppColours.vibrantYellow,
                                label: eventModel.eventdate,
                                style: AppTheme.simpleText.copyWith(
                                  fontSize: 12.0,
                                  color: AppColours.white,
                                ),
                              ),
                              const Gap(10.0),
                              GlintIconLabel(
                                iconPath: 'lib/assets/icons/location_icon.svg',
                                svgColor: AppColours.vibrantYellow,
                                label: eventModel.eventLocation,
                                style: AppTheme.simpleText.copyWith(
                                  fontSize: 12.0,
                                  color: AppColours.white,
                                ),
                              ),
                            ],
                          ),

                          // Pricing and interested profiles
                          _HotEventDiscountAndInterestedProfiles(
                            eventId: eventModel.eventId,
                            eventOldPrice: eventModel.eventOldPrice,
                            eventNewPrice: eventModel.eventCurrentPrice,
                            eventDiscountDaysLeft: eventModel.daysLeft,
                            interactedUsers: interactedUsers,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // event image overlay container
          Positioned(
            right: 0,
            child: Container(
                width: kIsWeb
                    ? screenSize.width > 560
                        ? 300.0
                        : screenSize.width < 360
                            ? 60.0
                            : 140.0
                    : screenSize.width * 0.35,
                height: 220,
                decoration: const BoxDecoration(
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
                child: FadeInImage.assetNetwork(
                  placeholder: 'lib/assets/images/event/event_banner_placeholder.png',
                  // Local placeholder
                  image: eventModel.eventCoverImageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 220,
                  imageErrorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      'lib/assets/images/event/event_banner_placeholder.png',
                      fit: BoxFit.cover,
                    );
                  },
                )),
          ),

          // info icon button
          Positioned(
            right: 10,
            top: 10,
            child: GestureDetector(
              onTap: () {
                getEventInfo(eventModel.eventId);
              },
              child: Positioned(
                top: 12.0,
                right: 14.0,
                child: SvgPicture.asset(
                  'lib/assets/icons/info_icon.svg',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HotEventDiscountAndInterestedProfiles extends StatelessWidget {
  const _HotEventDiscountAndInterestedProfiles({
    required this.eventId,
    required this.eventOldPrice,
    required this.eventNewPrice,
    required this.eventDiscountDaysLeft,
    required this.interactedUsers,
  });

  final String eventId;
  final String eventOldPrice;
  final String eventNewPrice;
  final String eventDiscountDaysLeft;
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
        // when clicked here, it will mark user as interested in event
        GestureDetector(
          onTap: () {
            debugPrint('user as interested clicked for event $eventId');
            debugPrint('user as interested clicked');
          },
          child: Row(
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
        ),
      ],
    );
  }
}
