import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:glint_frontend/design/common/custom_snackbar.dart';
import 'package:glint_frontend/design/exports.dart';
import 'package:glint_frontend/features/admin/bloc/track_specific_event/track_admin_event_cubit.dart';
import 'package:glint_frontend/navigation/argument_models.dart';
import 'package:glint_frontend/navigation/glint_all_routes.dart';
import 'package:go_router/go_router.dart';

class AdminTrackSpecificEvent extends StatefulWidget {
  final int eventId;
  final String eventTitle;
  final String eventDate;

  const AdminTrackSpecificEvent({
    super.key,
    required this.eventId,
    required this.eventTitle,
    required this.eventDate,
  });

  @override
  State<AdminTrackSpecificEvent> createState() =>
      _AdminTrackSpecificEventState();
}

class _AdminTrackSpecificEventState extends State<AdminTrackSpecificEvent> {
  @override
  void initState() {
    context.read<TrackAdminEventCubit>().collectTheArguments(
          widget.eventId,
          widget.eventTitle,
          widget.eventDate,
        );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TrackAdminEventCubit, TrackAdminEventState>(
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
              : SingleChildScrollView(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 28.0).copyWith(
                      bottom: 20.0,
                    ),
                    child: Column(
                      children: [
                        const Gap(32.0),
                        EventInfoImageContainer(
                          eventName: state.eventTitle.isEmpty
                              ? widget.eventTitle
                              : state.eventTitle,
                          eventDate: state.eventDate.isEmpty
                              ? widget.eventDate
                              : state.eventDate,
                          eventLocation: state.eventLocation,
                          eventTime: "",
                          eventImageUrl: state.eventImageUrl,
                          status: EventStatus.live,
                        ),
                        const Gap(28.0),
                        _EventActionRow(
                          isPaused: state.isPaused,
                          isTogglingPause: state.isTogglingPause,
                          onPauseToggle: () => _handlePauseToggle(context),
                          onEdit: () => _openEditFlow(context),
                        ),
                        const Gap(24.0),
                        TrackEventStats(
                          interestedUsers:
                              int.tryParse(state.interestedUserCount) ?? 0,
                          revenueGenerated:
                              int.tryParse(state.revenueGenerated) ?? 0,
                        ),
                        const Gap(20.0),
                        const InterestedPeopleWidget(),
                        const Gap(20.0),
                        const TicketsBoughtWidget(),
                        const Gap(32.0),
                      ],
                    ),
                  ),
                ),
        );
      },
    );
  }

  void _openEditFlow(BuildContext context) {
    context.pushNamed(
      GlintAdminDasboardRoutes.createEvent.name,
      extra: AdminCreateEventNavArguments(
        widget.eventId,
        (_) {
          // No-op; the edit flow handles its own navigation.
        },
      ),
    );
  }

  Future<void> _handlePauseToggle(BuildContext context) async {
    final cubit = context.read<TrackAdminEventCubit>();
    final wasPaused = cubit.state.isPaused;
    final messenger = ScaffoldMessenger.of(context);

    final success = await cubit.togglePauseState();
    if (!mounted) return;

    if (success) {
      final msg =
          wasPaused ? 'Event resumed successfully' : 'Event paused successfully';
      showCustomSnackbar(context, message: msg);
    } else {
      // Use the captured messenger in case the widget tree changed mid-await.
      messenger.hideCurrentSnackBar();
      showCustomSnackbar(
        context,
        message: 'Could not update event state. Please try again.',
        isError: true,
      );
    }
  }
}

class _EventActionRow extends StatelessWidget {
  const _EventActionRow({
    required this.isPaused,
    required this.isTogglingPause,
    required this.onPauseToggle,
    required this.onEdit,
  });

  final bool isPaused;
  final bool isTogglingPause;
  final VoidCallback onPauseToggle;
  final VoidCallback onEdit;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 48.0,
            child: GlintIconElevatedButton(
              customBorderRadius: 10.0,
              backgroundColor: AppColours.white,
              foregroundColor: AppColours.primaryBlue,
              customBorderSide: const BorderSide(
                color: AppColours.primaryBlue,
                width: 1.2,
              ),
              onPressed: isTogglingPause ? null : onPauseToggle,
              label: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (isTogglingPause)
                    const SizedBox(
                      width: 16.0,
                      height: 16.0,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.0,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          AppColours.primaryBlue,
                        ),
                      ),
                    )
                  else
                    Icon(
                      isPaused ? Icons.play_arrow : Icons.pause,
                      size: 18.0,
                      color: AppColours.primaryBlue,
                    ),
                  const Gap(8.0),
                  Text(
                    isPaused ? 'Unpause Event' : 'Pause Event',
                    style: AppTheme.simpleText.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColours.primaryBlue,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const Gap(12.0),
        Expanded(
          child: SizedBox(
            height: 48.0,
            child: GlintIconElevatedButton(
              customBorderRadius: 10.0,
              backgroundColor: AppColours.black,
              onPressed: onEdit,
              label: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.edit,
                    size: 18.0,
                    color: AppColours.white,
                  ),
                  const Gap(8.0),
                  Text(
                    'Edit Event',
                    style: AppTheme.simpleText.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColours.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
