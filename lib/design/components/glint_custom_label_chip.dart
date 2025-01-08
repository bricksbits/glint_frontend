import 'package:flutter/material.dart';
import 'package:glint_frontend/design/exports.dart';

class GlintCustomLabelChip extends StatefulWidget {
  const GlintCustomLabelChip({
    super.key,
    required this.isSelected,
    required this.label,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback? onTap;

  @override
  State<GlintCustomLabelChip> createState() => _GlintCustomLabelChipState();
}

class _GlintCustomLabelChipState extends State<GlintCustomLabelChip> {
  @override
  Widget build(BuildContext context) {
    var defaultBorder = BorderSide(
      color: widget.isSelected ? AppColours.primaryBlue : Colors.transparent,
      width: widget.isSelected ? 1.0 : 0.7,
    );
    return GestureDetector(
      onTap: widget.onTap,
      onDoubleTap: () {},
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
        decoration: BoxDecoration(
          color:
              widget.isSelected ? AppColours.backgroundShade : AppColours.white,
          borderRadius: BorderRadius.circular(50.0),
          border: Border(
            top: defaultBorder,
            left: defaultBorder,
            right: defaultBorder,
            bottom: widget.isSelected
                ? defaultBorder.copyWith(width: 2.0)
                : defaultBorder,
          ),
        ),
        child: Text(
          widget.label,
          style: AppTheme.simpleText,
        ),
      ),
    );
  }
}
