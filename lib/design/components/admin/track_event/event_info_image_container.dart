import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:glint_frontend/design/exports.dart';

class EventInfoImageContainer extends StatelessWidget {
  const EventInfoImageContainer({
    super.key,
    required this.eventName,
    required this.eventDate,
    required this.eventLocation,
    required this.eventTime,
    this.eventImageUrl = "",
    this.status = EventStatus.live,
  });

  final String eventName;
  final String eventDate;
  final String eventLocation;
  final String eventTime;
  final String eventImageUrl;
  final EventStatus status;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final dateLabel =
        eventTime.isEmpty ? eventDate : '$eventDate • $eventTime';
    return SizedBox(
      width: double.infinity,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                EventStatusContainer(status: status),
                const Gap(20.0),
                Text(
                  eventName,
                  style: AppTheme.headingThree.copyWith(
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const Gap(24.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GlintIconLabel(
                      iconPath: 'lib/assets/icons/calendar_icon.svg',
                      svgColor: AppColours.primaryBlue,
                      label: dateLabel,
                      style: AppTheme.simpleText,
                    ),
                    const Gap(10.0),
                    GlintIconLabel(
                      iconPath: 'lib/assets/icons/location_icon.svg',
                      svgColor: AppColours.primaryBlue,
                      label: eventLocation.isEmpty ? '--' : eventLocation,
                      style: AppTheme.simpleText,
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Gap(12.0),
          Container(
            height: 120.0,
            width: screenSize.width > 510
                ? 220.0
                : screenSize.width < 410
                    ? 80.0
                    : 120.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              color: AppColours.backgroundShade,
              image: eventImageUrl.isNotEmpty
                  ? DecorationImage(
                      image: NetworkImage(eventImageUrl),
                      fit: BoxFit.cover,
                    )
                  : null,
            ),
          )
        ],
      ),
    );
  }
}
