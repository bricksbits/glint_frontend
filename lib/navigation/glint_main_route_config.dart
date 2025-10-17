import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glint_frontend/domain/business_logic/models/admin/pass_event_details_argument_model.dart';
import 'package:glint_frontend/domain/business_logic/models/event/event_list_domain_model.dart';
import 'package:glint_frontend/features/admin/bloc/admin_dasboard/admin_dashboard_bloc.dart';
import 'package:glint_frontend/features/admin/bloc/create/admin_create_event_cubit.dart';
import 'package:glint_frontend/features/admin/bloc/track_specific_event/track_admin_event_cubit.dart';
import 'package:glint_frontend/features/admin/screen/admin_dashboard_screen.dart';
import 'package:glint_frontend/features/admin/screen/admin_track_event_screen.dart';
import 'package:glint_frontend/features/admin/screen/super_admin_dashboard_screen.dart';
import 'package:glint_frontend/features/auth/create_account_screen.dart';
import 'package:glint_frontend/features/auth/login_screen.dart';
import 'package:glint_frontend/features/auth/starter_screen.dart';
import 'package:glint_frontend/features/chat/chat_screen_cubit.dart';
import 'package:glint_frontend/features/chat/chat_with_screen.dart';
import 'package:glint_frontend/features/chat/chat_with_video_call_screen.dart';
import 'package:glint_frontend/features/chat/confirm_ticket_screen.dart';
import 'package:glint_frontend/features/chat/get_ticket_screen.dart';
import 'package:glint_frontend/features/chat/model/get_ticket_argument_model.dart';
import 'package:glint_frontend/features/chat/oneTimeView/one_time_view_screen.dart';
import 'package:glint_frontend/features/chat/story/upload/upload_story_screen.dart';
import 'package:glint_frontend/features/chat/story/view/view_story_screen.dart';
import 'package:glint_frontend/features/event/base/event_base_cubit.dart';
import 'package:glint_frontend/features/event/detail/event_detail_screen.dart';
import 'package:glint_frontend/features/event/base/event_base_screen.dart';
import 'package:glint_frontend/features/event/people/people_interested_for_event_screen.dart';
import 'package:glint_frontend/features/filter/filter_preference_screen.dart';
import 'package:glint_frontend/features/likes/likes_screen.dart';
import 'package:glint_frontend/features/notifications/notification_screen.dart';
import 'package:glint_frontend/features/onboarding/on_boarding_cubit.dart';
import 'package:glint_frontend/features/payment/model/payment_argument_model.dart';
import 'package:glint_frontend/features/payment/payment_cubit.dart';
import 'package:glint_frontend/features/payment/payment_screen.dart';
import 'package:glint_frontend/features/people/bloc/people_cards_bloc.dart';
import 'package:glint_frontend/features/people/people_screen.dart';
import 'package:glint_frontend/features/profile/exports.dart';
import 'package:glint_frontend/features/service/service_screen.dart';
import 'package:glint_frontend/features/splash/splash_screen.dart';
import 'package:glint_frontend/navigation/argument_models.dart';
import 'package:glint_frontend/navigation/glint_all_routes.dart';
import 'package:glint_frontend/navigation/glint_authentication_routes.dart';
import 'package:glint_frontend/navigation/glint_user_on_boarding_routes.dart';
import 'package:go_router/go_router.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

