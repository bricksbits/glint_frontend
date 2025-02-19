import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:glint_frontend/design/exports.dart';

enum EventDisplayType { live, requested }

class SuperAdminDashboardScreen extends StatefulWidget {
  const SuperAdminDashboardScreen({super.key});

  @override
  State<SuperAdminDashboardScreen> createState() =>
      _SuperAdminDashboardScreenState();
}

class _SuperAdminDashboardScreenState extends State<SuperAdminDashboardScreen> {
  EventDisplayType _selectedEventDisplayType = EventDisplayType.live;

  int requestEventsCount = 12;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColours.white,
      appBar: const GlintEventAuthAppbar(
        hasAdminActions: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // greeting and event display chips
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Gap(32.0),
                  // event manager greeting
                  Text(
                    'Hello Admin',
                    style: AppTheme.headingThree.copyWith(
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  const Gap(24.0),

                  // event display chips
                  Row(
                    children: [
                      // live event chip

                      ChoiceChip(
                        onSelected: (bool? value) {
                          setState(() {
                            _selectedEventDisplayType = EventDisplayType.live;
                          });
                        },
                        selected:
                            _selectedEventDisplayType == EventDisplayType.live,
                        showCheckmark: false,
                        labelStyle: AppTheme.simpleText,
                        selectedColor: AppColours.backgroundShade,
                        backgroundColor: AppColours.white,
                        label: const Text(
                          'Live',
                          style: AppTheme.simpleText,
                        ),
                        shape: const StadiumBorder(
                          side: BorderSide(
                            color: AppColours.backgroundShade,
                            width: 1.0,
                          ),
                        ),
                      ),
                      const Gap(12.0),

                      // event requests chip
                      ChoiceChip(
                        onSelected: (bool? value) {
                          setState(() {
                            _selectedEventDisplayType =
                                EventDisplayType.requested;
                          });
                        },
                        selected: _selectedEventDisplayType ==
                            EventDisplayType.requested,
                        showCheckmark: false,
                        labelStyle: AppTheme.simpleText,
                        selectedColor: AppColours.backgroundShade,
                        backgroundColor: AppColours.white,
                        label: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              'Event Requests',
                              style: AppTheme.simpleText,
                            ),
                            const Gap(8.0),
                            CircleAvatar(
                              radius: 10.0,
                              backgroundColor: AppColours.primaryBlue,
                              child: Text(
                                requestEventsCount.toString(),
                                style: AppTheme.simpleText.copyWith(
                                  color: AppColours.white,
                                  fontSize: 12.0,
                                ),
                              ),
                            )
                          ],
                        ),
                        shape: const StadiumBorder(
                          side: BorderSide(
                            color: AppColours.backgroundShade,
                            width: 1.0,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),

            const Gap(16.0),
            // divider
            const Divider(
              thickness: 0.6,
              color: AppColours.mediumGray,
            ),

            const Gap(24.0),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (_selectedEventDisplayType == EventDisplayType.live)
                    // create event button
                    _buildCreateEventContainer(),

                  const Gap(16.0),

                  // events list preview
                  _buildSuperAdminEventPreview(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildSuperAdminEventPreview() {
    const eventName = 'The Local Food Fest';
    const eventDate = '20 Feb 2023';
    const eventImage =
        'https://media.istockphoto.com/id/1806011581/photo/overjoyed-happy-young-people-dancing-jumping-and-singing-during-concert-of-favorite-group.jpg?s=612x612&w=0&k=20&c=cMFdhX403-yKneupEN-VWSfFdy6UWf1H0zqo6QBChP4%3D';
    const eventOrganiser = 'Invisible Studios';

    return Container(
      width: double.infinity,
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
                      // todo - redirect to specific event screen
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

          if (_selectedEventDisplayType == EventDisplayType.requested) ...[
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

  Widget _buildCreateEventContainer() {
    return Column(
      children: [
        // icon container
        Container(
          padding: const EdgeInsets.symmetric(
            vertical: 24.0,
          ),
          decoration: const BoxDecoration(
            color: AppColours.backgroundShade,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.0),
              topRight: Radius.circular(10.0),
            ),
          ),
          child: Center(
            child: IconButton(
              onPressed: () {
                // todo - add create event redirect here
              },
              icon: const Icon(
                Icons.add,
                size: 32.0,
                color: AppColours.primaryBlue,
              ),
            ),
          ),
        ),

        // text container
        Container(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          decoration: const BoxDecoration(
            color: AppColours.primaryBlue,
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(10.0),
              bottomLeft: Radius.circular(10.0),
            ),
          ),
          child: Center(
            child: Text(
              'Create Event',
              style: AppTheme.simpleText.copyWith(
                color: AppColours.white,
                fontSize: 12.0,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
