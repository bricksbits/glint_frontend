import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:glint_frontend/design/common/app_colours.dart';
import 'package:glint_frontend/design/common/app_theme.dart';
import 'package:glint_frontend/design/components/glint_elevated_button.dart';

class EmptyPeopleStateView extends StatelessWidget {
  const EmptyPeopleStateView({
    super.key,
    required this.title,
    required this.subtitle,
    required this.buttonLabel,
    required this.onButtonPressed,
  });

  final String title;
  final String subtitle;
  final String buttonLabel;
  final VoidCallback onButtonPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'lib/assets/images/no_data_found_placeholder.jpg',
              width: 180,
              height: 180,
              fit: BoxFit.contain,
              cacheWidth: 360,
            ),
            const Gap(24),
            Text(
              title,
              style: AppTheme.heavyBodyText,
              textAlign: TextAlign.center,
            ),
            const Gap(8),
            Text(
              subtitle,
              style: AppTheme.simpleText.copyWith(color: AppColours.darkGray),
              textAlign: TextAlign.center,
            ),
            const Gap(24),
            GlintElevatedButton(
              label: buttonLabel,
              onPressed: onButtonPressed,
            ),
          ],
        ),
      ),
    );
  }
}
