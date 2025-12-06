import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:glint_frontend/design/exports.dart';

class ProfileDesignationGradientLabel extends StatelessWidget {
  final String designation;

  const ProfileDesignationGradientLabel({
    super.key,
    required this.designation,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8.0),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: Container(
          height: 38.0,
          padding: const EdgeInsets.symmetric(
            horizontal: 12.0,
          ),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.4),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Center(
            child: Text(
              designation,
              style: AppTheme.simpleText.copyWith(
                color: AppColours.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
