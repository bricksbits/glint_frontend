import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:glint_frontend/design/exports.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColours.white,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: AppColours.white,
        actions: [
          // save icon
          Container(
            height: 44.0,
            width: 44.0,
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: AppColours.black,
            ),
            child: SvgPicture.asset(
              'lib/assets/icons/profile/save_icon.svg',
            ),
          ),

          //gap
          const Gap(12.0),

          // preview icon
          Container(
            height: 44.0,
            width: 44.0,
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: AppColours.primaryBlue,
            ),
            child: SvgPicture.asset(
              'lib/assets/icons/profile/eye_icon.svg',
            ),
          ),

          const Gap(20.0), // for design replication purpose
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0).copyWith(
          bottom: 20.0,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(12.0),
              // images container
              const UploadPicturesContainers(),

              //get verified
              const Gap(32.0),
              GetVerifiedWidget(
                name: 'Shubham',
                age: 21,
                onTap: () {},
              ),

              const Gap(32.0),

              //im looking for card
              ImLookingForCard(
                lookingForCallback: (lookingFor) {},
              ),

              const Gap(16.0),

              // pronouns card
              YourPronounsCard(
                pronounsSelected: (pronouns) {},
              ),

              const Gap(20.0),

              // Interests and Vibe
              _buildInterestsAndVibeSections(),

              const Gap(20.0),

              // enter bio
              EnterYourBio(
                onBioCompleted: (newBio) {},
              ),

              // Additional info
              const Gap(24.0),
              const AdditionalInfoContainer(),
            ],
          ),
        ),
      ),
    );
  }

  // Interest and Vibe Selection
  Widget _buildInterestsAndVibeSections() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Interests & Vibe',
          style: AppTheme.headingFour.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        const Gap(16.0),
        const GlintInterestsSelection(),
      ],
    );
  }
}
