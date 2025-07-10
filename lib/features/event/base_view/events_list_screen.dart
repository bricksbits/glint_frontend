import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:glint_frontend/design/exports.dart';
import 'package:glint_frontend/features/event/base/event_base_cubit.dart';
import 'package:glint_frontend/features/event/base/event_base_cubit.dart';
import 'package:glint_frontend/navigation/glint_all_routes.dart';
import 'package:go_router/go_router.dart';

enum FilterChipEnum {
  recent,
  mostPopular,
  saved,
}

class EventsListScreen extends StatefulWidget {
  const EventsListScreen({super.key});

  @override
  State<EventsListScreen> createState() => _EventsListScreenState();
}

class _EventsListScreenState extends State<EventsListScreen> {
  FilterChipEnum _selectedChip = FilterChipEnum.mostPopular;
  final List<Map<FilterChipEnum, String>> filterOptions = [
    {
      FilterChipEnum.recent: 'Recent',
    },
    {
      FilterChipEnum.mostPopular: 'Most Popular',
    },
    {
      FilterChipEnum.saved: 'Saved',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventBaseCubit, EventBaseState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20.0,
          ),
          child: CustomScrollView(
            slivers: [
              // Add top spacing
              const SliverToBoxAdapter(child: SizedBox(height: 30.0)),

              // Event banner
              SliverToBoxAdapter(child: _buildEventBanner()),
              const SliverToBoxAdapter(child: SizedBox(height: 20.0)),

              // Filter chips
              SliverToBoxAdapter(child: _buildFilterChips()),
              const SliverToBoxAdapter(child: SizedBox(height: 24.0)),

              // Hot Events List
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final event = state.hotEvents[index];
                    return HotEvent(
                      eventModel: event,
                      getEventInfo: (eventId) {
                        context.pushNamed(
                          "/${GlintMainRoutes.event.name}/${GlintEventRoutes.eventDetails.name}",
                          extra: event,
                        );
                      },
                      fetchProfiles: (eventId) {
                        context
                            .read<EventBaseCubit>()
                            .fetchSelectedEventProfiles(eventId);
                      },
                    );
                  },
                  childCount: state.hotEvents.length,
                ),
              ),

              const SliverToBoxAdapter(child: SizedBox(height: 24.0)),

              // Nearby Events List
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final event = state.normalEvents[index];
                    return NearbyEventCard(
                      eventModel: event,
                    );
                  },
                  childCount: state.normalEvents.length,
                ),
              ),

              // Bottom padding
              const SliverToBoxAdapter(child: SizedBox(height: 16.0)),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFilterChips() {
    return Wrap(
      spacing: 8.0,
      runSpacing: 8.0,
      children: filterOptions.map(
        (option) {
          final chipEnum = option.keys.first;
          final chipLabel = option.values.first;
          final isSelected = _selectedChip == chipEnum;

          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedChip = chipEnum;
              });
              print(_selectedChip);
            },
            child: Chip(
              shape: const StadiumBorder(
                side: BorderSide(
                  color: AppColours.backgroundShade,
                  width: 1.4,
                ),
              ),
              label: Text(
                chipLabel,
                style: const TextStyle(
                  color: AppColours.black,
                  fontWeight: FontWeight.w400,
                ),
              ),
              backgroundColor: isSelected
                  ? AppColours.chipBackgroundShade
                  : AppColours.white,
            ),
          );
        },
      ).toList(),
    );
  }

  Widget _buildEventBanner() {
    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          child: ClipRRect(
            borderRadius: const BorderRadius.all(
              Radius.circular(20.0),
            ),
            child: SvgPicture.asset(
              'lib/assets/images/event/main_event_banner.svg',
              fit: BoxFit.fill,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 22.0,
            vertical: 24.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Meet at Events!',
                style: AppTheme.headingFour.copyWith(
                  color: AppColours.black,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.normal,
                ),
              ),
              const Gap(12.0),
              Text(
                'Find people who share your\ninterests and make plans together.',
                style: AppTheme.simpleText.copyWith(
                  color: AppColours.black,
                  fontSize: 12.0,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

extension StringExtension on String {
  String capitalize() {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1)}';
  }
}
