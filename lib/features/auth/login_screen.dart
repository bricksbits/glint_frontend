import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:glint_frontend/design/exports.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: [
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: Column(
                children: [
                  // create account heading
                  Center(
                    child: SvgPicture.asset(
                      'lib/assets/images/auth/glint_login.svg',
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
                    hintText: 'Enter Password',
                  ),

                  const Gap(12.0),

                  // forgot your password button
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      'Forgot your password?',
                      style: AppTheme.simpleText.copyWith(
                        color: AppColours.primaryBlue,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),

                  const Gap(60.0),

                  // create account button
                  SizedBox(
                    width: screenSize.width * 0.85,
                    child: GlintElevatedButton(
                      label: 'Login',
                      customBorderRadius: 10.0,
                      customTextStyle: AppTheme.simpleBodyText.copyWith(
                        color: AppColours.white,
                      ),
                      onPressed: () {
                        // TODO - add create account functionality
                        debugPrint('Login button pressed');
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
                          text: "Don't have an account? ",
                        ),
                        TextSpan(
                          text: "Create now",
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
          ),

          // bottom glint logo illustration
          Positioned(
            bottom: 0,
            child: SvgPicture.asset(
              'lib/assets/images/auth/auth_glint_logo_illustration.svg',
            ),
          ),
        ],
      ),
    );
  }
}
