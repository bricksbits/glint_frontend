import 'package:glint_frontend/features/chat/chat_event_tickets_screen.dart';
import 'package:glint_frontend/features/chat/chat_with_screen.dart';
import 'package:glint_frontend/features/chat/chat_with_video_call_screen.dart';
import 'package:glint_frontend/features/event/event_detail_screen.dart';
import 'package:glint_frontend/features/event/event_main_screen.dart';
import 'package:glint_frontend/features/event/event_people_screen.dart';
import 'package:glint_frontend/features/filter/filter_preference_screen.dart';
import 'package:glint_frontend/features/likes/likes_screen.dart';
import 'package:glint_frontend/features/notifications/notification_screen.dart';
import 'package:glint_frontend/features/people/people_screen.dart';
import 'package:glint_frontend/features/profile/profile_history_tickets_screen.dart';
import 'package:glint_frontend/features/profile/profile_history_transactions_screen.dart';
import 'package:glint_frontend/features/profile/profile_preview_screen.dart';
import 'package:glint_frontend/features/profile/profile_screen.dart';
import 'package:glint_frontend/features/service/service_screen.dart';
import 'package:glint_frontend/navigation/glint_all_routes.dart';
import 'package:go_router/go_router.dart';

import '../features/auth/authentication_screen.dart';
import '../features/chat/chat_screen.dart';
import '../features/home/home_screen.dart';

final glintMainRoutes = GoRouter(
  initialLocation: '/${GlintMainRoutes.home.name}',
  debugLogDiagnostics: true,
  routes: [
    GoRoute(
      path: '/${GlintMainRoutes.auth.name}',
      builder: (context, state) => const AuthenticationScreen(),
    ),
    GoRoute(
      path: '/${GlintMainRoutes.home.name}',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/${GlintMainRoutes.chat.name}',
      builder: (context, state) => const ChatScreen(),
      routes: [
        GoRoute(
          path: '/${GlintChatRoutes.chatWith.name}',
          builder: (context, state) => const ChatWithScreen(),
        ),
        GoRoute(
          path: '/${GlintChatRoutes.videoCall.name}',
          builder: (context, state) => const ChatWithVideoCallScreen(),
        ),
        GoRoute(
          path: '/${GlintChatRoutes.tickets.name}',
          builder: (context, state) => const ChatEventTicketsScreen(),
        )
      ],
    ),
    GoRoute(
      path: '/${GlintMainRoutes.service.name}',
      builder: (context, state) => const ServiceScreen(),
    ),
    GoRoute(
      path: '/${GlintMainRoutes.people.name}',
      builder: (context, state) => const PeopleScreen(),
    ),
    GoRoute(
      path: '/${GlintMainRoutes.event.name}',
      builder: (context, state) => const EventMainScreen(),
      routes: [
        GoRoute(
          path: '/${GlintEventRoutes.eventDetails.name}',
          builder: (context, state) => const EventDetailScreen(),
        ),
        GoRoute(
          path: '/${GlintEventRoutes.peopleInterested.name}',
          builder: (context, state) => const EventPeopleScreen(),
        ),
      ],
    ),
    GoRoute(
      path: '/${GlintMainRoutes.profile.name}',
      builder: (context, state) => const ProfileScreen(),
      routes: [
        GoRoute(
          path: '/${GlintProfileRoutes.profilePreview.name}',
          builder: (context, state) => const ProfilePreviewScreen(),
        ),
        GoRoute(
          path: '/${GlintProfileRoutes.ticketHistory.name}',
          builder: (context, state) => const ProfileHistoryTicketsScreen(),
        ),
        GoRoute(
          path: '/${GlintProfileRoutes.transactionHistory.name}',
          builder: (context, state) => const ProfileHistoryTransactionsScreen(),
        ),
      ],
    ),
    GoRoute(
      path: '/${GlintMainRoutes.notifications.name}',
      builder: (context, state) => const NotificationScreen(),
    ),
    GoRoute(
      path: '/${GlintMainRoutes.filter.name}',
      builder: (context, state) => const FilterPreferenceScreen(),
    ),
    GoRoute(
      path: '/${GlintMainRoutes.likes.name}',
      builder: (context, state) => const LikesScreen(),
    ),
  ],
);
