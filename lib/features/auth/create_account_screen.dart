import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:glint_frontend/design/exports.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
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
                'lib/assets/images/auth/glint_create_account.svg',
              ),
            ),

            const Gap(40.0),

            // text fields
            AuthIconTextField(
              controller: _emailController,
              type: IconTextFieldType.email,
              hintText: 'Enter Email',
            ),

            const Gap(20.0),

            AuthIconTextField(
              controller: _passwordController,
              type: IconTextFieldType.password,
              hintText: 'Create Password',
            ),

            const Gap(20.0),

            AuthIconTextField(
              controller: _confirmPasswordController,
              type: IconTextFieldType.password,
              hintText: 'Retype Password',
            ),

            const Gap(60.0),

            // create account button
            SizedBox(
              width: double.infinity,
              child: GlintElevatedButton(
                label: 'Sign Up',
                customBorderRadius: 10.0,
                customTextStyle: AppTheme.simpleBodyText.copyWith(
                  color: AppColours.white,
                ),
                onPressed: () {
                  // TODO - add create account functionality
                  debugPrint('Create account button pressed');
                },
              ),
            ),

            const Gap(16.0),

            // login button
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: AppTheme.simpleText,
                children: [
                  const TextSpan(
                    text: "Already have an account? ",
                  ),
                  TextSpan(
                    text: "Login now",
                    style: const TextStyle(
                      color: AppColours.primaryBlue,
                      decoration: TextDecoration.underline,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        // TODO - Handle Privacy Policy tap
                      },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
