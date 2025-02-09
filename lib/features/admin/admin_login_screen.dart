import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:glint_frontend/design/exports.dart';

class AdminLoginScreen extends StatefulWidget {
  const AdminLoginScreen({super.key});

  @override
  State<AdminLoginScreen> createState() => _AdminLoginScreenState();
}

class _AdminLoginScreenState extends State<AdminLoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  @override
  dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColours.white,
      appBar: const GlintEventAuthAppbar(),
      body: Column(
        children: [
          SizedBox(
            height: 180.0,
            width: double.infinity,
            child: Image.asset(
              'lib/assets/images/admin/glint_event_illustration.png',
              fit: BoxFit.cover,
            ),
          ),
          const Gap(36.0),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 28.0,
              ).copyWith(bottom: 40.0),
              child: Column(
                children: [
                  Text(
                    'Login',
                    style: AppTheme.headingThree.copyWith(
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                  const Gap(32.0),

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

                  const Gap(20.0),

                  AuthIconTextField(
                    controller: _passwordController,
                    type: IconTextFieldType.password,
                    focusNode: _passwordFocusNode,
                    hintText: 'Create Password',
                    isTextFieldFocused: _passwordFocusNode.hasFocus,
                    onTap: () {
                      setState(() {
                        _passwordFocusNode.requestFocus();
                      });
                    },
                  ),

                  const Gap(60.0),

                  // create account button
                  SizedBox(
                    width: double.infinity,
                    child: GlintElevatedButton(
                      label: 'Log In',
                      customBorderRadius: 10.0,
                      customTextStyle: AppTheme.simpleBodyText.copyWith(
                        color: AppColours.white,
                      ),
                      onPressed: () {
                        // TODO - add admin login functionality
                        debugPrint('Login button pressed');
                      },
                    ),
                  ),

                  const Gap(16.0),

                  // forget password text
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      // TODO - Handle Forget Password tap
                    },
                    child: Text(
                      'Forget your password?',
                      style: AppTheme.simpleText.copyWith(
                        fontSize: 12.0,
                        color: AppColours.primaryBlue,
                        decoration: TextDecoration.underline,
                        decorationColor: AppColours.primaryBlue,
                      ),
                    ),
                  ),

                  const Spacer(),

                  // register now text
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: AppTheme.simpleText,
                      children: [
                        const TextSpan(
                          text: "Don't have an account? ",
                        ),
                        TextSpan(
                          text: "Register now",
                          style: const TextStyle(
                            color: AppColours.primaryBlue,
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.w600,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              // TODO - Handle Register Now tap
                            },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
