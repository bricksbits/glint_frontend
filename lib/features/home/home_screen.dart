import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glint_frontend/design/exports.dart';
import 'package:glint_frontend/features/chat/chat_screen.dart';
import 'package:glint_frontend/features/event/event_main_screen.dart';
import 'package:glint_frontend/features/people/people_screen.dart';
import 'package:glint_frontend/features/profile/profile_screen.dart';
import 'package:glint_frontend/features/service/service_screen.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<StreamChatClient?> _clientFuture;

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
  void initState() {
    super.initState();
    _clientFuture = _initializeStreamChatClient();
  }

  Future<StreamChatClient?> _initializeStreamChatClient() async {
    final userId = await getUserId();
    if (userId == null) {
      // Handle the case where the user ID couldn't be retrieved
      return null;
    }
    final userToken = await getUserToken(userId);
    if (userToken == null) {
      // Handle the case where the user token couldn't be retrieved
      return null;
    }

    final client = StreamChatClient(apiKey);
    try {
      await client.connectUser(
        User(id: userId),
        userToken,
      );
      return client;
    } catch (e) {
      print('Error connecting to Stream Chat: $e');
      // Handle the error appropriately (e.g., show an error message)
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<StreamChatClient?>(
      future: _clientFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasError || snapshot.data == null) {
          return Scaffold(
            body: Center(
              child: Text(
                'Failed to initialize chat: ${snapshot.error ?? "Unknown error"}',
                textAlign: TextAlign.center,
              ),
            ),
          );
        } else {
          final client = snapshot.data!;
          return StreamChat(
            client: client,
            child: Scaffold(
              // extendBody: true,
              backgroundColor: AppColours.white,
              appBar: GlintAppBar(
                appBarAction: appBarAction(_selectedIndex),
              ),
              body: _bottomNavScreens[_selectedIndex],
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
                padding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: List.generate(_navIcons.length, _buildNavItem),
                ),
              ),
            ),
          );
        }
      },
    );
  }
}

// Replace with your actual API key
const apiKey = 'b67pax5b2wdq';

// Replace with your user ID and token retrieval logic
Future<String?> getUserId() async {
  // In a real app, you would fetch this from your authentication system
  return 'tutorial-flutter';
}

Future<String?> getUserToken(String userId) async {
  // In a real app, you would fetch this securely from your backend
  return 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoidHV0b3JpYWwtZmx1dHRlciJ9.S-MJpoSwDiqyXpUURgO5wVqJ4vKlIVFLSEyrFYCOE1c';
}
