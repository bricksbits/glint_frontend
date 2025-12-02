import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glint_frontend/design/exports.dart';
import 'package:glint_frontend/di/injection.dart';
import 'package:glint_frontend/domain/business_logic/models/common/user_ticket_holder_model.dart';
import 'package:glint_frontend/features/chat/chat_screen.dart';
import 'package:glint_frontend/features/chat/chat_screen_cubit.dart';
import 'package:glint_frontend/features/chat/story/upload/upload_story_screen.dart';
import 'package:glint_frontend/features/event/base/event_base_cubit.dart';
import 'package:glint_frontend/features/event/base/event_base_screen.dart';
import 'package:glint_frontend/features/payment/model/payment_argument_model.dart';
import 'package:glint_frontend/features/payment/payment_cubit.dart';
import 'package:glint_frontend/features/people/bloc/people_cards_bloc.dart';
import 'package:glint_frontend/features/people/people_screen.dart';
import 'package:glint_frontend/features/profile/profile_screen.dart';
import 'package:glint_frontend/features/service/service_screen.dart';
import 'package:glint_frontend/navigation/glint_all_routes.dart';
import 'package:glint_frontend/services/image_manager_service.dart';
import 'package:glint_frontend/services/swipe_cache_manager.dart';
import 'package:glint_frontend/utils/internet/internet_status_checker_cubit.dart';
import 'package:glint_frontend/utils/logger.dart';
import 'package:go_router/go_router.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

import '../payment/payment_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  int _selectedIndex = 2;
  static final List<Widget> _bottomNavScreens = [
    const ProfileScreen(),
    const EventBaseScreen(),
    PeopleScreen(),
    const ChatScreen(),
  ];

  static const List<String> _navIcons = [
    'lib/assets/icons/user_icon.svg',
    'lib/assets/icons/event_icon.svg',
    'lib/assets/icons/logo_icon.svg',
    // 'lib/assets/icons/handshake_icon.svg',
    'lib/assets/icons/chat_icon.svg',
  ];

  void _onNavItemTap(int index) {
    setState(() => _selectedIndex = index);
  }

  Widget _buildNavItem(int index) {
    return GestureDetector(
      onTap: () => _onNavItemTap(index),
      child: Container(
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: _selectedIndex == index
              ? AppColours.backgroundShade
              : Colors.transparent,
          shape: BoxShape.circle,
        ),
        child: SvgPicture.asset(
          _navIcons[index],
          colorFilter: ColorFilter.mode(
            _selectedIndex == index
                ? AppColours.primaryBlue
                : index == 2 // glint logo will always be primary blue
                    ? AppColours.primaryBlue
                    : AppColours.black,
            BlendMode.srcIn,
          ),
        ),
      ),
    );
  }

  GlintAppBarActions appBarAction(int index) {
    switch (index) {
      case 0:
        return GlintAppBarActions.profile;
      case 1:
        return GlintAppBarActions.event;
      default:
        return GlintAppBarActions.defaultActions;
    }
  }

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    const logPrefix = "HomeScreenAppLifecycle";
    switch (state) {
      case AppLifecycleState.detached:
        debugLogger(logPrefix, "App is detached");
        break;
      case AppLifecycleState.resumed:
        debugLogger(logPrefix, "App is resumed");
        break;
      case AppLifecycleState.inactive:
        debugLogger(logPrefix, "App is in inActive");
        break;
      case AppLifecycleState.hidden:
        debugLogger(logPrefix, "App is hidden");
        break;
      case AppLifecycleState.paused:
        final swipeManager = getIt.get<SwipeBufferManager>();
        swipeManager.flushOnAppPause().then((_) {
          debugLogger(logPrefix, "Cache Swipes processed successfully,");
        });
        debugLogger(logPrefix, "App is paused");
        break;
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InternetStatusCheckerCubit, InternetStatusCheckerState>(
      builder: (context, state) {
        if (state is InternetStatusDisConnected) {
          return const Banner(
            message: "No Internet Connection",
            location: BannerLocation.topStart,
            color: Colors.red,
          );
        }
        return Scaffold(
          // extendBody: true,
          backgroundColor: AppColours.white,
          // do not show app bar on chat screen
          appBar: _selectedIndex == 3
              ? null
              : GlintAppBar(
                  appBarAction: appBarAction(_selectedIndex),
                ),
          body: IndexedStack(
            index: _selectedIndex,
            children: _bottomNavScreens,
          ),
          bottomNavigationBar: Container(
            height: 70.0,
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 20.0)
                .copyWith(bottom: 20.0),
            decoration: BoxDecoration(
              color: AppColours.white,
              borderRadius: BorderRadius.circular(50.0),
              border: Border.all(
                color: AppColours.gray.withAlpha(92),
                width: 1.25,
              ),
            ),
            padding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: List.generate(_navIcons.length, _buildNavItem),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}
