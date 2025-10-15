import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:glint_frontend/design/exports.dart';

class GetVerifiedWidget extends StatelessWidget {
  const GetVerifiedWidget({
    super.key,
    required this.name,
    required this.age,
    required this.onTap,
  });

  final String name;
  final int age;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Left Section: Name, age, badge, and subtitle
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Name Row
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Flexible(
                    child: Text.rich(
                      TextSpan(
                        text: '$name, ',
                        style: AppTheme.headingTwo.copyWith(
                          fontStyle: FontStyle.normal,
                        ),
                        children: [
                          TextSpan(
                            text: '$age',
                            style: AppTheme.headingTwo.copyWith(
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal,
                            ),
                          ),
                        ],
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),

                  const Gap(8.0),

                  // Badge
                  SvgPicture.asset(
                    'lib/assets/icons/unverified_badge.svg',
                    height: 20,
                  ),
                ],
              ),

              const Gap(8.0),

              // Subtitle
              const Text(
                'Photo verified profiles\ntend to get more matches',
                style: AppTheme.simpleText,
              ),
            ],
          ),
        ),

        const Gap(12.0),

        // Right Section: Button
        SizedBox(
          height: 68.0,
          child: GlintElevatedButton(
            label: 'Get Verified',
            onPressed: onTap,
            backgroundColor: AppColours.black,
            customBorderRadius: 70.0,
          ),
        ),
      ],
    );
  }
}
