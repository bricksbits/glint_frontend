/// Notification type values sent by the server in the FCM data payload.
enum GlintNotificationType {
  match,
  superLike,
  matchStory,
  storyLike,
  newEvent,
  eventApproved,
  eventRejected,
  ticketConfirmed,
  ticketBookedByPartner,
  ticketCancelled,
  refundProcessed,
  eventReminder,
  membershipExpiryReminder,
  unknown;

  static GlintNotificationType fromString(String? type) {
    switch (type) {
      case 'match':
        return GlintNotificationType.match;
      case 'super_like':
        return GlintNotificationType.superLike;
      case 'match_story':
        return GlintNotificationType.matchStory;
      case 'story_like':
        return GlintNotificationType.storyLike;
      case 'new_event':
        return GlintNotificationType.newEvent;
      case 'event_approved':
        return GlintNotificationType.eventApproved;
      case 'event_rejected':
        return GlintNotificationType.eventRejected;
      case 'ticket_confirmed':
        return GlintNotificationType.ticketConfirmed;
      case 'ticket_booked_by_partner':
        return GlintNotificationType.ticketBookedByPartner;
      case 'ticket_cancelled':
        return GlintNotificationType.ticketCancelled;
      case 'refund_processed':
        return GlintNotificationType.refundProcessed;
      case 'event_reminder':
        return GlintNotificationType.eventReminder;
      case 'membership_expiry_reminder':
        return GlintNotificationType.membershipExpiryReminder;
      default:
        return GlintNotificationType.unknown;
    }
  }
}

class GlintNotificationPayload {
  final GlintNotificationType type;

  // match
  final String? matchedUserId;
  final String? matchedUsername;

  // super_like, story_like
  final String? fromUserId;
  final String? fromUsername;

  // match_story
  final String? userId;
  final String? username;

  // event-related (new_event, event_approved, event_rejected, ticket_*, event_reminder)
  final String? eventId;
  final String? eventName;

  // ticket_booked_by_partner
  final String? partnerUsername;

  // refund_processed
  final String? amount;

  // membership_expiry_reminder
  final String? membershipType;

  const GlintNotificationPayload({
    required this.type,
    this.matchedUserId,
    this.matchedUsername,
    this.fromUserId,
    this.fromUsername,
    this.userId,
    this.username,
    this.eventId,
    this.eventName,
    this.partnerUsername,
    this.amount,
    this.membershipType,
  });

  factory GlintNotificationPayload.fromMap(Map<String, dynamic> data) {
    return GlintNotificationPayload(
      type: GlintNotificationType.fromString(data['notification_type'] as String?),
      matchedUserId: data['matched_user_id'] as String?,
      matchedUsername: data['matched_username'] as String?,
      fromUserId: data['from_user_id'] as String?,
      fromUsername: data['from_username'] as String?,
      userId: data['user_id'] as String?,
      username: data['username'] as String?,
      eventId: data['event_id'] as String?,
      eventName: data['event_name'] as String?,
      partnerUsername: data['partner_username'] as String?,
      amount: data['amount'] as String?,
      membershipType: data['membership_type'] as String?,
    );
  }
}
