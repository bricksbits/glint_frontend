import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:glint_frontend/design/common/custom_snackbar.dart';
import 'package:glint_frontend/design/exports.dart';
import 'package:glint_frontend/navigation/glint_all_routes.dart';
import 'package:go_router/go_router.dart';

import 'blocs/reset_password/reset_password_bloc.dart';

class CreatePasswordScreen extends StatefulWidget {
  const CreatePasswordScreen({
    super.key,
    this.email,
    this.otp,
  });

  final String? email;
  final String? otp;

  @override
  State<CreatePasswordScreen> createState() => _CreatePasswordScreenState();
}

class _CreatePasswordScreenState extends State<CreatePasswordScreen> {
  final bool isAdmin = true;

  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  final _passwordFocusNode = FocusNode();
  final _confirmPasswordFocusNode = FocusNode();

  // Add this variable to track button state
  bool _isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    // Add listeners to controllers
    _passwordController.addListener(_validateForm);
    _confirmPasswordController.addListener(_validateForm);
  }

  @override
  void dispose() {
    _passwordController.removeListener(_validateForm);
    _confirmPasswordController.removeListener(_validateForm);
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _passwordFocusNode.dispose();
    _confirmPasswordFocusNode.dispose();
    super.dispose();
  }

  // Add validation method
  void _validateForm() {
    final password = _passwordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();

    setState(() {
      _isButtonEnabled = password.isNotEmpty &&
          confirmPassword.isNotEmpty &&
          password == confirmPassword;
    });
  }

  void _handleResetPassword() {
    if (_passwordController.text.trim() !=
        _confirmPasswordController.text.trim()) return;

    final newPassword = _passwordController.text.trim();
    if (widget.email == null || widget.otp == null) return;

    context.read<ResetPasswordBloc>().add(
          ResetPasswordEvent.resetPassword(
            widget.email!,
            widget.otp!,
            newPassword,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ResetPasswordBloc, ResetPasswordState>(
      listenWhen: (prev, current) => prev != current,
      listener: (context, state) {
        state.when(
          initial: () {},
          loading: () {},
          otpSent: () {},
          passwordResetSuccess: () {
            context.goNamed(GlintAuthRoutes.passwordSuccess.name);
          },
          error: (error) {
            showCustomSnackbar(context, message: error, isError: true);
          },
        );
      },
      child: BlocBuilder<ResetPasswordBloc, ResetPasswordState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: AppColours.white,
            appBar: isAdmin
                ? const GlintEventAuthAppbar()
                : AppBar(
                    backgroundColor: AppColours.white,
                  ),
            body: state.maybeWhen(
              loading: () => const Center(
                child: CircularProgressIndicator(),
              ),
              orElse: () {
                return AuthStackedIllustrationScreen(
                  isAdmin: isAdmin,
                  body: Column(
                    children: [
                      if (!isAdmin) ...[
                        Center(
                          child: SvgPicture.asset(
                            'lib/assets/images/auth/glint_create_password.svg',
                          ),
                        ),
                        const Gap(40.0),
                      ],

                      if (isAdmin) ...[
                        const Spacer(),
                        Text(
                          'Re-Create Password',
                          style: AppTheme.headingThree.copyWith(
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                        const Gap(32.0),
                      ],

                      // text fields
                      AuthIconTextField(
                        controller: _passwordController,
                        type: IconTextFieldType.password,
                        focusNode: _passwordFocusNode,
                        hintText: 'Create Password',
                        isTextFieldFocused: _passwordFocusNode.hasFocus,
                        onChanged: (_) => _validateForm(),
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
                        onChanged: (_) => _validateForm(),
                        onTap: () {
                          setState(() {
                            _confirmPasswordFocusNode.requestFocus();
                          });
                        },
                      ),

                      const Gap(50.0),

                      // create account button - Updated with validation
                      SizedBox(
                        width: double.infinity,
                        child: GlintElevatedButton(
                          label: isAdmin ? 'Confirm' : 'Login',
                          customBorderRadius: 10.0,
                          customTextStyle: AppTheme.simpleBodyText.copyWith(
                            color: AppColours.white,
                          ),
                          // Button is disabled if validation fails
                          onPressed: _isButtonEnabled
                              ? () {
                                  _handleResetPassword();
                                }
                              : null, // null disables the button
                        ),
                      ),

                      if (isAdmin) const Spacer(flex: 4),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
