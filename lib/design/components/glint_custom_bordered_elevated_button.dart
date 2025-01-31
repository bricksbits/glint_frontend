import 'package:flutter/material.dart';
import 'package:glint_frontend/design/common/app_colours.dart';

class GlintCustomBorderedElevatedButton extends StatelessWidget {
  const GlintCustomBorderedElevatedButton({
    super.key,
    required this.label,
    this.backgroundColor,
    this.customTextStyle,
    this.customBorderColor,
    this.customBorderRadius,
  });

  final String label;
  final Color? backgroundColor;
  final double? customBorderRadius;
  final TextStyle? customTextStyle;
  final Color? customBorderColor;

  @override
  Widget build(BuildContext context) {
    final defaultBorder = BorderSide(
      color: customBorderColor ?? AppColours.white,
      width: 1.0,
    );
    return SizedBox(
      width: double.infinity,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
        decoration: BoxDecoration(
          border: Border(
            top: defaultBorder,
            right: defaultBorder,
            left: defaultBorder,
            bottom: defaultBorder.copyWith(
              width: 3.0,
            ),
          ),
          borderRadius: BorderRadius.circular(
            customBorderRadius ?? 24.0,
          ),
        ),
        child: Center(
          child: Text(
            label,
            style: customTextStyle,
          ),
        ),
      ),
    );
  }
}
