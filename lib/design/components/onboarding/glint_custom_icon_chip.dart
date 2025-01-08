import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:glint_frontend/design/exports.dart';

class GlintCustomIconChip extends StatelessWidget {
  const GlintCustomIconChip({
    super.key,
    required this.label,
    this.assetPath,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final String? assetPath;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final defaultBorder = BorderSide(
      color: isSelected ? AppColours.primaryBlue : AppColours.black,
      width: 1.0,
    );
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size.width * 0.55,
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 12.0,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(38.0),
          border: Border(
            top: defaultBorder,
            left: defaultBorder,
            right: defaultBorder,
            bottom: defaultBorder.copyWith(width: 3.0),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (assetPath != null) ...[
              SvgPicture.asset(
                assetPath!,
              ),
              const Spacer(),
            ],
            Text(
              label,
              style: AppTheme.simpleText,
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
