import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:glint_frontend/design/exports.dart';
import 'package:glint_frontend/navigation/glint_all_routes.dart';
import 'package:go_router/go_router.dart';
import 'package:gradient_circular_progress_indicator/gradient_circular_progress_indicator.dart';

class ProfileInfoColumn extends StatelessWidget {
  const ProfileInfoColumn({super.key});

  @override
  Widget build(BuildContext context) {
    const progress = 0.7;
    const name = 'Shubham';
    const age = 25;

    return Column(
      children: [
        const Spacer(),
        // Profile picture
        Stack(
          alignment: Alignment.center,
          children: [
            const GradientCircularProgressIndicator(
              progress: progress,
              gradient: AppColours.circularProgressGradient,
              backgroundColor: Colors.transparent,
              stroke: 8.0,
              size: 180.0,
            ),
            ClipOval(
              child: CircleAvatar(
                radius: 75.0,
                child: CachedNetworkImage(
                  imageUrl:
                      'https://avatars.githubusercontent.com/u/70279771?v=4',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
        const Gap(18.0),

        // Profile edit button
        _buildProfileEditButton(
          progress,
          context,
        ),

        const Spacer(),

        // Profile name and age
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,
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

        const Gap(12.0),

        // Get verified text
        Text(
          'Get a Verified Badge Now!!',
          style: AppTheme.simpleBodyText.copyWith(
            fontWeight: FontWeight.w400,
          ),
        ),

        const Gap(8.0),

        const Divider(
          thickness: 0.5,
          color: AppColours.gray,
        ),
      ],
    );
  }

  Widget _buildProfileEditButton(
    double progress,
    BuildContext context,
  ) {
    return GestureDetector(
      onTap: () {
        context.pushNamed(
          GlintProfileRoutes.editProfile.name,
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 12.0,
          vertical: 8.0,
        ).copyWith(right: 8.0),
        decoration: BoxDecoration(
          color: AppColours.black,
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.edit,
              size: 16.0,
              color: AppColours.white,
            ),
            const Gap(12.0),
            Text(
              'Edit Profile',
              style: AppTheme.simpleText.copyWith(
                fontWeight: FontWeight.w700,
                color: AppColours.white,
              ),
            ),
            const Gap(12.0),

            //indicator text
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 4.0,
              ),
              decoration: BoxDecoration(
                color: AppColours.white,
                borderRadius: BorderRadius.circular(40.0),
              ),
              child: Text(
                '${(progress * 100).toInt()}%',
                style: AppTheme.simpleText.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColours.black,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
