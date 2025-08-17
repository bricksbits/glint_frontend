import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:glint_frontend/design/common/app_colours.dart';
import 'package:glint_frontend/design/common/app_theme.dart';
import 'package:glint_frontend/design/components/exports.dart';
import 'package:glint_frontend/domain/business_logic/models/admin/pass_event_details_argument_model.dart';
import 'package:glint_frontend/navigation/glint_all_routes.dart';
import 'package:go_router/go_router.dart';

class RecentEventCard extends StatelessWidget {
  const RecentEventCard({
    super.key,
    this.isTrackEventScreen = false,
    this.eventStatus = EventStatus.live,
    this.eventName = "",
    this.eventDate = "",
    this.eventImage =
        'https://media.istockphoto.com/id/1806011581/photo/overjoyed-happy-young-people-dancing-jumping-and-singing-during-concert-of-favorite-group.jpg?s=612x612&w=0&k=20&c=cMFdhX403-yKneupEN-VWSfFdy6UWf1H0zqo6QBChP4%3D',
    this.eventLocationOrBy = "",
    required this.eventId
  });

  final bool isTrackEventScreen; // to show color for diff status
  final EventStatus eventStatus;
  final String eventName;
  final String eventDate;
  final String eventImage;
  final String eventLocationOrBy;
  final String eventId;


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

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: () {
            context.pushNamed(
              GlintAdminDasboardRoutes.trackEvent.name,
              extra: PassEventDetailsArgumentModel(
                  eventId: eventId,
                  eventTitle: eventName,
                  eventDateAndTime: eventDate,
                  eventLocation: eventLocationOrBy,
              ),
            );
          },
          child: Container(
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
                        image: DecorationImage(
                          image: NetworkImage(
                            eventImage,
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),

                    const Gap(12.0),

                    SizedBox(
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
                          const Gap(4.0),
                        ],
                      ),
                    ),
                  ],
                ),

                // event status
                const Spacer(),

                Align(
                  alignment: Alignment.topRight,
                  child: EventStatusContainer(
                    status: eventStatus,
                    isPrimaryColor: !isTrackEventScreen,
                  ),
                ),
              ],
            ),
          ),
        ),

        // if track event show stats of events
        if (isTrackEventScreen && eventStatus == EventStatus.rejected)
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
                      count: 0,
                    ),
                    const Gap(8.0),
                    _buildTrackEventStats(
                      assetPath: 'lib/assets/icons/admin/money_stats.svg',
                      label: 'Revenue Generated',
                      count: 0,
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
