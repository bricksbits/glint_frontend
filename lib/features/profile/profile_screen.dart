import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:glint_frontend/design/exports.dart';
import 'package:gradient_circular_progress_indicator/gradient_circular_progress_indicator.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColours.white,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            _buildProfileInfoColumn(),

            // subscription cards
            Expanded(
              child: Center(
                child: Text(
                  'Subscription Cards\nto be added here',
                  textAlign: TextAlign.center,
                  style: AppTheme.simpleBodyText.copyWith(
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildProfileInfoColumn() {
    const progress = 0.7;
    const name = 'Shubham';
    const age = 25;
    return Column(
      children: [
        const Gap(20.0),

        // profile picture
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

        // profile edit button
        _buildProfileEditButton(progress),

        const Gap(18.0),

        // profile name, age
        Row(
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
                      )),
                ],
              ),
            ),

            const Gap(12.0),

            //verified badge
            SvgPicture.asset(
              'lib/assets/icons/unverified_badge.svg',
            ),
          ],
        ),

        const Gap(12.0),

        // get verified text
        Text(
          'Get a Verified Badge Now!!',
          style: AppTheme.simpleBodyText.copyWith(
            fontWeight: FontWeight.w400,
          ),
        ),

        const Gap(20.0),

        const Divider(
          thickness: 0.5,
          color: AppColours.gray,
        ),
      ],
    );
  }

  Widget _buildProfileEditButton(
    double progress,
  ) {
    return Container(
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
    );
  }
}
