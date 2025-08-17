import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glint_frontend/design/exports.dart';
import 'package:glint_frontend/features/event/base/event_base_cubit.dart';

import '../base_view/events_list_screen.dart';
import '../base_view/category_list_screen.dart';

class EventBaseScreen extends StatefulWidget {
  const EventBaseScreen({super.key});

  @override
  State<EventBaseScreen> createState() => _EventBaseScreenState();
}

class _EventBaseScreenState extends State<EventBaseScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventBaseCubit, EventBaseState>(
      builder: (context, state) {
        return DefaultTabController(
          length: 2,
          child: Scaffold(
            backgroundColor: AppColours.white,
            appBar: AppBar(
              backgroundColor: AppColours.white,
              titleSpacing: 0,
              scrolledUnderElevation: 0,
              title: TabBar(
                dividerColor: AppColours.borderGray,
                dividerHeight: 1.2,
                indicator: const BoxDecoration(
                  color: AppColours.backgroundShade,
                  border: Border(
                    left: BorderSide(
                      color: AppColours.borderGray,
                      width: 1.2,
                    ),
                    right: BorderSide(
                      color: AppColours.borderGray,
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
                EventsListScreen(),
                CategoryListScreen(),
              ],
            ),
          ),
        );
      },
    );
  }
}
