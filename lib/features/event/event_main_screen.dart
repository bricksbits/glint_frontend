import 'package:flutter/material.dart';
import 'package:glint_frontend/design/exports.dart';

import 'main_event_screen.dart';
import 'main_explore_screen.dart';

class EventMainScreen extends StatefulWidget {
  const EventMainScreen({super.key});

  @override
  State<EventMainScreen> createState() => _EventMainScreenState();
}

class _EventMainScreenState extends State<EventMainScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppColours.white,
        appBar: AppBar(
          backgroundColor: AppColours.white,
          titleSpacing: 0,
          scrolledUnderElevation: 0,
          title: TabBar(
            dividerColor: AppColours.tabBarBorder,
            dividerHeight: 1.2,
            indicator: const BoxDecoration(
              color: AppColours.backgroundShade,
              border: Border(
                left: BorderSide(
                  color: AppColours.tabBarBorder,
                  width: 1.2,
                ),
                right: BorderSide(
                  color: AppColours.tabBarBorder,
                  width: 1.2,
                ),
                bottom: BorderSide(
                  color: AppColours.primaryBlue,
                  width: 2.4,
                ),
              ),
            ),
            overlayColor: const WidgetStatePropertyAll<Color>(
              AppColours.backgroundShade,
            ),
            labelPadding: const EdgeInsets.symmetric(
              vertical: 18.0,
            ),
            indicatorSize: TabBarIndicatorSize.tab,
            labelStyle: AppTheme.simpleBodyText.copyWith(
              fontWeight: FontWeight.w600,
            ),
            unselectedLabelStyle: AppTheme.simpleBodyText.copyWith(
              fontWeight: FontWeight.w400,
            ),
            tabs: const [
              Text(
                'Events',
              ),
              Text(
                'Explore',
              ),
            ],
          ),
        ),

        // body
        body: const TabBarView(
          children: [
            // main event screen
            MainEventScreen(),
            MainExploreScreen(),
          ],
        ),
      ),
    );
  }
}
