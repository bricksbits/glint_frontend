import 'package:glint_frontend/features/admin/screen/admin_create_event_screen.dart';
import 'package:glint_frontend/features/admin/screen/admin_dashboard_screen.dart';
import 'package:glint_frontend/features/admin/screen/admin_edit_profile_screen.dart';
import 'package:glint_frontend/features/admin/screen/admin_event_live_screen.dart';
import 'package:glint_frontend/features/admin/screen/admin_track_specific_event.dart';
import 'package:glint_frontend/features/admin/screen/super_admin_dashboard_screen.dart';
import 'package:glint_frontend/features/admin/screen/track_event_interested_people_screen.dart';
import 'package:glint_frontend/features/admin/screen/track_event_tickets_bought_screen.dart';
import 'package:glint_frontend/features/auth/login_screen.dart';
import 'package:glint_frontend/features/event/detail/event_detail_screen.dart';
import 'package:glint_frontend/features/splash/splash_screen.dart';
import 'package:glint_frontend/navigation/glint_all_routes.dart';
import 'package:go_router/go_router.dart';

import 'glint_authentication_routes.dart';

final glintAdminRoutes = GoRouter(
  initialLocation: '/${GlintAdminDasboardRoutes.home.name}',
  debugLogDiagnostics: true,
  navigatorKey: rootNavigatorKey,
  routes: [
    GoRoute(
      path: '/',
      name: GlintAdminDasboardRoutes.splash.name,
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/${GlintAdminDasboardRoutes.auth.name}',
      name: GlintAdminDasboardRoutes.auth.name,
      builder: (context, state) => const LoginScreen(
        isAdmin: true,
      ),
      routes: glintAuthenticationRoutesBase,
    ),
    GoRoute(
      path: '/${GlintAdminDasboardRoutes.home.name}',
      name: GlintAdminDasboardRoutes.home.name,
      builder: (context, state) {
        // return const SuperAdminDashboardScreen();
        const isSuperAdmin = false;
        return isSuperAdmin ? SuperAdminDashboardScreen() : const AdminDashboardScreen();
      },
    ),
    GoRoute(
      path: '/${GlintAdminDasboardRoutes.interestedUsers.name}',
      name: GlintAdminDasboardRoutes.interestedUsers.name,
      builder: (context, state) => const TrackEventInterestedPeopleScreen(),
    ),
    GoRoute(
      path: '/${GlintAdminDasboardRoutes.ticketBought.name}',
      name: GlintAdminDasboardRoutes.ticketBought.name,
      builder: (context, state) => const TrackEventTicketsBoughtScreen(),
    ),
    GoRoute(
      path: '/${GlintAdminDasboardRoutes.trackEvent.name}',
      name: GlintAdminDasboardRoutes.trackEvent.name,
      builder: (context, state) => const AdminTrackSpecificEvent(),
    ),
    GoRoute(
      path: '/${GlintAdminDasboardRoutes.createEvent.name}',
      name: GlintAdminDasboardRoutes.createEvent.name,
      builder: (context, state) => const AdminCreateEventScreen(),
    ),
    GoRoute(
      path: '/${GlintAdminDasboardRoutes.profile.name}',
      name: GlintAdminDasboardRoutes.profile.name,
      builder: (context, state) => const AdminEditProfileScreen(),
    ),
    GoRoute(
      path: '/${GlintAdminDasboardRoutes.liveEvent.name}',
      name: GlintAdminDasboardRoutes.liveEvent.name,
      builder: (context, state) => const AdminEventLiveScreen(),
    ),
    GoRoute(
      path: '/${GlintAdminDasboardRoutes.previewEvent.name}',
      name: GlintAdminDasboardRoutes.previewEvent.name,
      builder: (context, state) => const EventDetailScreen(
        isEventPreviewType: true,
      ),
    ),
  ],
);
