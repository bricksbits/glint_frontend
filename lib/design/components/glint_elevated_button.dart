import 'package:flutter/material.dart';
import 'package:glint_frontend/design/common/app_colours.dart';

class GlintElevatedButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool isPrimary;
  final bool isCancel;

  const GlintElevatedButton({
    super.key,
    required this.label,
    this.onPressed,
    this.isPrimary = true,
    this.isCancel = false,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: _getBackgroundColor(),
        foregroundColor: _getForegroundColor(),
        shadowColor: Colors.transparent,
        textStyle: const TextStyle(fontWeight: FontWeight.bold),
        disabledBackgroundColor: Colors.grey[400],
        disabledForegroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      ),
      onPressed: onPressed,
      child: Text(label),
    );
  }

  Color _getBackgroundColor() {
    if (onPressed == null) return AppColours.neutral50;
    if (!isPrimary) return AppColours.pink;
    return isCancel ? AppColours.error400 : AppColours.neutral50;
  }

  Color _getForegroundColor() {
    if (onPressed == null) return Colors.white;
    if (!isPrimary) return isCancel ? Colors.red[600]! : Colors.blue[800]!;
    return Colors.white;
  }
}