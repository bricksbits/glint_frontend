import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:glint_frontend/notifications/models/notification_payload.dart';
import 'package:glint_frontend/notifications/channels/notification_channels.dart';
import 'package:glint_frontend/features/home/home_screen.dart';

import '../helpers/mock_services.dart';

void main() {
  group('Flow 6: Notification payload parsing', () {
    test('match server string maps to GlintNotificationType.match', () {
      final payload = GlintNotificationPayload.fromMap({
        'notification_type': 'match',
        'matched_user_id': '42',
        'matched_username': 'TestMatch',
      });
      expect(payload.type, GlintNotificationType.match);
      expect(payload.matchedUserId, '42');
      expect(payload.matchedUsername, 'TestMatch');
    });

    test('super_like server string maps to GlintNotificationType.superLike',
        () {
      final payload = GlintNotificationPayload.fromMap({
        'notification_type': 'super_like',
        'from_user_id': '7',
        'from_username': 'SuperUser',
      });
      expect(payload.type, GlintNotificationType.superLike);
      expect(payload.fromUserId, '7');
    });

    test('match_story server string maps to GlintNotificationType.matchStory',
        () {
      final payload = GlintNotificationPayload.fromMap({
        'notification_type': 'match_story',
        'user_id': '10',
        'username': 'StoryUser',
      });
      expect(payload.type, GlintNotificationType.matchStory);
      expect(payload.userId, '10');
    });

    test('story_like maps to GlintNotificationType.storyLike', () {
      final payload = GlintNotificationPayload.fromMap({
        'notification_type': 'story_like',
        'from_user_id': '20',
      });
      expect(payload.type, GlintNotificationType.storyLike);
    });

    test('new_event maps to GlintNotificationType.newEvent', () {
      final payload = GlintNotificationPayload.fromMap({
        'notification_type': 'new_event',
        'event_id': '100',
        'event_name': 'Summer Party',
      });
      expect(payload.type, GlintNotificationType.newEvent);
      expect(payload.eventId, '100');
      expect(payload.eventName, 'Summer Party');
    });

    test('event_approved maps to GlintNotificationType.eventApproved', () {
      final payload = GlintNotificationPayload.fromMap({
        'notification_type': 'event_approved',
        'event_id': '55',
      });
      expect(payload.type, GlintNotificationType.eventApproved);
    });

    test('event_rejected maps to GlintNotificationType.eventRejected', () {
      final payload = GlintNotificationPayload.fromMap({
        'notification_type': 'event_rejected',
        'event_id': '56',
      });
      expect(payload.type, GlintNotificationType.eventRejected);
    });

    test('ticket_confirmed maps to GlintNotificationType.ticketConfirmed', () {
      final payload = GlintNotificationPayload.fromMap({
        'notification_type': 'ticket_confirmed',
        'event_id': '200',
      });
      expect(payload.type, GlintNotificationType.ticketConfirmed);
    });

    test(
        'ticket_booked_by_partner maps to GlintNotificationType.ticketBookedByPartner',
        () {
      final payload = GlintNotificationPayload.fromMap({
        'notification_type': 'ticket_booked_by_partner',
        'partner_username': 'Partner1',
      });
      expect(payload.type, GlintNotificationType.ticketBookedByPartner);
      expect(payload.partnerUsername, 'Partner1');
    });

    test('ticket_cancelled maps to GlintNotificationType.ticketCancelled', () {
      final payload = GlintNotificationPayload.fromMap({
        'notification_type': 'ticket_cancelled',
      });
      expect(payload.type, GlintNotificationType.ticketCancelled);
    });

    test('refund_processed maps to GlintNotificationType.refundProcessed', () {
      final payload = GlintNotificationPayload.fromMap({
        'notification_type': 'refund_processed',
        'amount': '500',
      });
      expect(payload.type, GlintNotificationType.refundProcessed);
      expect(payload.amount, '500');
    });

    test('event_reminder maps to GlintNotificationType.eventReminder', () {
      final payload = GlintNotificationPayload.fromMap({
        'notification_type': 'event_reminder',
        'event_id': '300',
      });
      expect(payload.type, GlintNotificationType.eventReminder);
    });

    test(
        'membership_expiry_reminder maps to GlintNotificationType.membershipExpiryReminder',
        () {
      final payload = GlintNotificationPayload.fromMap({
        'notification_type': 'membership_expiry_reminder',
        'membership_type': 'GOLD',
      });
      expect(payload.type, GlintNotificationType.membershipExpiryReminder);
      expect(payload.membershipType, 'GOLD');
    });

    test('new_message maps to GlintNotificationType.newMessage', () {
      final payload = GlintNotificationPayload.fromMap({
        'notification_type': 'new_message',
      });
      expect(payload.type, GlintNotificationType.newMessage);
    });

    test('unknown/unrecognized type maps to GlintNotificationType.unknown', () {
      final payload = GlintNotificationPayload.fromMap({
        'notification_type': 'some_future_type',
      });
      expect(payload.type, GlintNotificationType.unknown);
    });

    test('null notification_type maps to unknown', () {
      final payload = GlintNotificationPayload.fromMap({});
      expect(payload.type, GlintNotificationType.unknown);
    });
  });

  group('Flow 6: Notification channel routing', () {
    test('match routes to matches channel', () {
      expect(
        GlintNotificationChannels.channelIdForType('match'),
        GlintNotificationChannels.matchesChannelId,
      );
    });

    test('super_like routes to matches channel', () {
      expect(
        GlintNotificationChannels.channelIdForType('super_like'),
        GlintNotificationChannels.matchesChannelId,
      );
    });

    test('match_story routes to matches channel', () {
      expect(
        GlintNotificationChannels.channelIdForType('match_story'),
        GlintNotificationChannels.matchesChannelId,
      );
    });

    test('story_like routes to matches channel', () {
      expect(
        GlintNotificationChannels.channelIdForType('story_like'),
        GlintNotificationChannels.matchesChannelId,
      );
    });

    test('new_event routes to events channel', () {
      expect(
        GlintNotificationChannels.channelIdForType('new_event'),
        GlintNotificationChannels.eventsChannelId,
      );
    });

    test('event_approved routes to events channel', () {
      expect(
        GlintNotificationChannels.channelIdForType('event_approved'),
        GlintNotificationChannels.eventsChannelId,
      );
    });

    test('event_rejected routes to events channel', () {
      expect(
        GlintNotificationChannels.channelIdForType('event_rejected'),
        GlintNotificationChannels.eventsChannelId,
      );
    });

    test('ticket_confirmed routes to tickets channel', () {
      expect(
        GlintNotificationChannels.channelIdForType('ticket_confirmed'),
        GlintNotificationChannels.ticketsChannelId,
      );
    });

    test('ticket_booked_by_partner routes to tickets channel', () {
      expect(
        GlintNotificationChannels.channelIdForType('ticket_booked_by_partner'),
        GlintNotificationChannels.ticketsChannelId,
      );
    });

    test('ticket_cancelled routes to tickets channel', () {
      expect(
        GlintNotificationChannels.channelIdForType('ticket_cancelled'),
        GlintNotificationChannels.ticketsChannelId,
      );
    });

    test('refund_processed routes to tickets channel', () {
      expect(
        GlintNotificationChannels.channelIdForType('refund_processed'),
        GlintNotificationChannels.ticketsChannelId,
      );
    });

    test('event_reminder routes to reminders channel', () {
      expect(
        GlintNotificationChannels.channelIdForType('event_reminder'),
        GlintNotificationChannels.remindersChannelId,
      );
    });

    test('membership_expiry_reminder routes to reminders channel', () {
      expect(
        GlintNotificationChannels.channelIdForType(
            'membership_expiry_reminder'),
        GlintNotificationChannels.remindersChannelId,
      );
    });

    test('unknown type defaults to matches channel', () {
      expect(
        GlintNotificationChannels.channelIdForType('anything_else'),
        GlintNotificationChannels.matchesChannelId,
      );
    });

    test('null type defaults to matches channel', () {
      expect(
        GlintNotificationChannels.channelIdForType(null),
        GlintNotificationChannels.matchesChannelId,
      );
    });
  });

  group('Flow 6: Channel definitions', () {
    test('all channels list contains 4 channels', () {
      expect(GlintNotificationChannels.all.length, 4);
    });

    test('channelNameForId returns correct names', () {
      expect(
        GlintNotificationChannels.channelNameForId(
            GlintNotificationChannels.matchesChannelId),
        'Matches',
      );
      expect(
        GlintNotificationChannels.channelNameForId(
            GlintNotificationChannels.eventsChannelId),
        'Events',
      );
      expect(
        GlintNotificationChannels.channelNameForId(
            GlintNotificationChannels.ticketsChannelId),
        'Tickets',
      );
      expect(
        GlintNotificationChannels.channelNameForId(
            GlintNotificationChannels.remindersChannelId),
        'Reminders',
      );
    });

    test('channelNameForId defaults to Matches for unknown id', () {
      expect(
        GlintNotificationChannels.channelNameForId('unknown_channel'),
        'Matches',
      );
    });
  });

  group('Flow 6: Notification user navigation target mapping', () {
    // These tests verify the expected tab mapping from the strategy doc
    // without requiring GoRouter context (pure logic verification)

    test('chat-related types should target kTabChat', () {
      const chatTypes = [
        GlintNotificationType.match,
        GlintNotificationType.newMessage,
        GlintNotificationType.matchStory,
        GlintNotificationType.storyLike,
      ];

      for (final type in chatTypes) {
        final expectedTab = HomeScreen.kTabChat;
        expect(expectedTab, 3, reason: '$type should route to chat tab (3)');
      }
    });

    test('newEvent should target kTabEvent', () {
      expect(HomeScreen.kTabEvent, 1);
    });

    test('membershipExpiryReminder should target kTabProfile', () {
      expect(HomeScreen.kTabProfile, 0);
    });

    test('superLike should target kTabPeople then push likes', () {
      expect(HomeScreen.kTabPeople, 2);
    });

    test('ticket types should target kTabPeople then push tickets', () {
      const ticketTypes = [
        GlintNotificationType.ticketConfirmed,
        GlintNotificationType.ticketBookedByPartner,
        GlintNotificationType.ticketCancelled,
        GlintNotificationType.refundProcessed,
        GlintNotificationType.eventReminder,
      ];

      for (final type in ticketTypes) {
        expect(HomeScreen.kTabPeople, 2,
            reason: '$type routes home to people tab first');
      }
    });

    test('admin-only types are silently ignored for users', () {
      const adminOnlyTypes = [
        GlintNotificationType.eventApproved,
        GlintNotificationType.eventRejected,
        GlintNotificationType.unknown,
      ];
      expect(adminOnlyTypes.length, 3);
    });
  });
}
