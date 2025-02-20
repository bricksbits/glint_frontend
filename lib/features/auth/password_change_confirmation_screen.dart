import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:glint_frontend/design/exports.dart';

class PasswordChangeConfirmationScreen extends StatelessWidget {
  const PasswordChangeConfirmationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColours.white,
      appBar: const GlintEventAuthAppbar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'lib/assets/icons/password_change.svg',
            ),
            const Gap(16.0),
            //heading
            Text(
              'Password\nSuccessfully Changed!!',
              textAlign: TextAlign.center,
              style: AppTheme.headingThree.copyWith(
                fontStyle: FontStyle.normal,
              ),
            ),

            const Gap(40.0),

            //login now button
            GlintAuthActionButton(
              label: 'Login Now',
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
