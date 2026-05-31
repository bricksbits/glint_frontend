import 'package:flutter/widgets.dart';
import 'package:glint_frontend/data/local/persist/async_encrypted_shared_preference_helper.dart';
import 'package:glint_frontend/data/local/persist/shared_pref_key.dart';
import 'package:glint_frontend/di/injection.dart';
import 'package:glint_frontend/domain/application_logic/auth/is_user_logged_in_use_case.dart';
import 'package:glint_frontend/domain/business_logic/models/common/UsersType.dart';
import 'package:glint_frontend/features/home/home_screen.dart';
import 'package:glint_frontend/navigation/glint_all_routes.dart';
import 'package:glint_frontend/notifications/models/notification_payload.dart';
import 'package:go_router/go_router.dart';

class NotificationHandler {
  NotificationHandler._();

  /// Entry point — called with the FCM data map when a notification is tapped.
  /// Works across all 3 app states (foreground, background, terminated).
  static Future<void> handleNavigation(Map<String, dynamic> data) async {
    final context = rootNavigatorKey.currentContext;
    if (context == null) return;

    final payload = GlintNotificationPayload.fromMap(data);

    final userTypeStr = await getIt
        .get<AsyncEncryptedSharedPreferenceHelper>()
        .getString(SharedPreferenceKeys.userRoleKey);
    final userType = getUserTypeFromName(userTypeStr);

    switch (userType) {
      case UsersType.ADMIN:
      case UsersType.SUPER_ADMIN:
        _navigateForAdmin();
      case UsersType.USER:
        _navigateForUser(payload);
    }
  }

  // ── Admin routing ─────────────────────────────────────────────────────────

  static void _navigateForAdmin() {
    final context = rootNavigatorKey.currentContext;
    if (context == null) return;
    context.goNamed(GlintAdminDasboardRoutes.adminHome.name);
  }

  // ── User routing ──────────────────────────────────────────────────────────

  static void _navigateForUser(GlintNotificationPayload payload) {
    final context = rootNavigatorKey.currentContext;
    if (context == null) return;

    switch (payload.type) {
      case GlintNotificationType.newMessage:
      case GlintNotificationType.match:
      case GlintNotificationType.matchStory:
      case GlintNotificationType.storyLike:
        context.goNamed(
          GlintMainRoutes.home.name,
          extra: HomeScreen.kTabChat,
        );

      case GlintNotificationType.newEvent:
        context.goNamed(
          GlintMainRoutes.home.name,
          extra: HomeScreen.kTabEvent,
        );

      case GlintNotificationType.membershipExpiryReminder:
        context.goNamed(
          GlintMainRoutes.home.name,
          extra: HomeScreen.kTabProfile,
        );

      case GlintNotificationType.superLike:
        _goHomeAndPush(HomeScreen.kTabPeople, GlintMainRoutes.likes.name);

      case GlintNotificationType.ticketConfirmed:
      case GlintNotificationType.ticketBookedByPartner:
      case GlintNotificationType.ticketCancelled:
      case GlintNotificationType.refundProcessed:
      case GlintNotificationType.eventReminder:
        _goHomeAndPush(HomeScreen.kTabPeople, GlintEventRoutes.tickets.name);

      // Admin-only types — fall through silently if a user somehow receives one.
      case GlintNotificationType.eventApproved:
      case GlintNotificationType.eventRejected:
      case GlintNotificationType.unknown:
        break;
    }
  }

  // ── Helpers ───────────────────────────────────────────────────────────────

  /// Navigates to the home screen (with [tab] selected), then pushes
  /// [routeName] on top once the frame has settled.
  static void _goHomeAndPush(int tab, String routeName) {
    final context = rootNavigatorKey.currentContext;
    if (context == null) return;

    context.goNamed(GlintMainRoutes.home.name, extra: tab);

    // Wait for the home route to finish mounting before pushing the next
    // screen. Using addPostFrameCallback ensures the router has settled;
    // always re-read currentContext here because `go` replaced the route tree.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      rootNavigatorKey.currentContext?.pushNamed(routeName);
    });
  }
}
