import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:glint_frontend/design/exports.dart';

class InterestButton extends StatelessWidget {
  final String label;
  final String icon;
  final bool isSelected;
  final VoidCallback onTap;

  const InterestButton({
    super.key,
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(
        50.0,
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 10.0,
        ),
        decoration: BoxDecoration(
          color: isSelected ? AppColours.chipBackgroundShade : AppColours.white,
          borderRadius: BorderRadius.circular(
            50.0,
          ),
          border: Border.all(
            color: AppColours.chipBackgroundShade,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              icon,
            ),
            const Gap(10.0),
            Text(
              label,
              style: AppTheme.simpleText,
            ),
          ],
        ),
      ),
    );
  }
}

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
        return InterestButton(
          label: interest['label']!,
          icon: interest['icon']!,
          isSelected: selectedInterests.contains(interest['label']),
          onTap: () => toggleInterest(interest['label']!),
        );
      }).toList(),
    );
  }
}
