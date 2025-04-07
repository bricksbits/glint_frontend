import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:glint_frontend/design/exports.dart';
import 'package:glint_frontend/navigation/glint_all_routes.dart';
import 'package:go_router/go_router.dart';
import 'package:glint_frontend/features/admin/screen/exports.dart';

class SuperAdminEventPreviewCard extends StatelessWidget {
  const SuperAdminEventPreviewCard({
    super.key,
    required this.eventDisplayType,
  });

  final EventDisplayType eventDisplayType;

  @override
  Widget build(BuildContext context) {
    const eventName = 'The Local Food Fest';
    const eventDate = '20 Feb 2023';
    const eventImage =
        'https://media.istockphoto.com/id/1806011581/photo/overjoyed-happy-young-people-dancing-jumping-and-singing-during-concert-of-favorite-group.jpg?s=612x612&w=0&k=20&c=cMFdhX403-yKneupEN-VWSfFdy6UWf1H0zqo6QBChP4%3D';
    const eventOrganiser = 'Invisible Studios';

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10.0),
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      decoration: BoxDecoration(
        color: AppColours.white,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(
          color: AppColours.borderGray,
          width: 1.0,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
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

                // redirect to specific event screen
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    onPressed: () {
                      context.go(
                        "/${GlintAdminDasboardRoutes.trackEvent.name}"
                      );
                    },
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

          // divider
          const Gap(4.0),

          const Divider(thickness: 0.7, color: AppColours.mediumGray),

          const Gap(4.0),

          // event by

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: RichText(
              text: TextSpan(
                children: [
                  const TextSpan(
                    text: 'Event by ',
                    style: AppTheme.simpleText,
                  ),
                  TextSpan(
                    text: eventOrganiser,
                    style: AppTheme.simpleText.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ),

          if (eventDisplayType == EventDisplayType.requested) ...[
            // divider
            const Gap(4.0),

            const Divider(thickness: 0.7, color: AppColours.mediumGray),

            const Gap(10.0),

            // accept or reject
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Expanded(
                    child: GlintElevatedButton(
                      label: 'Accept',
                      customBorderRadius: 10.0,
                      customTextStyle: AppTheme.simpleText.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppColours.white,
                      ),
                      onPressed: () {
                        // todo - implement super admin accept functionality
                      },
                    ),
                  ),
                  const Gap(24.0),
                  Expanded(
                    child: GlintElevatedButton(
                      label: 'Reject',
                      customBorderRadius: 10.0,
                      backgroundColor: AppColours.white,
                      customBorderSide: const BorderSide(
                        color: AppColours.rejectedColor,
                        width: 1.0,
                      ),
                      customTextStyle: AppTheme.simpleText.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppColours.rejectedColor,
                      ),
                      onPressed: () {
                        // todo - implement super admin reject functionality
                      },
                    ),
                  ),
                ],
              ),
            ),

            const Gap(6.0), // for design replication
          ]
        ],
      ),
    );
  }
}
