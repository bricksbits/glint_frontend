import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:glint_frontend/design/exports.dart';

class ProfileLocationBox extends StatelessWidget {
  const ProfileLocationBox({
    super.key,
    required this.location,
    required this.distance,
  });

  final String location;
  final String distance;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const ProfileSectionHeader(title: 'Location'),
        const Gap(16.0),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
            horizontal: 12.0,
            vertical: 8.0,
          ),
          decoration: BoxDecoration(
            color: AppColours.chipBackgroundShade,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              SvgPicture.asset(
                'lib/assets/icons/location_icon.svg',
              ),
              const Gap(12.0),
              Text(
                location,
                style: AppTheme.simpleText,
              ),
              const Spacer(),
              Text(
                '$distance Km away',
                style: AppTheme.simpleText,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
