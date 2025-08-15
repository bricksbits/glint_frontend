import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:glint_frontend/design/components/admin/super_admin_event_preview_card.dart';
import 'package:glint_frontend/design/exports.dart';
import 'package:glint_frontend/domain/business_logic/models/admin/event_list_domain_model.dart';
import 'package:glint_frontend/domain/business_logic/models/event/event_list_domain_model.dart';
import 'package:glint_frontend/features/admin/bloc/super_admin_dashboard/super_admin_dashboard_bloc.dart';

class SuperAdminDashboardScreen extends StatefulWidget {
  const SuperAdminDashboardScreen({super.key});

  @override
  State<SuperAdminDashboardScreen> createState() =>
      _SuperAdminDashboardScreenState();
}

class _SuperAdminDashboardScreenState extends State<SuperAdminDashboardScreen> {
  int requestEventsCount = 12;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SuperAdminDashboardBloc(),
      child: Scaffold(
        backgroundColor: AppColours.white,
        appBar: const GlintEventAuthAppbar(
          hasAdminActions: true,
        ),
        body: BlocBuilder<SuperAdminDashboardBloc, SuperAdminDashboardState>(
          builder: (context, state) {
            return CustomScrollView(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
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
                                context.read<SuperAdminDashboardBloc>().add(
                                    const SuperAdminDashboardEvent
                                        .selectLive());
                              },
                              selected:
                                  state.currentTab == EventDisplayType.live,
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
                                context.read<SuperAdminDashboardBloc>().add(
                                    const SuperAdminDashboardEvent
                                        .selectRequests());
                              },
                              selected: state.currentTab ==
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
                ),
                const SliverToBoxAdapter(
                  child: Column(
                    children: [
                      Gap(16.0),
                      Divider(
                        thickness: 0.6,
                        color: AppColours.mediumGray,
                      ),
                      Gap(24.0),
                    ],
                  ),
                ),
                SliverList(
                  delegate: SliverChildListDelegate(state.currentSelectedList
                      .map((item) => Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 12.0),
                            child: SuperAdminEventPreviewCard(
                              eventDisplayType: state.currentTab,
                              onAcceptEvent: () {
                                context.read<SuperAdminDashboardBloc>().add(
                                      SuperAdminDashboardEvent.approveEvent(
                                        item.eventId,
                                      ),
                                    );
                              },
                              onRejectEvent: () {
                                context.read<SuperAdminDashboardBloc>().add(
                                      SuperAdminDashboardEvent.rejectEvent(
                                        item.eventId,
                                      ),
                                    );
                              },
                              eventName: item.eventName,
                              eventDate: item.eventDate,
                              eventOrganiser: item.eventBy,
                              eventId: item.eventId,
                            ),
                          ))
                      .toList()),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
