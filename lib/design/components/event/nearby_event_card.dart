import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:glint_frontend/design/exports.dart';
import 'package:glint_frontend/domain/business_logic/models/event/event_list_domain_model.dart';

class NearbyEventCard extends StatelessWidget {
  const NearbyEventCard({
    super.key,
    required this.eventModel,
    required this.fetchProfiles,
  });

  final EventListDomainModel eventModel;
  final Function(String) fetchProfiles;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        fetchProfiles(eventModel.eventId);
      },
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 24.0,
            vertical: 20.0,
          ),
          decoration: BoxDecoration(
            border: Border.all(
              color: AppColours.chipBackgroundShade,
            ),
            color: AppColours.white,
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // details
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Event name
                  Text(
                    eventModel.eventName,
                    style: AppTheme.headingFour.copyWith(
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                    ),
                  ),

                  const Gap(16.0),

                  GlintIconLabel(
                    iconPath: 'lib/assets/icons/calendar_icon.svg',
                    label: eventModel.eventdate,
                    style: AppTheme.simpleText.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),

                  const Gap(8.0),

                  GlintIconLabel(
                    iconPath: 'lib/assets/icons/location_icon.svg',
                    label: eventModel.eventLocation,
                    style: AppTheme.simpleText,
                  ),

                  // Pricing and interested profiles
                  HotEventDiscountAndInterestedProfiles(
                    eventId: eventModel.eventId,
                    eventOldPrice: eventModel.eventOldPrice,
                    eventNewPrice: eventModel.eventCurrentPrice,
                    eventDiscountDaysLeft: eventModel.daysLeft,
                    interactedUsers: const [
                      'https://avatars.githubusercontent.com/u/70279771?v=4',
                      'https://avatars.githubusercontent.com/u/70279771?v=4',
                      'https://avatars.githubusercontent.com/u/70279771?v=4',
                    ],
                    isHotEvent: false,
                  ),
                ],
              ),

              const Spacer(),

              // Event image
              _buildImage(
                imageUrl: eventModel.eventCoverImageUrl,
                daysLeft: eventModel.daysLeft,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImage({
    required String imageUrl,
    required String daysLeft,
  }) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          height: 96.0,
          width: 96.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14.0),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(14.0),
            child: FadeInImage.assetNetwork(
                image: imageUrl.isNotEmpty
                    ? imageUrl
                    : 'https://via.placeholder.com/96',
                placeholder:
                    'lib/assets/images/event/event_banner_placeholder.png',
                fit: BoxFit.cover,
                imageErrorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    'lib/assets/images/event/event_banner_placeholder.png',
                    fit: BoxFit.cover,
                  );
                }),
          ),
        ),
        // days left
        Positioned(
          bottom: 0,
          child: Container(
            height: 24.0,
            width: 96.0,
            decoration: BoxDecoration(
              color: AppColours.black.withAlpha(190),
              borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(14.0),
                bottomLeft: Radius.circular(14.0),
              ),
            ),
            child: Center(
              child: Text(
                '$daysLeft days left',
                style: AppTheme.simpleBodyText.copyWith(
                  color: AppColours.white,
                  fontSize: 12.0,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
