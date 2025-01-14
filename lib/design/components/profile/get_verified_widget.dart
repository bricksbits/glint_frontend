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
        //name and subtitle
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //name
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                RichText(
                  text: TextSpan(
                    text: '$name,',
                    style: AppTheme.headingTwo.copyWith(
                      fontStyle: FontStyle.normal,
                    ),
                    children: [
                      TextSpan(
                        text: ' $age',
                        style: AppTheme.headingTwo.copyWith(
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
                        ),
                      ),
                    ],
                  ),
                ),

                const Gap(12.0),

                // Verified badge
                SvgPicture.asset(
                  'lib/assets/icons/unverified_badge.svg',
                ),
              ],
            ),
            const Gap(8.0),
            // subtitle
            const Text(
              'Photo verified profiles\ntends to get more matches',
              style: AppTheme.simpleText,
            ),
          ],
        ),

        const Spacer(),

        // button

        SizedBox(
          height: 68.0,
          child: GlintElevatedButton(
            label: 'Get Verified',
            onPressed: onTap,
            backgroundColor: AppColours.black,
            customBorderRadius: 70.0,
          ),
        )
      ],
    );
  }
}
