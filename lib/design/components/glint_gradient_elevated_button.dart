import 'package:flutter/material.dart';
import 'package:glint_frontend/design/exports.dart';

class GlintGradientElevatedButton extends StatelessWidget {
  const GlintGradientElevatedButton({
    super.key,
    required this.label,
    this.onPressed,
    required this.gradient,
  });

  final String label;
  final VoidCallback? onPressed;
  final LinearGradient gradient;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          elevation: 0,
          padding: const EdgeInsets.symmetric(
            horizontal: 24.0,
            vertical: 16.0,
          ),
        ),
        onPressed: onPressed,
        child: Text(
          label,
          style: AppTheme.simpleBodyText.copyWith(
            color: AppColours.black,
          ),
        ),
      ),
    );
  }
}
