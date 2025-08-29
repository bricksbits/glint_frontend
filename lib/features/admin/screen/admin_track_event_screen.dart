import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:glint_frontend/design/components/admin/recent_event_card.dart';
import 'package:glint_frontend/design/exports.dart';
import 'package:glint_frontend/domain/business_logic/models/admin/event_list_domain_model.dart';
import 'package:glint_frontend/features/admin/bloc/admin_dasboard/admin_dashboard_bloc.dart';

class AdminTrackEventScreen extends StatelessWidget {
  const AdminTrackEventScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdminDashboardBloc, AdminDashboardState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColours.white,
          appBar: const GlintEventAuthAppbar(
            hasAdminActions: true,
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28.0),
            child: ListView(
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
                state.allPublishedEvents.isNotEmpty
                    ? ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: state.allPublishedEvents.length,
                        itemBuilder: (context, index) {
                          var item = state.allPublishedEvents.elementAt(index);
                          return RecentEventCard(
                            eventId: item.eventId,
                            isTrackEventScreen: true,
                            eventStatus: convertToEventStatus(item.eventState),
                            eventDate: item.eventDate,
                            eventName: item.eventName,
                            eventLocationOrBy: item.eventBy,
                          );
                        },
                      )
                    : const SizedBox(),
              ],
            ),
          ),
        );
      },
    );
  }
}
