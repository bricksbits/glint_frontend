import 'package:flutter/foundation.dart';
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
      name: GlintMainRoutes.auth.name,
      builder: (context, state) => const AuthenticationScreen(),
    ),
    GoRoute(
      path: '/${GlintMainRoutes.home.name}',
      name: GlintMainRoutes.home.name,
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/${GlintMainRoutes.chat.name}',
      name: GlintMainRoutes.chat.name,
      builder: (context, state) => const ChatScreen(),
      routes: [
        GoRoute(
          path: '/${GlintChatRoutes.chatWith.name}',
          name: GlintChatRoutes.chatWith.name,
          builder: (context, state) => const ChatWithScreen(),
        ),
        GoRoute(
          path: '/${GlintChatRoutes.videoCall.name}',
          name: GlintChatRoutes.videoCall.name,
          builder: (context, state) => const ChatWithVideoCallScreen(),
        ),
        GoRoute(
          path: '/${GlintChatRoutes.tickets.name}',
          name: GlintChatRoutes.tickets.name,
          builder: (context, state) => const ChatEventTicketsScreen(),
        )
      ],
    ),
    GoRoute(
      path: '/${GlintMainRoutes.service.name}',
      name: GlintMainRoutes.service.name,
      builder: (context, state) => const ServiceScreen(),
    ),
    GoRoute(
      path: '/${GlintMainRoutes.people.name}',
      name: GlintMainRoutes.people.name,
      builder: (context, state) => PeopleScreen(),
    ),
    GoRoute(
      path: '/${GlintMainRoutes.event.name}',
      name: GlintMainRoutes.event.name,
      builder: (context, state) => const EventMainScreen(),
      routes: [
        GoRoute(
          path: '/${GlintEventRoutes.eventDetails.name}',
          name: GlintEventRoutes.eventDetails.name,
          builder: (context, state) => const EventDetailScreen(
            isEventPreviewType: false,
          ),
        ),
        GoRoute(
          path: '/${GlintEventRoutes.peopleInterested.name}',
          name: GlintEventRoutes.peopleInterested.name,
          builder: (context, state) => const EventPeopleScreen(),
        ),
      ],
    ),
    GoRoute(
      path: '/${GlintMainRoutes.profile.name}',
      name: GlintMainRoutes.profile.name,
      builder: (context, state) => const ProfileScreen(),
      routes: [
        GoRoute(
          path: '/${GlintProfileRoutes.profilePreview.name}',
          name: GlintProfileRoutes.profilePreview.name,
          builder: (context, state) => const ProfilePreviewScreen(),
        ),
        GoRoute(
          path: '/${GlintProfileRoutes.editProfile.name}',
          name: GlintProfileRoutes.editProfile.name,
          builder: (context, state) => const EditProfileScreen(),
        ),
        GoRoute(
          path: '/${GlintProfileRoutes.ticketHistory.name}',
          name: GlintProfileRoutes.ticketHistory.name,
          builder: (context, state) => const ProfileHistoryTicketsScreen(),
        ),
        GoRoute(
          path: '/${GlintProfileRoutes.transactionHistory.name}',
          name: GlintProfileRoutes.transactionHistory.name,
          builder: (context, state) => const ProfileHistoryTransactionsScreen(),
        ),
        GoRoute(
          path: '/${GlintProfileRoutes.name.name}',
          name: GlintProfileRoutes.name.name,
          builder: (context, state) => const EnterNameOnboardingScreen(),
        ),
        GoRoute(
          path: '/${GlintProfileRoutes.dob.name}',
          name: GlintProfileRoutes.dob.name,
          builder: (context, state) => const DateOfBirthOnboardingScreen(),
        ),
        GoRoute(
          path: '/${GlintProfileRoutes.pronouns.name}',
          name: GlintProfileRoutes.pronouns.name,
          builder: (context, state) => const GetSetGlintOnboardingScreen(),
        ),
        GoRoute(
          path: '/${GlintProfileRoutes.media.name}',
          name: GlintProfileRoutes.media.name,
          builder: (context, state) => const UploadPhotosOnboardingScreen(),
        ),
        GoRoute(
          path: '/${GlintProfileRoutes.gender.name}',
          name: GlintProfileRoutes.gender.name,
          builder: (context, state) => const IdentifyYourselfOnboardingScreen(),
        ),
        GoRoute(
          path: '/${GlintProfileRoutes.interestedGender.name}',
          name: GlintProfileRoutes.interestedGender.name,
          builder: (context, state) =>
              const WhoCatchesYourEyeOnboardingScreen(),
        ),
        GoRoute(
          path: '/${GlintProfileRoutes.interests.name}',
          name: GlintProfileRoutes.interests.name,
          builder: (context, state) => const InterestsAndVibeOnboardingScreen(),
        ),
        GoRoute(
          path: '/${GlintProfileRoutes.bio.name}',
          name: GlintProfileRoutes.bio.name,
          builder: (context, state) => const SetupGlintOnboardingScreen(),
        ),
      ],
    ),
    GoRoute(
      path: '/${GlintMainRoutes.notifications.name}',
      name: GlintMainRoutes.notifications.name,
      builder: (context, state) => const NotificationScreen(),
    ),
    GoRoute(
      path: '/${GlintMainRoutes.filter.name}',
      name: GlintMainRoutes.filter.name,
      builder: (context, state) => const FilterPreferenceScreen(),
    ),
    GoRoute(
      path: '/${GlintMainRoutes.likes.name}',
      name: GlintMainRoutes.likes.name,
      builder: (context, state) => const LikesScreen(),
    ),
  ],
);
