import 'package:glint_frontend/notifications/models/notification_history_response.dart';

enum NotificationType { activity, match, reminder, event, unknown }

class NotificationGroup {
  final String label;
  final List<NotificationItem> items;

  const NotificationGroup({required this.label, required this.items});
}

class NotificationItem {
  final int id;
  final NotificationType type;
  final String title;
  final String body;
  final DateTime createdAt;
  final bool isRead;
  final Map<String, dynamic> metadata;

  const NotificationItem({
    required this.id,
    required this.type,
    required this.title,
    required this.body,
    required this.createdAt,
    required this.isRead,
    required this.metadata,
  });

  factory NotificationItem.fromHistoryItem(NotificationHistoryItem item) {
    return NotificationItem(
      id: item.id,
      type: _parseType(item.type),
      title: item.title,
      body: item.body,
      createdAt: item.createdAt,
      isRead: item.isRead,
      metadata: item.data,
    );
  }

  static NotificationType _parseType(String raw) {
    switch (raw) {
      case 'activity':
        return NotificationType.activity;
      case 'match':
      case 'super_like':
      case 'match_story':
      case 'story_like':
        return NotificationType.match;
      case 'reminder':
      case 'event_reminder':
      case 'membership_expiry_reminder':
        return NotificationType.reminder;
      case 'event':
      case 'new_event':
      case 'event_approved':
      case 'event_rejected':
      case 'ticket_confirmed':
      case 'ticket_booked_by_partner':
      case 'ticket_cancelled':
      case 'refund_processed':
        return NotificationType.event;
      default:
        return NotificationType.unknown;
    }
  }
}
