import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:glint_frontend/design/components/people/profile_designation_gradient_label.dart';
import 'package:glint_frontend/design/exports.dart';

class ProfileNameAndDetailColumn extends StatelessWidget {
  final String name;
  final String age;
  final bool isPremiumUser;
  final String distance;
  final String views;
  final String designation;

  const ProfileNameAndDetailColumn({
    super.key,
    required this.name,
    required this.distance,
    required this.views,
    required this.age,
    required this.isPremiumUser,
    required this.designation,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ProfileDesignationGradientLabel(designation: designation),

        const Gap(16.0),

        // name and age
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                RichText(
                  text: TextSpan(
                    text: '${getFirstName(name)},',
                    style: AppTheme.headingTwo.copyWith(
                      fontStyle: FontStyle.normal,
                      color: AppColours.white,
                    ),
                    children: [
                      TextSpan(
                        text: ' $age',
                        style: AppTheme.headingTwo.copyWith(
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
                          color: AppColours.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            if (isPremiumUser) ...[
              const Gap(8.0),
              SvgPicture.asset(
                'lib/assets/icons/verified_badge.svg',
                width: 20.0,
                height: 20.0,
              ),
            ],
          ],
        ),

        const Gap(12.0),

        Row(
          children: [
            SvgPicture.asset(
              'lib/assets/icons/location_icon.svg',
              width: 16.0,
              height: 16.0,
              colorFilter: const ColorFilter.mode(
                AppColours.white,
                BlendMode.srcIn,
              ),
            ),
            const Gap(10.0),
            RichText(
              text: TextSpan(
                text: distance,
                style: AppTheme.simpleText.copyWith(
                  fontStyle: FontStyle.normal,
                  color: AppColours.white,
                  fontWeight: FontWeight.w700,
                ),
                children: [
                  TextSpan(
                    text: ' Km away',
                    style: AppTheme.simpleText.copyWith(
                      fontStyle: FontStyle.normal,
                      color: AppColours.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),

        const Gap(8.0),

        Row(
          children: <Widget>[
            SvgPicture.asset(
              'lib/assets/icons/notification_stat_icon.svg',
              width: 12.0,
              height: 12.0,
              colorFilter: const ColorFilter.mode(
                AppColours.white,
                BlendMode.srcIn,
              ),
            ),
            const Gap(10.0),
            RichText(
              text: TextSpan(
                text: views,
                style: AppTheme.simpleText.copyWith(
                  fontStyle: FontStyle.normal,
                  color: AppColours.white,
                  fontWeight: FontWeight.w700,
                ),
                children: [
                  TextSpan(
                    text: ' views',
                    style: AppTheme.simpleText.copyWith(
                      fontStyle: FontStyle.normal,
                      color: AppColours.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        )
      ],
    );
  }
}

String getFirstName(String text) {
  return text.trim().split(' ').first;
}
