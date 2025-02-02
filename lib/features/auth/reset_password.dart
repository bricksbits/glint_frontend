import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:glint_frontend/design/exports.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final _emailController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: AuthStackedIllustrationScreen(
        body: Column(
          children: [
            // create account heading
            Center(
              child: SvgPicture.asset(
                'lib/assets/images/auth/glint_reset_password.svg',
              ),
            ),

            const Gap(40.0),

            // text fields
            AuthIconTextField(
              controller: _emailController,
              type: IconTextFieldType.email,
              hintText: 'Enter Email',
            ),

            const Gap(50.0),

            // create account button
            SizedBox(
              width: double.infinity,
              child: GlintElevatedButton(
                label: 'Get OTP',
                customBorderRadius: 10.0,
                customTextStyle: AppTheme.simpleBodyText.copyWith(
                  color: AppColours.white,
                ),
                onPressed: () {
                  // TODO - add get otp functionality
                  debugPrint('Get otp button pressed');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
