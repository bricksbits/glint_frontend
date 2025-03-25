import 'package:flutter/material.dart';
import 'package:glint_frontend/design/common/app_colours.dart';

// Todo: Add Gradient Background
class ShareProfileIconButton extends StatelessWidget {
  final VoidCallback onPressed;

  const ShareProfileIconButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 32.0,
        height: 32.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColours.white.withValues(alpha: 0.2),
        ),
        child: const Center(
          child: Icon(
            Icons.share,
            color: Colors.white,
            size: 18.0,
          ),
        ),
      ),
    );
  }
}
