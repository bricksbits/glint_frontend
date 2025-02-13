import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:glint_frontend/design/common/app_colours.dart';
import 'package:glint_frontend/design/common/app_theme.dart';
import 'package:glint_frontend/design/components/exports.dart';

enum EventStatus {
  live(color: AppColours.liveColor),
  inApproval(color: AppColours.inApprovalColor),
  rejected(color: AppColours.rejectedColor),
  pastEvent(color: AppColours.pastEventColor);

  final Color color;

  const EventStatus({required this.color});

  String get statusName {
    switch (this) {
      case EventStatus.live:
        return 'LIVE';
      case EventStatus.inApproval:
        return 'IN APPROVAL';
      case EventStatus.rejected:
        return 'REJECTED';
      case EventStatus.pastEvent:
        return 'PAST EVENT';
    }
  }
}

class RecentEventCard extends StatelessWidget {
  const RecentEventCard({
    super.key,
    this.isTrackEventScreen = false,
  });

  final bool isTrackEventScreen; // to show color for diff status

  @override
  Widget build(BuildContext context) {
    const eventName = 'The Local Food Fest';
    const eventDate = '20 Feb 2023';
    const eventImage =
        'https://media.istockphoto.com/id/1806011581/photo/overjoyed-happy-young-people-dancing-jumping-and-singing-during-concert-of-favorite-group.jpg?s=612x612&w=0&k=20&c=cMFdhX403-yKneupEN-VWSfFdy6UWf1H0zqo6QBChP4%3D';

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12.0),
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 12.0,
      ).copyWith(left: 10.0),
      decoration: BoxDecoration(
        color: AppColours.backgroundShade,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // image and details.
          Row(
            children: [
              // event image
              Container(
                width: 80.0,
                height: 64.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  image: const DecorationImage(
                    image: NetworkImage(
                      eventImage,
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              const Gap(12.0),

              const SizedBox(
                height: 64.0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      eventName,
                      overflow: TextOverflow.clip,
                      style: AppTheme.simpleBodyText,
                    ),
                    GlintIconLabel(
                      iconPath: 'lib/assets/icons/calendar_icon.svg',
                      label: eventDate,
                      style: AppTheme.smallBodyText,
                    ),
                    Gap(4.0),
                  ],
                ),
              ),
            ],
          ),

          // event status
          const Spacer(),

          Align(
            alignment: Alignment.topRight,
            child: eventStatusContainer(
              EventStatus.live,
              !isTrackEventScreen,
            ),
          ),
        ],
      ),
    );
  }

  Widget eventStatusContainer(EventStatus status, bool isPrimaryColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
      decoration: BoxDecoration(
        color: isPrimaryColor ? AppColours.primaryBlue : status.color,
        borderRadius: BorderRadius.circular(40.0),
      ),
      child: Text(
        status.statusName,
        style: AppTheme.smallBodyText.copyWith(
          color: AppColours.white,
          fontSize: 10.0,
        ),
      ),
    );
  }
}
