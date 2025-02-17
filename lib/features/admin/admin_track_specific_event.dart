import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:glint_frontend/design/exports.dart';

class AdminTrackSpecificEvent extends StatefulWidget {
  const AdminTrackSpecificEvent({super.key});

  @override
  State<AdminTrackSpecificEvent> createState() =>
      _AdminTrackSpecificEventState();
}

class _AdminTrackSpecificEventState extends State<AdminTrackSpecificEvent> {
  final GlobalKey _menuKey = GlobalKey();

  final eventName = 'The Local Food Fest';
  final eventDate = '20 Feb 2023';
  final eventImage =
      'https://media.istockphoto.com/id/1806011581/photo/overjoyed-happy-young-people-dancing-jumping-and-singing-during-concert-of-favorite-group.jpg?s=612x612&w=0&k=20&c=cMFdhX403-yKneupEN-VWSfFdy6UWf1H0zqo6QBChP4%3D';
  final eventLocation = 'Shriram business park, Raipur';
  final eventTime = '5:00 Pm';
  final interestedPeople = 895;
  final revenueGenerated = 8600;

  bool eventPaused = false;

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
            //todo - Handle navigation to preview event screen
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
            // todo - Handle end event functionality
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
              // event details
              _buildEventInfo(context),

              const Gap(36.0),

              // action buttons
              _buildEventActionButtons(context),

              const Gap(24.0),

              // event stats
              TrackEventStats(
                interestedUsers: interestedPeople,
                revenueGenerated: revenueGenerated,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEventInfo(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return SizedBox(
      width: double.infinity,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // details
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // event status
              const EventStatusContainer(
                status: EventStatus.live,
              ),

              const Gap(20.0),

              // event name
              Text(
                eventName,
                style: AppTheme.headingThree.copyWith(
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w900,
                ),
              ),

              const Gap(24.0),

              // event Location and Date
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GlintIconLabel(
                    iconPath: 'lib/assets/icons/calendar_icon.svg',
                    svgColor: AppColours.primaryBlue,
                    label: '$eventDate • $eventTime',
                    style: AppTheme.simpleText,
                  ),
                  const Gap(10.0),
                  GlintIconLabel(
                    iconPath: 'lib/assets/icons/location_icon.svg',
                    svgColor: AppColours.primaryBlue,
                    label: eventLocation,
                    style: AppTheme.simpleText,
                  ),
                ],
              ),
            ],
          ),

          const Spacer(),

          Container(
            height: 120.0,
            width: screenSize.width > 500 ? 200.0 : 100.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              image: DecorationImage(
                image: NetworkImage(eventImage),
                fit: BoxFit.cover,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildEventActionButtons(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 48.0,
            child: GlintIconElevatedButton(
              customBorderRadius: 10.0,
              backgroundColor: AppColours.white,
              customBorderSide: const BorderSide(
                color: AppColours.primaryBlue,
                width: 1.0,
              ),
              onPressed: () {
                // todo - pause event functionality
                setState(() {
                  eventPaused = true;
                });
              },
              label: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.pause,
                    size: 18.0,
                    color: AppColours.primaryBlue,
                  ),
                  const Gap(8.0),
                  Text(
                    'Pause Event',
                    style: AppTheme.simpleText.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppColours.primaryBlue,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const Gap(16.0),
        if (eventPaused)
          Expanded(
            child: SizedBox(
              height: 48.0,
              child: GlintIconElevatedButton(
                customBorderRadius: 10.0,
                backgroundColor: AppColours.primaryBlue,
                onPressed: () {
                  // todo - edit event functionality
                  setState(() {
                    eventPaused = false;
                  });
                },
                label: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.play_arrow_sharp,
                      size: 18.0,
                      color: AppColours.white,
                    ),
                    const Gap(8.0),
                    Text(
                      'Resume Event',
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
        if (!eventPaused)
          Expanded(
            child: SizedBox(
              height: 48.0,
              child: GlintIconElevatedButton(
                customBorderRadius: 10.0,
                backgroundColor: AppColours.black,
                onPressed: () {
                  // todo - edit event functionality
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
        IconButton(
          key: _menuKey,
          onPressed: () {
            final RenderBox renderBox =
                _menuKey.currentContext!.findRenderObject() as RenderBox;
            final Offset offset = renderBox.localToGlobal(Offset.zero);

            _showMenuItems(
              context,
              RelativeRect.fromLTRB(
                offset.dx,
                offset.dy + renderBox.size.height + 12,
                offset.dx + renderBox.size.width,
                offset.dy + renderBox.size.height,
              ),
            );
          },
          icon: const Icon(Icons.more_vert),
        )
      ],
    );
  }
}
