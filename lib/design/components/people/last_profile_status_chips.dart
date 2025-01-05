import 'package:flutter/material.dart';
import 'package:glint_frontend/design/common/app_colours.dart';

class LastProfileStatusChips extends StatelessWidget {
  final String text;
  const LastProfileStatusChips({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppColours.primaryBlue60,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: AppColours.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
