import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:glint_frontend/design/components/admin/super_admin_event_preview_card.dart';
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
                    'Hello Admin!',
                    style: AppTheme.headingTwo.copyWith(
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
                    ...[
                    _buildCreateEventContainer(),
                    const Gap(16.0),
                  ],

                  // events list preview
                  SuperAdminEventPreviewCard(
                    eventDisplayType: _selectedEventDisplayType,
                  ),
                ],
              ),
            ),
          ],
        ),
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
