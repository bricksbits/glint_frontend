import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:glint_frontend/design/exports.dart';
import 'package:glint_frontend/domain/business_logic/models/event/event_list_domain_model.dart';

class NearbyEventCard extends StatelessWidget {
  const NearbyEventCard({
    super.key,
    required this.eventModel,
  });

  final EventListDomainModel eventModel;

  @override
  Widget build(BuildContext context) {
    return Container(
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
              )
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
            image: DecorationImage(
              image: NetworkImage(imageUrl),
              fit: BoxFit.cover,
            ),
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
