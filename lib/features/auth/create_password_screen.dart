import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:glint_frontend/design/exports.dart';

class CreatePasswordScreen extends StatefulWidget {
  const CreatePasswordScreen({super.key});

  @override
  State<CreatePasswordScreen> createState() => _CreatePasswordScreenState();
}

class _CreatePasswordScreenState extends State<CreatePasswordScreen> {
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  final _passwordFocusNode = FocusNode();
  final _confirmPasswordFocusNode = FocusNode();

  @override
  void dispose() {
    // TODO: implement dispose
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _passwordFocusNode.dispose();
    _confirmPasswordFocusNode.dispose();
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
                'lib/assets/images/auth/glint_create_password.svg',
              ),
            ),

            const Gap(40.0),

            // text fields
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

            const Gap(20.0),

            AuthIconTextField(
              controller: _confirmPasswordController,
              type: IconTextFieldType.password,
              focusNode: _confirmPasswordFocusNode,
              hintText: 'Retype Password',
              isTextFieldFocused: _confirmPasswordFocusNode.hasFocus,
              onTap: () {
                setState(() {
                  _confirmPasswordFocusNode.requestFocus();
                });
              },
            ),

            const Gap(50.0),

            // create account button
            SizedBox(
              width: double.infinity,
              child: GlintElevatedButton(
                label: 'Login',
                customBorderRadius: 10.0,
                customTextStyle: AppTheme.simpleBodyText.copyWith(
                  color: AppColours.white,
                ),
                onPressed: () {
                  // TODO - add login (create password) functionality
                  debugPrint('login (create password) button pressed');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
