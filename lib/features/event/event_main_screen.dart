import 'package:flutter/material.dart';
import 'package:glint_frontend/design/exports.dart';

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
              indicator: const BoxDecoration(
                color: AppColours.backgroundShade,
                border: Border(
                  bottom: BorderSide(
                    color: AppColours.primaryBlue,
                    width: 2.4,
                  ),
                ),
              ),
              overlayColor: const WidgetStatePropertyAll<Color>(
                AppColours.backgroundShade,
              ),
              indicatorSize: TabBarIndicatorSize.tab,
              labelPadding: const EdgeInsets.symmetric(
                vertical: 16.0,
              ),
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
              Center(
                child: Text('This will show case all the events active'),
              ),
              Center(
                child: Text('This will show case all the explore active'),
              ),
            ],
          )),
    );
  }
}
