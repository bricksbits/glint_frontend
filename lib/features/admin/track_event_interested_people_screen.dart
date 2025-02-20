import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:glint_frontend/design/exports.dart';

class TrackEventInterestedPeopleScreen extends StatelessWidget {
  const TrackEventInterestedPeopleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const interestedPeople = 895;
    return Scaffold(
      backgroundColor: AppColours.white,
      appBar: const GlintEventAuthAppbar(
        hasAdminActions: true,
      ),
      body: Column(
        children: [
          const Gap(32.0),

          // event info
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 28.0),
            child: EventInfoImageContainer(),
          ),

          const Gap(28.0),

          // interested people count
          Container(
            width: double.infinity,
            height: 72.0,
            padding: const EdgeInsets.symmetric(horizontal: 28.0),
            decoration: const BoxDecoration(
              color: AppColours.backgroundShade,
            ),
            child: Row(
              children: [
                // icon
                SizedBox.square(
                  dimension: 20.0,
                  child: SvgPicture.asset(
                    'lib/assets/icons/admin/users_two.svg',
                  ),
                ),

                // divider
                const Gap(16.0),

                const SizedBox(
                  height: double.infinity,
                  child: VerticalDivider(
                    thickness: 2.0,
                    color: AppColours.white,
                  ),
                ),

                const Gap(16.0),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      interestedPeople.toString(),
                      style: AppTheme.heavyBodyText.copyWith(
                        fontWeight: FontWeight.w500,
                        color: AppColours.primaryBlue,
                        fontSize: 20.0,
                      ),
                    ),
                    const Text(
                      'People are interested',
                      style: AppTheme.simpleText,
                    ),
                  ],
                ),
              ],
            ),
          ),

          const Gap(32.0),
          // list of people who are interested
          const Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 28.0),
              child: InterestedPeopleListTiles(),
            ),
          ),

          const Gap(20.0) // for design replication purpose
        ],
      ),
    );
  }
}
