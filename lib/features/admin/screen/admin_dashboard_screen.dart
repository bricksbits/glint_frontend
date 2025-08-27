import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:glint_frontend/design/components/admin/recent_event_card.dart';
import 'package:glint_frontend/design/exports.dart';
import 'package:glint_frontend/domain/business_logic/models/admin/event_list_domain_model.dart';
import 'package:glint_frontend/features/admin/bloc/admin_dasboard/admin_dashboard_bloc.dart';
import 'package:glint_frontend/navigation/glint_all_routes.dart';
import 'package:go_router/go_router.dart';

class AdminDashboardScreen extends StatelessWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdminDashboardBloc, AdminDashboardState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColours.white,
          appBar: const GlintEventAuthAppbar(
            hasAdminActions: true,
          ),
          body: state.isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : SizedBox(
                  width: double.infinity,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 28.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // top spacing
                              const Gap(32.0),
                              // event manager greeting
                              Text(
                                'Hello ${state.adminUserName}',
                                style: AppTheme.headingThree.copyWith(
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                              const Gap(8.0),
                              // event manager details
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SvgPicture.asset(
                                    'lib/assets/icons/organization.svg',
                                    colorFilter: const ColorFilter.mode(
                                      AppColours.primaryBlue,
                                      BlendMode.srcIn,
                                    ),
                                  ),
                                  const Gap(10.0),
                                  SizedBox(
                                    height: 22.0,
                                    child: VerticalDivider(
                                      width: 2.0,
                                      color: AppColours.gray60,
                                    ),
                                  ),
                                  const Gap(10.0),
                                  Text(
                                    state.adminOrganization,
                                    style: AppTheme.simpleBodyText.copyWith(
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),

                              const Gap(24.0),

                              // Redirect Options
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Flexible(
                                    child: _buildRedirectOption(
                                      label: 'Create Event',
                                      icon: Icons.add,
                                      onPressed: () {
                                        context.pushNamed(
                                          GlintAdminDasboardRoutes
                                              .createEvent.name,
                                        );
                                      },
                                    ),
                                  ),
                                  const Gap(24.0),
                                  Flexible(
                                    child: _buildRedirectOption(
                                      label: 'Track Event',
                                      icon: Icons.graphic_eq,
                                      onPressed: () {
                                        context.pushNamed(
                                          GlintAdminDasboardRoutes
                                              .adminPublishedEvents.name,
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        const Gap(20.0),
                        const Divider(
                          color: AppColours.backgroundShade,
                        ),
                        const Gap(20.0),

                        // recent events
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 28.0),
                          child: Column(
                            children: [
                              // heading
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
                              state.recentEvents.isNotEmpty
                                  ? ListView.builder(
                                      shrinkWrap: true,
                                      physics: const NeverScrollableScrollPhysics(),
                                      itemCount: state.recentEvents.length,
                                      itemBuilder: (context, index) {
                                        var item =
                                            state.recentEvents.elementAt(index);
                                        return RecentEventCard(
                                          eventId: item.eventId,
                                          isTrackEventScreen: false,
                                          eventStatus: convertToEventStatus(
                                              item.eventState),
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
                      ],
                    ),
                  ),
                ),
        );
      },
    );
  }

  Widget _buildRedirectOption({
    required String label,
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 210.0),
      child: Column(
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
                onPressed: onPressed,
                icon: Icon(
                  icon,
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
                label,
                style: AppTheme.simpleText.copyWith(
                  color: AppColours.white,
                  fontSize: 12.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
