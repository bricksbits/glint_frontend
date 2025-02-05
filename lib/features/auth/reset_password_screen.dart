import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:glint_frontend/design/exports.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _emailController = TextEditingController();

  final _emailFocusNode = FocusNode();

  @override
  void dispose() {
    // TODO: implement dispose
    _emailController.dispose();
    _emailFocusNode.dispose();
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
              focusNode: _emailFocusNode,
              hintText: 'Enter Email',
              isTextFieldFocused: _emailFocusNode.hasFocus,
              onTap: () {
                setState(() {
                  _emailFocusNode.requestFocus();
                });
              },
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
