import 'package:flutter_local_notifications/flutter_local_notifications.dart';

/// Defines the 4 Android notification channels for Glint, grouped by category.
/// Users can enable/disable each channel independently from system settings.
class GlintNotificationChannels {
  GlintNotificationChannels._();

  // ── Channel IDs ──────────────────────────────────────────────────────────────
  static const String matchesChannelId = 'glint_matches';
  static const String eventsChannelId = 'glint_events';
  static const String ticketsChannelId = 'glint_tickets';
  static const String remindersChannelId = 'glint_reminders';

  // ── Channel Names ─────────────────────────────────────────────────────────────
  static const String matchesChannelName = 'Matches';
  static const String eventsChannelName = 'Events';
  static const String ticketsChannelName = 'Tickets';
  static const String remindersChannelName = 'Reminders';

  // ── Channel Definitions ───────────────────────────────────────────────────────

  static AndroidNotificationChannel get matchesChannel =>
      const AndroidNotificationChannel(
        matchesChannelId,
        matchesChannelName,
        description: 'New matches, super likes, stories and story likes',
        importance: Importance.high,
      );

  static AndroidNotificationChannel get eventsChannel =>
      const AndroidNotificationChannel(
        eventsChannelId,
        eventsChannelName,
        description: 'New events near you and event approval updates',
        importance: Importance.high,
      );

  static AndroidNotificationChannel get ticketsChannel =>
      const AndroidNotificationChannel(
        ticketsChannelId,
        ticketsChannelName,
        description:
            'Ticket confirmations, bookings, cancellations and refunds',
        importance: Importance.high,
      );

  static AndroidNotificationChannel get remindersChannel =>
      const AndroidNotificationChannel(
        remindersChannelId,
        remindersChannelName,
        description: 'Event reminders and membership expiry alerts',
        importance: Importance.defaultImportance,
      );

  static List<AndroidNotificationChannel> get all => [
        matchesChannel,
        eventsChannel,
        ticketsChannel,
        remindersChannel,
      ];

  /// Maps a [notification_type] string from the server to the correct channel ID.
  static String channelIdForType(String? notificationType) {
    switch (notificationType) {
      case 'match':
      case 'super_like':
      case 'match_story':
      case 'story_like':
        return matchesChannelId;
      case 'new_event':
      case 'event_approved':
      case 'event_rejected':
        return eventsChannelId;
      case 'ticket_confirmed':
      case 'ticket_booked_by_partner':
      case 'ticket_cancelled':
      case 'refund_processed':
        return ticketsChannelId;
      case 'event_reminder':
      case 'membership_expiry_reminder':
        return remindersChannelId;
      default:
        return matchesChannelId;
    }
  }

  /// Returns the human-readable channel name for a given channel ID.
  static String channelNameForId(String channelId) {
    switch (channelId) {
      case matchesChannelId:
        return matchesChannelName;
      case eventsChannelId:
        return eventsChannelName;
      case ticketsChannelId:
        return ticketsChannelName;
      case remindersChannelId:
        return remindersChannelName;
      default:
        return matchesChannelName;
    }
  }
}
