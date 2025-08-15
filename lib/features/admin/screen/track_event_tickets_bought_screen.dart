import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:glint_frontend/design/exports.dart';
import 'package:glint_frontend/features/admin/bloc/track_specific_event/track_admin_event_cubit.dart';

class TrackEventTicketsBoughtScreen extends StatelessWidget {
  final String eventId;
  final String eventTitle;
  final String eventDateAndTime;
  final String eventLocation;

  const TrackEventTicketsBoughtScreen({
    super.key,
    required this.eventId,
    required this.eventTitle,
    required this.eventDateAndTime,
    required this.eventLocation,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TrackAdminEventCubit, TrackAdminEventState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColours.white,
          appBar: const GlintEventAuthAppbar(
            hasAdminActions: true,
          ),
          body: Column(
            children: [
              const Gap(32.0),

              // event info
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28.0),
                child: EventInfoImageContainer(
                  eventName: eventTitle,
                  eventDate: eventDateAndTime,
                  eventLocation: eventLocation,
                  eventTime: '',
                ),
              ),

              const Gap(28.0),

              // interested people count
              Container(
                width: double.infinity,
                height: 72.0,
                padding: const EdgeInsets.symmetric(horizontal: 28.0)
                    .copyWith(right: 8.0),
                decoration: const BoxDecoration(
                  color: AppColours.backgroundShade,
                ),
                child: Row(
                  children: [
                    // icon
                    SizedBox.square(
                      dimension: 20.0,
                      child: SvgPicture.asset(
                        'lib/assets/icons/admin/money_stats.svg',
                      ),
                    ),

                    // divider
                    const Gap(16.0),

                    const SizedBox(
                      height: double.infinity,
                      child: VerticalDivider(
                        thickness: 2.0,
                        color: AppColours.white,
                      ),
                    ),

                    const Gap(16.0),

                    // revenue generated
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '₹ ${state.revenueGenerated}',
                          style: AppTheme.heavyBodyText.copyWith(
                            fontWeight: FontWeight.w500,
                            color: AppColours.primaryBlue,
                            fontSize: 20.0,
                          ),
                        ),
                        const Text(
                          'Revenue generated',
                          style: AppTheme.simpleText,
                        ),
                      ],
                    ),

                    // divider
                    const Gap(16.0),

                    const SizedBox(
                      height: double.infinity,
                      child: VerticalDivider(
                        thickness: 2.0,
                        color: AppColours.white,
                      ),
                    ),

                    const Gap(16.0),

                    // tickets sold
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${state.ticketBoughtUsers.length}',
                          style: AppTheme.heavyBodyText.copyWith(
                            fontWeight: FontWeight.w500,
                            color: AppColours.primaryBlue,
                            fontSize: 20.0,
                          ),
                        ),
                        const Text(
                          'Tickets sold',
                          style: AppTheme.simpleText,
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const Gap(32.0),
              // list of people who are interested
              const Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 28.0),
                  child: TicketsBoughtListTiles(),
                ),
              ),

              const Gap(20.0) // for design replication purpose
            ],
          ),
        );
      },
    );
  }
}
