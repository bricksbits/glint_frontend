import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:glint_frontend/design/exports.dart';
import 'package:glint_frontend/features/auth/blocs/reset_password/reset_password_bloc.dart';
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

  StreamSubscription<ResetPasswordState>? _blocSubscription;

  @override
  void dispose() {
    // TODO: implement dispose
    _emailController.dispose();
    _emailFocusNode.dispose();
    _blocSubscription?.cancel();
    super.dispose();
  }

  void _handleGetOtp() {
    final email = _emailController.text.trim();
    if (email.isEmpty) return;
    if (!mounted) return;

    // Show loading dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    // Cancel previous subscription if exists
    _blocSubscription?.cancel();

    final bloc = context.read<ResetPasswordBloc>();
    bloc.add(ResetPasswordEvent.sendOtp(email));

    // Listen to bloc stream
    _blocSubscription = bloc.stream.listen(
      (state) {
        state.maybeWhen(
          otpSent: () {
            // Dismiss loading dialog
            if (Navigator.of(context, rootNavigator: true).canPop()) {
              Navigator.of(context, rootNavigator: true).pop();
            }

            if (!context.mounted) return;

            context.pushNamed(
              GlintAuthRoutes.otp.name,
              pathParameters: {'email': email},
            );
          },
          error: (message) {
            // Dismiss loading dialog
            if (Navigator.of(context, rootNavigator: true).canPop()) {
              Navigator.of(context, rootNavigator: true).pop();
            }

            if (!context.mounted) return;

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(message)),
            );
          },
          orElse: () {
            debugPrint('Other state received');
          },
        );
      },
    );
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
      body: BlocProvider(
        create: (context) => ResetPasswordBloc(),
        child: AuthStackedIllustrationScreen(
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
                onPressed: _handleGetOtp,
              ),
              const Spacer(
                flex: 5,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
