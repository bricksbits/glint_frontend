import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:glint_frontend/design/exports.dart';
import 'package:glint_frontend/navigation/glint_all_routes.dart';
import 'package:go_router/go_router.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final bool isAdmin = false;

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
      backgroundColor: AppColours.white,
      appBar: isAdmin
          ? const GlintEventAuthAppbar()
          : AppBar(
              backgroundColor: AppColours.white,
            ),
      body: AuthStackedIllustrationScreen(
        isAdmin: isAdmin,
        body: Column(
          children: [
            // create account heading
            if (isAdmin) const Spacer(),
            if (!isAdmin)
              Center(
                child: SvgPicture.asset(
                  'lib/assets/images/auth/glint_reset_password.svg',
                ),
              ),
            if (isAdmin)
              Text(
                'Reset Password',
                style: AppTheme.headingThree.copyWith(
                  fontStyle: FontStyle.normal,
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
            GlintAuthActionButton(
              label: 'Get OTP',
              onPressed: () {
                context.go(
                    "/${GlintAdminDasboardRoutes.auth.name}/${GlintAuthRoutes.otp.name}"
                );
                debugPrint('Get otp button pressed');
              },
            ),
            const Spacer(
              flex: 5,
            ),
          ],
        ),
      ),
    );
  }
}
