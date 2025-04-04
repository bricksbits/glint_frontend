import 'package:flutter/material.dart';
import 'package:glint_frontend/design/common/app_colours.dart';
import 'package:glint_frontend/design/common/app_theme.dart';

class LastProfileStatusChips extends StatelessWidget {
  final String text;

  const LastProfileStatusChips({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 32.0,
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      decoration: BoxDecoration(
        color: AppColours.primaryBlue,
        borderRadius: BorderRadius.circular(24.0),
      ),
      child: Center(
        child: Text(
          text,
          style: AppTheme.simpleText.copyWith(
            color: AppColours.white,
          ),
        ),
      ),
    );
  }
}
