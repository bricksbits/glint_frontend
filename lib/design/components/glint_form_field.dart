import 'package:flutter/material.dart';
import 'package:glint_frontend/design/common/app_colours.dart';

class GlintFormField extends StatelessWidget {
  final String label;

  const GlintFormField({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: label,
        enabledBorder: UnderlineInputBorder(
          borderSide: const BorderSide(color: AppColours.primaryBlue, width: 2),
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide:
              const BorderSide(color: AppColours.primaryBlue, width: 2.5),
          borderRadius: BorderRadius.circular(12),
        ),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      ),
    );
  }
}
