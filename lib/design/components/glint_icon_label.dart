import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:glint_frontend/design/common/app_theme.dart';

class GlintIconLabel extends StatelessWidget {
  const GlintIconLabel({
    super.key,
    required this.iconPath,
    this.svgColor,
    required this.label,
    this.style,
  });

  final String iconPath;
  final Color? svgColor;
  final String label;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          iconPath,
          colorFilter: svgColor == null
              ? null
              : ColorFilter.mode(
                  svgColor!,
                  BlendMode.srcIn,
                ),
        ),
        const Gap(10.0),
        Text(
          label,
          style: style ?? AppTheme.smallBodyText,
        ),
      ],
    );
  }
}
