import 'package:flutter/material.dart';
import 'package:glint_frontend/design/exports.dart';

class GlintBottomNavbar extends StatefulWidget {
  const GlintBottomNavbar({
    super.key,
    required this.onTap,
    required this.currentIndex,
  });

  final Function(int) onTap;
  final int currentIndex;

  @override
  State<GlintBottomNavbar> createState() => _GlintBottomNavbarState();
}

class _GlintBottomNavbarState extends State<GlintBottomNavbar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      showSelectedLabels: false,
      showUnselectedLabels: false,
      backgroundColor: AppColours.white,
      elevation: 16,
      selectedIconTheme: const IconThemeData(
        color: AppColours.pink,
      ),
      selectedItemColor: AppColours.success600,
      unselectedIconTheme: const IconThemeData(
        color: Colors.deepOrangeAccent,
      ),
      unselectedItemColor: Colors.deepOrangeAccent,
      onTap: (index) {
        widget.onTap(index);
      },
      currentIndex: widget.currentIndex,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.event),
          label: 'Events',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.people),
          label: 'People',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.handshake),
          label: 'Rent',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.message),
          label: 'Chat',
        ),
      ],
    );
  }
}
