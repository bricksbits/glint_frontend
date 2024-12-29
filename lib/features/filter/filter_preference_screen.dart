import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:glint_frontend/design/exports.dart';

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
    return Scaffold(
      backgroundColor: AppColours.white,
      body: CustomScrollView(
        slivers: [
          // app bar
          const SliverGlintCustomAppBar(
            title: 'Filter Your Preferences',
            subtitle: 'Never miss a moment that matters.',
          ),

          const SliverGap(20.0),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: _buildWhoYouWantToSeeBanner(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWhoYouWantToSeeBanner() {
    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          child: SvgPicture.asset(
            'lib/assets/images/filter_prefs_banner_illustration.svg',
            alignment: Alignment.center,
            fit: BoxFit.cover,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 24.0,
            vertical: 24.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                spacing: 12,
                runSpacing: 12,
                children: _options.map((option) {
                  final bool isSelected = _selected == option['id'];
                  return InkWell(
                    onTap: () {
                      setState(() {
                        _selected = option['id']!;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color:
                            isSelected ? const Color(0xFFE8F1FF) : Colors.white,
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(
                          color: isSelected
                              ? const Color(0xFFE8F1FF)
                              : Colors.grey.withOpacity(0.2),
                        ),
                      ),
                      child: Text(
                        option['label']!,
                        style: TextStyle(
                          color: isSelected
                              ? const Color(0xFF2563EB)
                              : Colors.grey[700],
                          fontWeight:
                              isSelected ? FontWeight.w500 : FontWeight.normal,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
