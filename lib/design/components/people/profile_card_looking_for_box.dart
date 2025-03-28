import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:glint_frontend/design/common/app_colours.dart';
import 'package:glint_frontend/design/common/app_theme.dart';

import 'profile_section_header.dart';

class ProfileCardLookingForBox extends StatelessWidget {
  final String lookingFor;

  const ProfileCardLookingForBox({
    super.key,
    required this.lookingFor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const ProfileSectionHeader(title: 'Looking for'),
        const Gap(16.0),
        Stack(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                horizontal: 18.0,
                vertical: 12.0,
              ),
              decoration: BoxDecoration(
                color: AppColours.chipBackgroundShade,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Text(
                lookingFor,
                style: AppTheme.simpleText,
              ),
            ),
            Positioned(
              bottom: -2.0,
              right: 2.0,
              child: SvgPicture.asset(
                'lib/assets/icons/glint_love_logo.svg',
              ),
            ),
          ],
        )
      ],
    );
  }
}
