import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:glint_frontend/design/exports.dart';
import 'package:glint_frontend/features/admin/bloc/track_specific_event/track_admin_event_cubit.dart';
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
  final GlobalKey _menuKey = GlobalKey();
  bool eventPaused = false;

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
                        // event details
                        EventInfoImageContainer(
                          eventName: widget.eventTitle,
                          eventDate: widget.eventDate,
                          eventLocation: "--",
                          eventTime: "--,--",
                        ),

                        const Gap(36.0),

                        // action buttons
                        _buildEventActionButtons(
                          context,
                          widget.eventId,
                        ),

                        const Gap(24.0),

                        // event stats
                        TrackEventStats(
                          interestedUsers: state.interestedUsers.length,
                          revenueGenerated: int.parse(state.revenueGenerated),
                        ),

                        const Gap(20.0),

                        // interested people
                        const InterestedPeopleWidget(),

                        const Gap(20.0),

                        // tickets bought
                        const TicketsBoughtWidget(),

                        const Gap(32.0), // bottom spacing
                      ],
                    ),
                  ),
                ),
        );
      },
    );
  }

  void _showMenuItems(BuildContext context, RelativeRect position) {
    showMenu(
      context: context,
      position: position,
      color: AppColours.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      items: [
        PopupMenuItem(
          child: const Row(
            children: [
              Icon(Icons.remove_red_eye, size: 20),
              SizedBox(width: 12),
              Text(
                'Preview',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          onTap: () {
            context.pushNamed(GlintAdminDasboardRoutes.previewEvent.name);
          },
        ),
        PopupMenuItem(
          child: Row(
            children: [
              Icon(Icons.cancel, size: 20, color: Colors.red[400]),
              const SizedBox(width: 12),
              Text(
                'End Event',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.red[400],
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          onTap: () {
            _showEndEventDialog(context);
          },
        ),
      ],
    );
  }

  void _showEndEventDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 28.0,
              vertical: 32.0,
            ),
            decoration: BoxDecoration(
              color: AppColours.white,
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.cancel,
                  color: AppColours.red,
                  size: 24.0,
                ),
                const Gap(12.0),
                const Text(
                  "End Event?",
                  style: AppTheme.heavyBodyText,
                ),
                const Text(
                  "Are you sure you want to end this event?",
                  style: AppTheme.simpleText,
                ),
                const Gap(28.0),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: 'Ending this event will ',
                    style: AppTheme.smallBodyText,
                    children: [
                      TextSpan(
                        text: 'permanently remove it\n ',
                        style: AppTheme.smallBodyText.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const TextSpan(
                        text:
                            'from you Glint Event Screens. This can\'t be undone.',
                        style: AppTheme.smallBodyText,
                      ),
                    ],
                  ),
                ),
                const Gap(24.0),
                SizedBox(
                  width: 300,
                  height: 56.0,
                  child: GlintElevatedButton(
                    label: 'End this Event',
                    onPressed: () {
                      // todo - add end event functionality
                    },
                    customTextStyle: AppTheme.simpleBodyText.copyWith(
                      color: AppColours.white,
                    ),
                    backgroundColor: AppColours.pink,
                    customBorderRadius: 10.0,
                  ),
                ),
                SizedBox(
                  width: 300,
                  height: 56.0,
                  child: GlintElevatedButton(
                    label: 'Cancel',
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    customTextStyle: AppTheme.simpleBodyText.copyWith(
                      fontWeight: FontWeight.w400,
                    ),
                    backgroundColor: Colors.transparent,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildEventActionButtons(
    BuildContext context,
    int? eventId,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Gap(16.0),
        Expanded(
          child: SizedBox(
            height: 48.0,
            child: GlintIconElevatedButton(
              customBorderRadius: 10.0,
              backgroundColor: AppColours.black,
              onPressed: () {
                context.pushNamed(
                  GlintAdminDasboardRoutes.createEvent.name,
                  extra: eventId,
                );
              },
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
        const Gap(16.0),
        // IconButton(
        //   key: _menuKey,
        //   onPressed: () {
        //     final RenderBox renderBox =
        //         _menuKey.currentContext!.findRenderObject() as RenderBox;
        //     final Offset offset = renderBox.localToGlobal(Offset.zero);
        //
        //     _showMenuItems(
        //       context,
        //       RelativeRect.fromLTRB(
        //         offset.dx,
        //         offset.dy + renderBox.size.height + 12,
        //         offset.dx + renderBox.size.width,
        //         offset.dy + renderBox.size.height,
        //       ),
        //     );
        //   },
        //   icon: const Icon(Icons.more_vert),
        // )
      ],
    );
  }
}
