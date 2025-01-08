import 'package:flutter/material.dart';
import 'package:glint_frontend/design/components/exports.dart';

class GlintInterestsSelection extends StatefulWidget {
  const GlintInterestsSelection({super.key});

  @override
  State<GlintInterestsSelection> createState() => _InterestsSelectionState();
}

class _InterestsSelectionState extends State<GlintInterestsSelection> {
  Set<String> selectedInterests = {
    'Photography',
    'Yoga',
    'Travelling',
  };

  final List<Map<String, String>> interests = [
    {
      'label': 'Photography',
      'icon': '📸',
    },
    {
      'label': 'Stand-Up Comedy',
      'icon': '🎙',
    },
    {
      'label': 'Bollywood',
      'icon': '💃🏻',
    },
    {
      'label': 'Music',
      'icon': '🎧',
    },
    {
      'label': 'Yoga',
      'icon': '🧘',
    },
    {
      'label': 'Festivals',
      'icon': '🎊',
    },
    {
      'label': 'Travelling',
      'icon': '✈️',
    },
  ];

  void toggleInterest(String interest) {
    setState(() {
      if (selectedInterests.contains(interest)) {
        selectedInterests.remove(interest);
      } else {
        selectedInterests.add(interest);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: interests.map((interest) {
        return GlintEmojiSelectionChip(
          label: interest['label']!,
          icon: interest['icon']!,
          isSelected: selectedInterests.contains(interest['label']),
          onTap: () => toggleInterest(interest['label']!),
        );
      }).toList(),
    );
  }
}
