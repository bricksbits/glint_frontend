import 'package:go_router/go_router.dart';
import 'package:glint_frontend/navigation/glint_all_routes.dart';
import 'package:glint_frontend/notifications/models/notification_payload.dart';

/// Handles navigation in response to a notification tap.
/// Works across all 3 app states (foreground, background, terminated)
/// by using the [rootNavigatorKey] from the router configuration.
class NotificationHandler {
  NotificationHandler._();

  /// Entry point — called with the FCM data map when a notification is tapped.
  static void handleNavigation(Map<String, dynamic> data) {
    final context = rootNavigatorKey.currentContext;
    if (context == null) return;

    final payload = GlintNotificationPayload.fromMap(data);

    switch (payload.type) {
      case GlintNotificationType.match:
        context.goNamed(GlintMainRoutes.chat.name);

      case GlintNotificationType.superLike:
        context.goNamed(GlintMainRoutes.likes.name);

      case GlintNotificationType.matchStory:
        context.goNamed(GlintMainRoutes.chat.name);

      case GlintNotificationType.storyLike:
        context.goNamed(GlintMainRoutes.notifications.name);

      case GlintNotificationType.newEvent:
        context.goNamed(GlintMainRoutes.event.name);

      case GlintNotificationType.eventApproved:
        context.goNamed(GlintAdminDasboardRoutes.adminHome.name);

      case GlintNotificationType.eventRejected:
        // Just open the app — bring user to home.
        context.goNamed(GlintAdminDasboardRoutes.adminHome.name);

      case GlintNotificationType.ticketConfirmed:
      case GlintNotificationType.ticketBookedByPartner:
      case GlintNotificationType.ticketCancelled:
      case GlintNotificationType.refundProcessed:
      case GlintNotificationType.eventReminder:
        context.goNamed(GlintEventRoutes.tickets.name);

      case GlintNotificationType.membershipExpiryReminder:
        context.goNamed(GlintMainRoutes.profile.name);

      case GlintNotificationType.unknown:
        break;
    }
  }
}
