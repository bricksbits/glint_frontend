import 'package:flutter/material.dart';
import 'package:glint_frontend/design/exports.dart';

class GlintAuthActionButton extends StatelessWidget {
  const GlintAuthActionButton({
    super.key,
    required this.label,
    this.onPressed,
  });

  final String label;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: GlintElevatedButton(
        label: label,
        customBorderRadius: 10.0,
        customTextStyle: AppTheme.simpleBodyText.copyWith(
          color: AppColours.white,
        ),
        onPressed: onPressed,
      ),
    );
  }
}
