import 'package:flutter/material.dart';
import 'package:glint_frontend/design/components/exports.dart';
import 'package:glint_frontend/features/people/model/emojis_mega_map.dart';

class GlintInterestsSelection extends StatefulWidget {
  const GlintInterestsSelection({super.key, required this.selectedInterests});
  final List<Map<String, String>> selectedInterests;

  @override
  State<GlintInterestsSelection> createState() => _InterestsSelectionState();
}

class _InterestsSelectionState extends State<GlintInterestsSelection> {

  void toggleInterest(String interest) {
    //Todo: better scalable logic to handle new Interests
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: widget.selectedInterests.map((interest) {
        return GlintEmojiSelectionChip(
          label: interest['label']!,
          icon: interest['icon']!,
          isSelected: true,
          onTap: () => toggleInterest(interest['label']!),
        );
      }).toList(),
    );
  }
}
