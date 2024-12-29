import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:glint_frontend/design/exports.dart';

class GlintEmptyState extends StatelessWidget {
  const GlintEmptyState({
    super.key,
    required this.svgPath,
    required this.title,
    required this.subtitle,
  });

  final String svgPath;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SvgPicture.asset(
          svgPath,
          alignment: Alignment.center,
        ),
        const Gap(16.0),
        Text(
          title,
          style: AppTheme.simpleBodyText.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        const Gap(4.0),
        Text(
          subtitle,
          style: AppTheme.simpleText,
        ),
        const Gap(52.0), // for design replication purpose
      ],
    );
  }
}
