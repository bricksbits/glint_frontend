import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:glint_frontend/design/exports.dart';

class NearbyEventCard extends StatelessWidget {
  const NearbyEventCard({super.key});

  @override
  Widget build(BuildContext context) {
    const eventName = 'Taste Dubs';
    const eventDate = '20 May 2023';
    const daysLeft = 10;
    const eventLocation = 'New Delhi, India';
    const imageUrl =
        'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8cmVzdGF1cmFudHxlbnwwfHwwfHx8MA%3D%3D';

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
                eventName,
                style: AppTheme.headingThree.copyWith(
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.normal,
                ),
              ),

              const Gap(16.0),

              const GlintIconLabel(
                iconPath: 'lib/assets/icons/calendar_icon.svg',
                label: eventDate,
              ),

              const Gap(8.0),

              const GlintIconLabel(
                iconPath: 'lib/assets/icons/location_icon.svg',
                label: eventLocation,
              )
            ],
          ),

          const Spacer(),

          // Event image
          _buildImage(
            imageUrl: imageUrl,
            daysLeft: daysLeft,
          ),
        ],
      ),
    );
  }

  Widget _buildImage({
    required String imageUrl,
    required int daysLeft,
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
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
