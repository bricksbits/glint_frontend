import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:glint_frontend/design/exports.dart';

class InterestAndVibeSelection extends StatefulWidget {
  const InterestAndVibeSelection({super.key});

  @override
  State<InterestAndVibeSelection> createState() =>
      _InterestAndVibeSelectionState();
}

class _InterestAndVibeSelectionState extends State<InterestAndVibeSelection> {
  final Set<String> _selectedInterests = {};

  final Map<String, List<Map<String, String>>> categories = {
    'Hobbies & Creativity': [
      {'icon': '🎨', 'label': 'Drawing'},
      {'icon': '📸', 'label': 'Photography'},
      {'icon': '🧁', 'label': 'Baking'},
      {'icon': '🍴', 'label': 'Cooking'},
      {'icon': '✍️', 'label': 'Writing'},
      {'icon': '💃', 'label': 'Dance'},
      {'icon': '🎨', 'label': 'Crafting'},
      {'icon': '🔨', 'label': 'DIY Projects'},
    ],
    'Entertainment': [
      {'icon': '🎬', 'label': 'Movies'},
      {'icon': '💃', 'label': 'Bollywood'},
      {'icon': '🎵', 'label': 'Music'},
      {'icon': '🎵', 'label': 'Folk music'},
      {'icon': '🎮', 'label': 'Video Games'},
      {'icon': '🎯', 'label': 'Anime'},
      {'icon': '📺', 'label': 'TV Shows'},
      {'icon': '🎙️', 'label': 'Podcasts'},
      {'icon': '🏈', 'label': 'Sports'},
      {'icon': '🎙️', 'label': 'Stand-Up Comedy'},
    ],
    'Sports': [
      {'icon': '🏃', 'label': 'Running'},
      {'icon': '🏊', 'label': 'Swimming'},
      {'icon': '💪', 'label': 'Gym'},
      {'icon': '🚲', 'label': 'Cycling'},
      {'icon': '⚽', 'label': 'Football'},
      {'icon': '🏀', 'label': 'Basketball'},
      {'icon': '🏏', 'label': 'Cricket'},
      {'icon': '🏐', 'label': 'Volleyball'},
      {'icon': '🧘', 'label': 'Yoga'},
    ],
    'Lifestyle': [
      {'icon': '🕺', 'label': 'Partying & Clubbing'},
      {'icon': '🎪', 'label': 'Festivals'},
      {'icon': '💪', 'label': 'Events'},
      {'icon': '☕', 'label': 'Cafes'},
      {'icon': '✈️', 'label': 'Travelling'},
      {'icon': '🤝', 'label': 'Volunteering'},
    ],
  };

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: categories.entries.map((category) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildLabel(category.key),
              const Gap(16.0),
              _buildInterestChips(category.value),
              const Gap(24.0),
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget _buildInterestChips(List<Map<String, String>> interests) {
    return Wrap(
      spacing: 8.0,
      runSpacing: 8.0,
      children: interests.map((item) {
        final String label = item['label'] ?? '';
        final String icon = item['icon'] ?? '';
        final bool isSelected = _selectedInterests.contains(label);

        return GlintEmojiSelectionChip(
          label: label,
          icon: icon,
          isSelected: isSelected,
          onTap: () {
            setState(() {
              if (isSelected) {
                _selectedInterests.remove(label);
              } else {
                _selectedInterests.add(label);
              }
            });
          },
        );
      }).toList(),
    );
  }

  Widget _buildLabel(String label) {
    return Text(
      label,
      style: AppTheme.headingThree,
    );
  }
}
