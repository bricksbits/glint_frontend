import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:glint_frontend/design/components/exports.dart';

class ProfileInterestVibeBox extends StatelessWidget {
  const ProfileInterestVibeBox({
    super.key,
    required this.interests,
  });

  final List<Map<String, String>> interests;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ProfileSectionHeader(title: 'Interests & Vibe'),
          const Gap(16.0),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: interests.map((interest) {
              return GlintEmojiSelectionChip(
                label: interest['label']!,
                icon: interest['icon']!,
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