import '../features/admin/screen/admin_create_event_screen.dart';
import '../features/admin/screen/admin_edit_profile_screen.dart';
import '../features/admin/screen/admin_event_live_screen.dart';
import '../features/admin/screen/admin_track_specific_event.dart';
import '../features/admin/screen/track_event_interested_people_screen.dart';
import '../features/admin/screen/track_event_tickets_bought_screen.dart';
import '../features/auth/blocs/register/register_cubit.dart';
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
          lazy: true,
          create: (_) => OnBoardingCubit(),
          child: child, // <-- Here it goes
        );
      },
    ),
    GoRoute(
      path: '/${GlintMainRoutes.register.name}',
      name: GlintMainRoutes.register.name,
      builder: (context, state) {
        var isAdmin = state.extra as bool?;
        return BlocProvider(
          lazy: true,
          create: (context) => RegisterCubit(),
          child: CreateAccounScreen(
            isAdmin: isAdmin ?? false,
          ),
        );
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
      builder: (context, state) => MultiBlocProvider(
        providers: [
          BlocProvider<PeopleCardsBloc>(
            lazy: true,
            create: (_) =>
                PeopleCardsBloc()..add(const PeopleCardsEvent.started()),
          ),
          BlocProvider<ChatScreenCubit>(
            lazy: true,
            create: (_) => ChatScreenCubit(),
          ),
          BlocProvider<EventBaseCubit>(
            lazy: true,
            create: (_) => EventBaseCubit(),
          ),
        ],
        child: const HomeScreen(),
      ),
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
            final passedArguments = state.extra as ChatWithNavArguments?;
            if (passedArguments == null) {
              return const Center(
                child: Text("Chat Servers went out"),
              );
            }
            return ChatWithScreen(
              chatWithNavArguments: passedArguments,
            );
          },
        ),
        GoRoute(
          path: '/${GlintChatRoutes.stories.name}',
          name: GlintChatRoutes.stories.name,
          builder: (context, state) {
            final passedIndex = state.extra as int?;
            return ViewStoryScreen(
              passedIndex: passedIndex ?? 0,
            );
          },
        ),
        GoRoute(
          path: '/${GlintChatRoutes.uploadStory.name}',
          name: GlintChatRoutes.uploadStory.name,
          builder: (context, state) {
            return const UploadStoryScreen(
              isUploadStory: true,
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
        ),
        GoRoute(
          path: '/${GlintChatRoutes.oneTimePhotoView.name}',
          name: GlintChatRoutes.oneTimePhotoView.name,
          builder: (context, state) {
            final imagePassed = state.extra as String?;
            return OneTimeViewScreen(imageUrl: imagePassed);
          },
        ),
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
      builder: (context, state) => const EventBaseScreen(),
      routes: [
        GoRoute(
          path: '/${GlintEventRoutes.eventDetails.name}',
          name: GlintEventRoutes.eventDetails.name,
          builder: (context, state) {
            var eventId = state.extra as int?;
            return EventDetailScreen(
              eventArguments: EventDetailsNavArguments(
                eventId: eventId,
                eventDetails: null,
                unUploadedFiles: null,
              ),
            );
          },
        ),
        GoRoute(
          path: '/${GlintEventRoutes.peopleInterested.name}',
          name: GlintEventRoutes.peopleInterested.name,
          builder: (context, state) {
            final arguments = state.extra as ToEventPeopleScreenNavArguments;
            return BlocProvider(
              lazy: true,
              create: (context) => PeopleCardsBloc()
                ..add(PeopleCardsEvent.fetchInterestedUserForTheEvent(
                    arguments.eventId)),
              child: PeopleInterestedForEventScreen(
                navArguments: arguments,
              ),
            );
          },
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
      ],
    ),
    GoRoute(
      path: '/${GlintMainRoutes.settings.name}',
      name: GlintMainRoutes.settings.name,
      builder: (context, state) => const ProfileSettingsScreen(),
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
    GoRoute(
      path: '/${GlintAdminDasboardRoutes.superAdminHome.name}',
      name: GlintAdminDasboardRoutes.superAdminHome.name,
      builder: (context, state) {
        return const SuperAdminDashboardScreen();
      },
    ),
    ShellRoute(
      navigatorKey: adminDashboardKey,
      routes: [
        GoRoute(
          path: '/${GlintAdminDasboardRoutes.adminHome.name}',
          name: GlintAdminDasboardRoutes.adminHome.name,
          pageBuilder: (context, state) {
            return MaterialPage(
              child: BlocProvider.value(
                value: context.read<AdminDashboardBloc>(),
                child: const AdminDashboardScreen(),
              ),
            );
          },
        ),
        GoRoute(
          path: '/${GlintAdminDasboardRoutes.adminPublishedEvents.name}',
          name: GlintAdminDasboardRoutes.adminPublishedEvents.name,
          pageBuilder: (context, state) {
            return MaterialPage(
              child: BlocProvider.value(
                value: context.read<AdminDashboardBloc>(),
                child: const AdminTrackEventScreen(),
              ),
            );
          },
        ),
        GoRoute(
          path: '/${GlintAdminDasboardRoutes.authProfile.name}',
          name: GlintAdminDasboardRoutes.authProfile.name,
          pageBuilder: (context, state) {
            return MaterialPage(
              child: BlocProvider.value(
                value: context.read<AdminDashboardBloc>(),
                child: const AdminEditProfileScreen(),
              ),
            );
          },
        ),
      ],
      builder: (context, state, child) {
        return BlocProvider(
          lazy: true,
          create: (context) =>
              AdminDashboardBloc()..add(const AdminDashboardEvent.started()),
          child: child,
        );
      },
    ),
    ShellRoute(
      navigatorKey: trackAdminEventKey,
      routes: [
        GoRoute(
          path: '/${GlintAdminDasboardRoutes.trackEvent.name}',
          name: GlintAdminDasboardRoutes.trackEvent.name,
          pageBuilder: (context, state) {
            var extra = state.extra as PassEventDetailsArgumentModel;
            return MaterialPage(
              child: BlocProvider.value(
                value: context.read<TrackAdminEventCubit>(),
                child: AdminTrackSpecificEvent(
                  eventId: int.parse(extra.eventId),
                  eventTitle: extra.eventTitle,
                  eventDate: extra.eventDateAndTime,
                ),
              ),
            );
          },
        ),
        GoRoute(
          path: '/${GlintAdminDasboardRoutes.interestedUsers.name}',
          name: GlintAdminDasboardRoutes.interestedUsers.name,
          pageBuilder: (context, state) {
            var extra = state.extra as PassEventDetailsArgumentModel;
            return MaterialPage(
              child: BlocProvider.value(
                value: context.read<TrackAdminEventCubit>(),
                child: TrackEventInterestedPeopleScreen(
                  eventId: extra.eventId,
                  eventTitle: extra.eventTitle,
                  eventDateAndTime: extra.eventDateAndTime,
                  eventLocation: extra.eventLocation,
                ),
              ),
            );
          },
        ),
        GoRoute(
          path: '/${GlintAdminDasboardRoutes.ticketBought.name}',
          name: GlintAdminDasboardRoutes.ticketBought.name,
          pageBuilder: (context, state) {
            var extra = state.extra as PassEventDetailsArgumentModel;
            return MaterialPage(
              child: BlocProvider.value(
                value: context.read<TrackAdminEventCubit>(),
                child: TrackEventTicketsBoughtScreen(
                  eventId: extra.eventId,
                  eventTitle: extra.eventTitle,
                  eventDateAndTime: extra.eventDateAndTime,
                  eventLocation: extra.eventLocation,
                ),
              ),
            );
          },
        ),
      ],
      builder: (context, state, child) {
        return BlocProvider(
          lazy: true,
          create: (context) => TrackAdminEventCubit(),
          child: child,
        );
      },
    ),
    GoRoute(
      path: '/${GlintAdminDasboardRoutes.createEvent.name}',
      name: GlintAdminDasboardRoutes.createEvent.name,
      builder: (context, state) {
        var navArguments = state.extra as AdminCreateEventNavArguments?;
        return BlocProvider(
          lazy: true,
          create: (context) => AdminCreateEventCubit(),
          child: AdminCreateEventScreen(
            navArguments: navArguments,
          ),
        );
      },
    ),
    GoRoute(
      path: '/${GlintAdminDasboardRoutes.liveEvent.name}',
      name: GlintAdminDasboardRoutes.liveEvent.name,
      builder: (context, state) {
        final eventModel = state.extra as EventListDomainModel;
        return AdminEventLiveScreen(
          eventModelArgs: eventModel,
        );
      },
    ),
    GoRoute(
      path: '/${GlintAdminDasboardRoutes.previewEvent.name}',
      name: GlintAdminDasboardRoutes.previewEvent.name,
      builder: (context, state) {
        var eventDetailsNavArgs = state.extra as EventDetailsNavArguments;
        return EventDetailScreen(
          eventArguments: eventDetailsNavArgs,
        );
      },
    ),
  ],
);
