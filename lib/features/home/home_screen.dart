import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glint_frontend/design/exports.dart';
import 'package:glint_frontend/features/chat/chat_screen.dart';
import 'package:glint_frontend/features/event/event_main_screen.dart';
import 'package:glint_frontend/features/people/people_screen.dart';
import 'package:glint_frontend/features/profile/profile_screen.dart';
import 'package:glint_frontend/features/service/service_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 2;
  static final List<Widget> _bottomNavScreens = [
    const ProfileScreen(),
    const EventMainScreen(),
    PeopleScreen(),
    const ServiceScreen(),
    const ChatScreen(),
  ];

  static const List<String> _navIcons = [
    'lib/assets/icons/user_icon.svg',
    'lib/assets/icons/event_icon.svg',
    'lib/assets/icons/logo_icon.svg',
    'lib/assets/icons/handshake_icon.svg',
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
  Widget build(BuildContext context) {
    return Scaffold(
      // extendBody: true,
      backgroundColor: AppColours.white,
      appBar: GlintAppBar(
        appBarAction: appBarAction(_selectedIndex),
      ),
      body: _bottomNavScreens[_selectedIndex],
      bottomNavigationBar: Container(
        width: double.infinity,
        margin:
            const EdgeInsets.symmetric(horizontal: 20.0).copyWith(bottom: 24.0),
        decoration: BoxDecoration(
          color: AppColours.white,
          borderRadius: BorderRadius.circular(50.0),
          border: Border.all(
            color: AppColours.gray.withAlpha(92),
            width: 1.25,
          ),
        ),
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: List.generate(_navIcons.length, _buildNavItem),
        ),
      ),
    );
  }
}
