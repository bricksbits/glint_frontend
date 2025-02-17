import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
    this.eventStatus = EventStatus.live,
  });

  final bool isTrackEventScreen; // to show color for diff status
  final EventStatus eventStatus;

  @override
  Widget build(BuildContext context) {
    final defaultBorder = Border.all(
      color: AppColours.mediumGray,
      width: 1.0,
    );
    const defaultBorderSide = BorderSide(
      color: AppColours.mediumGray,
      width: 1.0,
    );
    const eventName = 'The Local Food Fest';
    const eventDate = '20 Feb 2023';
    const eventImage =
        'https://media.istockphoto.com/id/1806011581/photo/overjoyed-happy-young-people-dancing-jumping-and-singing-during-concert-of-favorite-group.jpg?s=612x612&w=0&k=20&c=cMFdhX403-yKneupEN-VWSfFdy6UWf1H0zqo6QBChP4%3D';

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: double.infinity,
          margin: (isTrackEventScreen && eventStatus != EventStatus.rejected)
              ? null
              : const EdgeInsets.only(bottom: 12.0),
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 12.0,
          ).copyWith(left: 10.0),
          decoration: BoxDecoration(
            color: isTrackEventScreen
                ? AppColours.white
                : AppColours.backgroundShade,
            border: (isTrackEventScreen) ? defaultBorder : null,
            borderRadius:
                (isTrackEventScreen && eventStatus != EventStatus.rejected)
                    ? const BorderRadius.only(
                        topLeft: Radius.circular(10.0),
                        topRight: Radius.circular(10.0),
                      )
                    : BorderRadius.circular(10.0),
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
                  eventStatus,
                  !isTrackEventScreen,
                ),
              ),
            ],
          ),
        ),

        // if track event show stats of events
        if (isTrackEventScreen && eventStatus != EventStatus.rejected)
          Container(
            width: double.infinity,
            margin: const EdgeInsets.only(bottom: 16.0),
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 20.0,
            ),
            decoration: const BoxDecoration(
              color: AppColours.white,
              border: Border(
                left: defaultBorderSide,
                right: defaultBorderSide,
                bottom: defaultBorderSide,
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10.0),
                bottomRight: Radius.circular(10.0),
              ),
            ),
            child: Row(
              children: [
                // event stats
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTrackEventStats(
                      assetPath: 'lib/assets/icons/admin/users_two.svg',
                      label: 'Interested',
                      count: 986,
                    ),
                    const Gap(8.0),
                    _buildTrackEventStats(
                      assetPath: 'lib/assets/icons/admin/money_stats.svg',
                      label: 'Revenue Generated',
                      count: 8659,
                      isRevenue: true,
                    ),
                  ],
                ),
                const Spacer(),

                // navigate arrow
                Align(
                  alignment: Alignment.bottomRight,
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.arrow_forward_ios,
                      color: AppColours.primaryBlue,
                      size: 16.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
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

  Row _buildTrackEventStats({
    required String assetPath,
    required String label,
    required int count,
    bool isRevenue = false,
  }) {
    final isZero = count == 0;
    return Row(
      children: [
        SizedBox(
          height: 20.0,
          width: 20.0,
          child: SvgPicture.asset(
            assetPath,
            colorFilter: isZero
                ? null
                : const ColorFilter.mode(
                    AppColours.primaryBlue,
                    BlendMode.srcIn,
                  ),
          ),
        ),
        const Gap(12.0),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: '${isRevenue ? '₹' : ''} $count ',
                style: AppTheme.simpleBodyText.copyWith(
                  fontWeight: FontWeight.w700,
                  color: isZero ? null : AppColours.primaryBlue,
                ),
              ),
              TextSpan(
                text: label,
                style: AppTheme.simpleText.copyWith(
                  color: AppColours.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
