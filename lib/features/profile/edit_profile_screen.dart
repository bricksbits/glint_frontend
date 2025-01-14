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
          bottom: 16.0,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Gap(12.0),
              // images container
              const UploadPicturesContainers(),

              //get verified
              const Gap(20.0),
              GetVerifiedWidget(
                name: 'Shubham',
                age: 21,
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
