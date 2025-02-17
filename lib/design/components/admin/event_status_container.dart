import 'package:flutter/material.dart';
import 'package:glint_frontend/design/exports.dart';

enum EventStatus {
  live(color: AppColours.liveColor),
  inApproval(color: AppColours.inApprovalColor),
  rejected(color: AppColours.rejectedColor),
  pastEvent(color: AppColours.pastEventColor);

  final Color color;

  const EventStatus({required this.color});

  String get statusName {
    switch (this) {
      case EventStatus.live:
        return 'LIVE';
      case EventStatus.inApproval:
        return 'IN APPROVAL';
      case EventStatus.rejected:
        return 'REJECTED';
      case EventStatus.pastEvent:
        return 'PAST EVENT';
    }
  }
}

class EventStatusContainer extends StatelessWidget {
  const EventStatusContainer({
    super.key,
    required this.status,
    this.isPrimaryColor = false,
  });

  final EventStatus status;
  final bool isPrimaryColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
      decoration: BoxDecoration(
        color: isPrimaryColor ? AppColours.primaryBlue : status.color,
        borderRadius: BorderRadius.circular(40.0),
      ),
      child: Text(
        status.statusName,
        style: AppTheme.smallBodyText.copyWith(
          color: AppColours.white,
          fontSize: 10.0,
        ),
      ),
    );
  }
}
