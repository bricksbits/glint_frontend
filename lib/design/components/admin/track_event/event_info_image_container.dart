import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:glint_frontend/design/exports.dart';

class EventInfoImageContainer extends StatelessWidget {
  const EventInfoImageContainer({super.key});

  @override
  Widget build(BuildContext context) {
    const eventName = 'The Local Food Fest';
    const eventDate = '20 Feb 2023';
    const eventImage =
        'https://media.istockphoto.com/id/1806011581/photo/overjoyed-happy-young-people-dancing-jumping-and-singing-during-concert-of-favorite-group.jpg?s=612x612&w=0&k=20&c=cMFdhX403-yKneupEN-VWSfFdy6UWf1H0zqo6QBChP4%3D';
    const eventLocation = 'Shriram business park, Raipur';
    const eventTime = '5:00 Pm';

    final screenSize = MediaQuery.of(context).size;
    return SizedBox(
      width: double.infinity,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // details
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // event status
              const EventStatusContainer(
                status: EventStatus.live,
              ),

              const Gap(20.0),

              // event name
              Text(
                eventName,
                style: AppTheme.headingThree.copyWith(
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w900,
                ),
              ),

              const Gap(24.0),

              // event Location and Date
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GlintIconLabel(
                    iconPath: 'lib/assets/icons/calendar_icon.svg',
                    svgColor: AppColours.primaryBlue,
                    label: '$eventDate • $eventTime',
                    style: AppTheme.simpleText,
                  ),
                  Gap(10.0),
                  GlintIconLabel(
                    iconPath: 'lib/assets/icons/location_icon.svg',
                    svgColor: AppColours.primaryBlue,
                    label: eventLocation,
                    style: AppTheme.simpleText,
                  ),
                ],
              ),
            ],
          ),

          const Gap(12.0),
          const Spacer(),

          Container(
            height: 120.0,
            width: screenSize.width > 510
                ? 220.0
                : screenSize.width < 410
                    ? 80.0
                    : 120.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              image: const DecorationImage(
                image: NetworkImage(eventImage),
                fit: BoxFit.cover,
              ),
            ),
          )
        ],
      ),
    );
  }
}
