import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:glint_frontend/design/exports.dart';
import 'package:glint_frontend/features/filter/filter_preferences_cubit.dart';
import 'package:go_router/go_router.dart';

class FilterPreferenceScreen extends StatefulWidget {
  const FilterPreferenceScreen({super.key});

  @override
  State<FilterPreferenceScreen> createState() => _FilterPreferenceScreenState();
}

class _FilterPreferenceScreenState extends State<FilterPreferenceScreen> {
  String _selected = 'women';

  final List<Map<String, String>> _options = [
    {'id': 'women', 'label': 'Women'},
    {'id': 'man', 'label': 'Man'},
    {'id': 'everyone', 'label': 'Everyone'},
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FilterPreferencesCubit(),
      child: BlocBuilder<FilterPreferencesCubit, FilterPreferencesState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: AppColours.white,
            body: CustomScrollView(
              slivers: [
                // app bar
                const SliverGlintCustomAppBar(
                  title: 'Filter Your Preferences',
                  subtitle: 'Never miss a moment that matters.',
                ),

                // const SliverGap(20.0),
                //
                // // who you want to see banner
                // SliverToBoxAdapter(
                //   child: Padding(
                //     padding: const EdgeInsets.symmetric(horizontal: 20.0),
                //     child: _buildWhoYouWantToSeeBanner(),
                //   ),
                // ),

                const SliverGap(20.0),

                // age and distance range selector
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: GlintAgeDistanceCard(
                      hasBorders: true,
                      collectMaxDistance: (maxDistance) {
                        context
                            .read<FilterPreferencesCubit>()
                            .updateDistancePreferences(maxDistance);
                      },
                      collectMinAndMaxAgeCallback: (min, max) {
                        context
                            .read<FilterPreferencesCubit>()
                            .updateAgePreferences(min, max);
                      },
                    ),
                  ),
                ),

                const SliverGap(20.0),

                // filter interests
                SliverToBoxAdapter(
                  child: _buildFilterInterests(),
                ),

                const SliverGap(44.0),

                // filter distance
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                    ),
                    child: GlintElevatedButton(
                      isPrimary: true,
                      onPressed: () {
                        context.pop();
                        context.read<FilterPreferencesCubit>().applyChanges();
                      },
                      label: 'Apply Changes',
                    ),
                  ),
                ),

                // bottom gap
                const SliverGap(20.0),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildWhoYouWantToSeeBanner() {
    const defaultBorder = BorderSide(
      color: AppColours.primaryBlue,
      width: 1.0,
    );
    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          child: ClipRRect(
            borderRadius: const BorderRadius.all(
              Radius.circular(20.0),
            ),
            child: SvgPicture.asset(
              'lib/assets/images/filter_prefs_banner_illustration.svg',
              alignment: Alignment.center,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned.fill(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24.0,
              vertical: 24.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: RichText(
                    text: TextSpan(
                      text: 'Who You ',
                      style: AppTheme.simpleBodyText.copyWith(
                        fontWeight: FontWeight.w400,
                      ),
                      children: [
                        TextSpan(
                          text: 'Want to See',
                          style: AppTheme.simpleBodyText.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Wrap(
                  spacing: 12.0,
                  runSpacing: 12.0,
                  children: _options.map((option) {
                    final bool isSelected = _selected == option['id'];
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selected = option['id']!;
                        });
                        // print('Selected $_selected');
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20.0,
                          vertical: 8.0,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50.0),
                          color: isSelected
                              ? AppColours.backgroundShade
                              : AppColours.white,
                          border: isSelected
                              ? const Border(
                                  bottom: BorderSide(
                                    color: AppColours.primaryBlue,
                                    width: 2.0,
                                  ),
                                  top: defaultBorder,
                                  left: defaultBorder,
                                  right: defaultBorder,
                                )
                              : null,
                        ),
                        child: Text(
                          option['label']!,
                          style: AppTheme.simpleText,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFilterInterests() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'We are working on more advance filter, keep checking for updates',
            style: AppTheme.lightText.copyWith(
              fontWeight: FontWeight.w200,
            ),
            textAlign: TextAlign.center,
          ),
          const Gap(16.0),
          const GlintInterestsSelection(
            selectedInterests: [],
          ),
        ],
      ),
    );
  }
}
