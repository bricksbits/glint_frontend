import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:glint_frontend/design/exports.dart';

enum FilterChipEnum {
  recent,
  mostPopular,
  saved,
}

class MainEventScreen extends StatefulWidget {
  const MainEventScreen({super.key});

  @override
  State<MainEventScreen> createState() => _MainEventScreenState();
}

class _MainEventScreenState extends State<MainEventScreen> {
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
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20.0,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Gap(30.0),
            // event banner
            _buildEventBanner(),
            const Gap(20.0),

            // filter chips
            _buildFilterChips(),
            const Gap(24.0),

            // hot events
            _buildHotEvents(),

            // hot events

            //end padding bottom
            const Gap(16.0),
          ],
        ),
      ),
    );
  }

  Widget _buildHotEvents() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Hot Events',
          style: AppTheme.headingOne.copyWith(
            fontWeight: FontWeight.w900,
          ),
        ),
        const Gap(16.0),
        const Column(
          children: [
            HotEvent(),
            const Gap(16.0),
            HotEvent(),
            const Gap(16.0),
            HotEvent(),
            const Gap(16.0),
            HotEvent(),
          ],
        )
      ],
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
                style: AppTheme.headingThree.copyWith(
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
