import 'package:flutter/foundation.dart';
import 'package:glint_frontend/features/admin/admin_create_event_screen.dart';
import 'package:glint_frontend/features/admin/admin_dashboard_screen.dart';
import 'package:glint_frontend/features/admin/exports.dart';
import 'package:glint_frontend/features/chat/chat_event_tickets_screen.dart';
import 'package:glint_frontend/features/chat/chat_with_screen.dart';
import 'package:glint_frontend/features/chat/chat_with_video_call_screen.dart';
import 'package:glint_frontend/features/event/event_detail_screen.dart';
import 'package:glint_frontend/features/event/event_main_screen.dart';
import 'package:glint_frontend/features/event/event_people_screen.dart';
import 'package:glint_frontend/features/filter/filter_preference_screen.dart';
import 'package:glint_frontend/features/likes/likes_screen.dart';
import 'package:glint_frontend/features/notifications/notification_screen.dart';
import 'package:glint_frontend/features/onboarding/date_of_birth_onboarding_screen.dart';
import 'package:glint_frontend/features/onboarding/enter_name_onboarding_screen.dart';
import 'package:glint_frontend/features/onboarding/get_set_glint_onboarding_screen.dart';
import 'package:glint_frontend/features/onboarding/identify_yourself_onboarding_screen.dart';
import 'package:glint_frontend/features/onboarding/interests_and_vibe_onboarding_screen.dart';
import 'package:glint_frontend/features/onboarding/setup_glint_onboarding_screen.dart';
import 'package:glint_frontend/features/onboarding/upload_photos_onboarding_screen.dart';
import 'package:glint_frontend/features/onboarding/who_catches_your_eye_onboarding_screen.dart';
import 'package:glint_frontend/features/people/people_screen.dart';
import 'package:glint_frontend/features/profile/edit_profile_screen.dart';
import 'package:glint_frontend/features/profile/profile_history_tickets_screen.dart';
import 'package:glint_frontend/features/profile/profile_history_transactions_screen.dart';
import 'package:glint_frontend/features/profile/profile_preview_screen.dart';
import 'package:glint_frontend/features/profile/profile_screen.dart';
import 'package:glint_frontend/features/service/service_screen.dart';
import 'package:glint_frontend/features/splash/splash_screen.dart';
import 'package:glint_frontend/navigation/glint_all_routes.dart';
import 'package:go_router/go_router.dart';

import '../features/auth/authentication_screen.dart';
import '../features/chat/chat_screen.dart';
import '../features/home/home_screen.dart';
import 'glint_authentication_routes.dart';

final glintAdminRoutes = GoRouter(
  initialLocation: '/',
  debugLogDiagnostics: true,
  routes: [
    GoRoute(
      path: '/',
      name: GlintAdminDasboardRoutes.splash.name,
      builder: (context, state) => const SplashScreen(),
    ),
    // TODO: Make it Login Screen Direct
    GoRoute(
      path: '/${GlintAdminDasboardRoutes.auth.name}',
      name: GlintAdminDasboardRoutes.auth.name,
      builder: (context, state) => const AuthenticationScreen(),
      routes: glintAuthenticationRoutesBase,
    ),
    GoRoute(
      path: '/${GlintAdminDasboardRoutes.home.name}',
      name: GlintAdminDasboardRoutes.home.name,
      builder: (context, state) {
        return const SuperAdminDashboardScreen();
        // final isSuperAdmin = false;
        // return isSuperAdmin
        //     ?
        //     : const AdminDashboardScreen();
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
