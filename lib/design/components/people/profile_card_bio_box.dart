import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:glint_frontend/design/common/app_colours.dart';
import 'package:glint_frontend/design/common/app_theme.dart';

import 'profile_section_header.dart';

class ProfileCardBioBox extends StatelessWidget {
  final String content;

  const ProfileCardBioBox({
    super.key,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const ProfileSectionHeader(title: 'Bio'),
        const Gap(16.0),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
            horizontal: 18.0,
            vertical: 14.0,
          ),
          decoration: BoxDecoration(
            color: AppColours.chipBackgroundShade,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                'lib/assets/icons/quote_icon.svg',
              ),
              const Gap(16.0),
              Text(
                content,
                style: AppTheme.simpleText,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
