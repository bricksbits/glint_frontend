import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:glint_frontend/design/exports.dart';

class AdminCreateEventScreen extends StatefulWidget {
  const AdminCreateEventScreen({super.key});

  @override
  State<AdminCreateEventScreen> createState() => _AdminCreateEventScreenState();
}

class _AdminCreateEventScreenState extends State<AdminCreateEventScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColours.white,
      appBar: AppBar(
        titleSpacing: 32.0,
        title: const Text(
          'Create Event',
          style: AppTheme.heavyBodyText,
        ),
        centerTitle: false,
        backgroundColor: AppColours.white,
        actions: [
          // save icon
          GestureDetector(
            onTap: () {
              // todo - add event publish functionality
            },
            child: Container(
              height: 40.0,
              width: 40.0,
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: AppColours.black,
              ),
              child: SvgPicture.asset(
                'lib/assets/icons/profile/save_icon.svg',
              ),
            ),
          ),

          //gap
          const Gap(12.0),

          // preview icon
          GestureDetector(
            onTap: () {
              // todo - add event preview functionality
            },
            child: Container(
              height: 40.0,
              width: 40.0,
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: AppColours.primaryBlue,
              ),
              child: SvgPicture.asset(
                'lib/assets/icons/profile/eye_icon.svg',
              ),
            ),
          ),

          const Gap(32.0),
        ],
      ),
    );
  }
}
