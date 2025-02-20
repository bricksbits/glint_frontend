import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:glint_frontend/design/components/admin/recent_event_card.dart';
import 'package:glint_frontend/design/exports.dart';

class AdminTrackEventScreen extends StatelessWidget {
  const AdminTrackEventScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColours.white,
      appBar: const GlintEventAuthAppbar(
        hasAdminActions: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28.0),
          child: Column(
            children: [
              const Gap(32.0),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Recent Events',
                  style: AppTheme.headingThree.copyWith(
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
              const Gap(24.0),

              // recent event cards
              const RecentEventCard(
                isTrackEventScreen: true,
                eventStatus: EventStatus.live,
              ),
              const RecentEventCard(
                isTrackEventScreen: true,
                eventStatus: EventStatus.inApproval,
              ),
              const RecentEventCard(
                isTrackEventScreen: true,
                eventStatus: EventStatus.rejected,
              ),
              const RecentEventCard(
                isTrackEventScreen: true,
                eventStatus: EventStatus.rejected,
              ),
              const RecentEventCard(
                isTrackEventScreen: true,
                eventStatus: EventStatus.pastEvent,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
