import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:glint_frontend/design/exports.dart';

class GlintFilterPrefsCard extends StatelessWidget {
  const GlintFilterPrefsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding:
          const EdgeInsets.symmetric(horizontal: 20.0).copyWith(bottom: 24.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        // Rounded corners for the card
        image: const DecorationImage(
          image: AssetImage('lib/assets/images/filter_card_illustration.png'),
          fit: BoxFit.fill, // Fills the entire container
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'lib/assets/icons/filter_card_main_icon.svg',
            alignment: Alignment.center,
            width: 52.0,
            height: 52.0,
          ),
          const Gap(10.0),

          Text(
            'It’s a little quiet here', // Main title
            style: AppTheme.headingTwo.copyWith(fontStyle: FontStyle.normal),
          ),
          const Gap(10.0),

          const Text(
            'Try updating your preferences\n or boosting your profile!',
            textAlign: TextAlign.center,
            style: AppTheme.simpleText,
          ),
          const Gap(60.0),
          const GlintAgeDistanceCard(), // the filter card UI
          const Gap(32.0),
          SizedBox(
            width: double.infinity,
            child: GlintElevatedButton(
              label: 'Apply Changes',
              isPrimary: true,
              onPressed: () {
                //todo - Apply the selected filter changes
              },
            ),
          ),
        ],
      ),
    );
  }
}
