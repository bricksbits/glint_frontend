import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:glint_frontend/design/exports.dart';
import 'package:glint_frontend/domain/business_logic/models/admin/pass_event_details_argument_model.dart';
import 'package:glint_frontend/features/admin/bloc/track_specific_event/track_admin_event_cubit.dart';
import 'package:glint_frontend/navigation/glint_all_routes.dart';
import 'package:go_router/go_router.dart';

class InterestedPeopleWidget extends StatelessWidget {
  const InterestedPeopleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TrackAdminEventCubit, TrackAdminEventState>(
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 16.0).copyWith(
            bottom: 12.0,
          ),
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
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Text(
                  'Interested People',
                  style: AppTheme.headingFour.copyWith(
                    fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.normal,
                  ),
                ),
              ),
              const Gap(20.0),
              Container(
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: AppColours.borderGray,
                      width: 1.0,
                    ),
                  ),
                ),
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: InterestedPeopleListTiles(
                        limitCount: state.interestedUsers.length >= 5
                            ? 5
                            : state.interestedUsers.length,
                      ),
                    ),

                    // white overlay
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      height: 100,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.white.withValues(alpha: 0.2),
                              Colors.white.withValues(alpha: 0.4),
                              Colors.white.withValues(alpha: 0.8),
                              Colors.white,
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Gap(12.0),
              InkWell(
                onTap: () {
                  context.push(
                    "/${GlintAdminDasboardRoutes.interestedUsers.name}",
                    extra: PassEventDetailsArgumentModel(
                      eventId: state.eventId.toString(),
                      eventTitle: state.eventTitle,
                      eventDateAndTime: state.eventDate,
                      eventLocation: "No Location,",
                    ),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'See all interested people',
                      style: AppTheme.simpleText.copyWith(
                        color: AppColours.primaryBlue,
                      ),
                    ),
                    const Gap(4.0),
                    const Icon(
                      Icons.double_arrow_outlined,
                      color: AppColours.primaryBlue,
                      size: 12.0,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
