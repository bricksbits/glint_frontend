import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:glint_frontend/design/exports.dart';

class GlintEmojiSelectionChip extends StatelessWidget {
  final String label;
  final String icon;
  final bool isSelected;
  final VoidCallback onTap;

  const GlintEmojiSelectionChip({
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
              style: AppTheme.simpleText.copyWith(
                fontSize: 13.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
