import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glint_frontend/features/auth/create_account_screen.dart';
import 'package:glint_frontend/features/auth/starter_screen.dart';
import 'package:glint_frontend/features/auth/login_screen.dart';
import 'package:glint_frontend/features/chat/chat_screen_cubit.dart';
import 'package:glint_frontend/features/chat/confirm_ticket_screen.dart';
import 'package:glint_frontend/features/chat/chat_with_screen.dart';
import 'package:glint_frontend/features/chat/chat_with_video_call_screen.dart';
import 'package:glint_frontend/features/chat/get_ticket_screen.dart';
import 'package:glint_frontend/features/chat/model/get_ticket_argument_model.dart';
import 'package:glint_frontend/features/chat/story/view/view_story_screen.dart';
import 'package:glint_frontend/features/event/detail/event_detail_screen.dart';
import 'package:glint_frontend/features/event/base/event_base_screen.dart';
import 'package:glint_frontend/features/filter/filter_preference_screen.dart';
import 'package:glint_frontend/features/likes/likes_screen.dart';
import 'package:glint_frontend/features/notifications/notification_screen.dart';
import 'package:glint_frontend/features/onboarding/on_boarding_cubit.dart';
import 'package:glint_frontend/features/payment/model/payment_argument_model.dart';
import 'package:glint_frontend/features/payment/payment_cubit.dart';
import 'package:glint_frontend/features/payment/payment_screen.dart';
import 'package:glint_frontend/features/people/people_screen.dart';
import 'package:glint_frontend/features/profile/exports.dart';
import 'package:glint_frontend/features/service/service_screen.dart';
import 'package:glint_frontend/features/splash/splash_screen.dart';
import 'package:glint_frontend/navigation/glint_all_routes.dart';
import 'package:glint_frontend/navigation/glint_authentication_routes.dart';
import 'package:glint_frontend/navigation/glint_user_on_boarding_routes.dart';
import 'package:go_router/go_router.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';
import '../features/chat/chat_screen.dart';
import '../features/home/home_screen.dart';

final glintMainRoutes = GoRouter(
  initialLocation: '/',
  debugLogDiagnostics: true,
  navigatorKey: rootNavigatorKey,
  routes: [
    GoRoute(
      path: '/',
      name: GlintMainRoutes.splash.name,
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/${GlintMainRoutes.starter.name}',
      name: GlintMainRoutes.starter.name,
      builder: (context, state) => const StarterScreen(),
    ),
    ShellRoute(
      navigatorKey: onBoardingKey,
      routes: glintUserOnBoardingInnerRoutes,
      builder: (context, state, child) {
        return BlocProvider(
          create: (_) => OnBoardingCubit(),
          child: child, // <-- Here it goes
        );
      },
    ),
    GoRoute(
      path: '/${GlintMainRoutes.register.name}',
      name: GlintMainRoutes.register.name,
      builder: (context, state) {
        return const CreateAccounScreen();
      },
    ),
    GoRoute(
      path: '/${GlintMainRoutes.auth.name}',
      name: GlintMainRoutes.auth.name,
      builder: (context, state) => const LoginScreen(
        isAdmin: false,
      ),
      routes: glintAuthenticationRoutesBase,
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
          builder: (context, state) {
            final passedChannel = state.extra as Channel?;
            if (passedChannel == null) {
              return const Center(
                child: Text("Chat Servers went out"),
              );
            }
            return ChatWithScreen(passedChannel: passedChannel);
          },
        ),
        GoRoute(
          path: '/${GlintChatRoutes.stories.name}',
          name: GlintChatRoutes.stories.name,
          pageBuilder: (context, state) {
            final chatCubit = context.read<ChatScreenCubit>();
            final passedIndex = state.extra as int?;
            return MaterialPage(
              child: BlocProvider.value(
                value: chatCubit,
                child: ViewStoryScreen(
                  passedIndex: passedIndex ?? 0,
                ),
              ),
            );
          },
        ),
        GoRoute(
          path: '/${GlintChatRoutes.getTicket.name}',
          name: GlintChatRoutes.getTicket.name,
          builder: (context, state) {
            final argument = state.extra as GetTicketArgumentModel;
            return GetEventTicketScreen(getTicketArgumentModel: argument);
          },
        ),
        GoRoute(
          path: '/${GlintChatRoutes.videoCall.name}',
          name: GlintChatRoutes.videoCall.name,
          builder: (context, state) => const ChatWithVideoCallScreen(),
        ),
        GoRoute(
          path: '/${GlintChatRoutes.tickets.name}',
          name: GlintChatRoutes.tickets.name,
          builder: (context, state) => const ConfirmTicketScreen(),
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
      builder: (context, state) => const PeopleScreen(),
    ),
    GoRoute(
      path: '/${GlintMainRoutes.event.name}',
      name: GlintMainRoutes.event.name,
      builder: (context, state) => const EventBaseScreen(),
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
          builder: (context, state) => const PeopleScreen(),
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
          path: '/${GlintProfileRoutes.settings.name}',
          name: GlintProfileRoutes.settings.name,
          builder: (context, state) => const ProfileSettingsScreen(),
        ),
        GoRoute(
          path: '/${GlintProfileRoutes.subscription.name}',
          name: GlintProfileRoutes.subscription.name,
          builder: (context, state) => const SettingsScreen(),
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
    GoRoute(
      path: '/${GlintMainRoutes.payment.name}',
      name: GlintMainRoutes.payment.name,
      pageBuilder: (context, state) {
        final paymentCubit = context.read<PaymentCubit>();
        final paymentArgumentModel = state.extra as PaymentArgumentModel?;
        return MaterialPage(
          child: BlocProvider.value(
            value: paymentCubit,
            child: PaymentScreen(
              paymentArgumentModel: paymentArgumentModel,
            ),
          ),
        );
      },
    ),
  ],
);
