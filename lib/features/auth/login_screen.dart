import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:glint_frontend/design/exports.dart';
import 'package:glint_frontend/domain/business_logic/models/common/UsersType.dart';
import 'package:glint_frontend/features/auth/blocs/login/login_bloc.dart';
import 'package:glint_frontend/navigation/glint_all_routes.dart';
import 'package:go_router/go_router.dart';

import 'blocs/reset_password/reset_password_bloc.dart';

class LoginScreen extends StatefulWidget {
  final bool isAdmin;

  const LoginScreen({super.key, required this.isAdmin});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColours.white,
      appBar: widget.isAdmin
          ? const GlintEventAuthAppbar()
          : AppBar(
              backgroundColor: AppColours.white,
            ),
      body: BlocProvider<LoginBloc>(
        create: (context) => LoginBloc(),
        child:
            BlocListener<LoginBloc, LoginState>(listener: (myContext, state) {
          state.when(
              initial: () {},
              loading: () {},
              success: (type) {
                switch (type) {
                  case UsersType.USER:
                    myContext.go("/${GlintMainRoutes.home.name}");
                  case UsersType.ADMIN:
                    myContext.go("/${GlintAdminDasboardRoutes.home.name}");
                  case UsersType.SUPER_ADMIN:
                    myContext.go("/${GlintAdminDasboardRoutes.home.name}");
                }
              },
              error: (error) {
                ScaffoldMessenger.of(myContext).showSnackBar(
                  SnackBar(content: Text('Login Error: $error')),
                );
              },
              emailChanged: (emailChanged) {},
              passwordChanged: (password) {});
        }, child: BlocBuilder<LoginBloc, LoginState>(
          builder: (context, state) {
            return state.when(
              initial: () {
                return AuthStackedIllustrationScreen(
                  isAdmin: widget.isAdmin,
                  body: Column(
                    children: [
                      if (!widget.isAdmin)
                        Center(
                          child: SvgPicture.asset(
                              'lib/assets/images/auth/glint_login.svg'),
                        ),
                      const Gap(40.0),
                      if (widget.isAdmin)
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 40.0),
                            child: Column(
                              children: [
                                const Spacer(),
                                Text(
                                  'Login',
                                  style: AppTheme.headingThree
                                      .copyWith(fontStyle: FontStyle.normal),
                                ),
                                const Gap(32.0),
                                _buildAuthFields(),
                                const Gap(60.0),
                                _buildActionButton('Log In', () {
                                  context.read<LoginBloc>()
                                    ..add(LoginEvent.emailInput(
                                        _emailController.text))
                                    ..add(
                                      LoginEvent.passwordInput(
                                          _passwordController.text),
                                    )
                                    ..add(
                                      const LoginEvent.login(),
                                    );
                                }),
                                const Gap(16.0),
                                _buildForgotPassword(),
                                const Spacer(flex: 4),
                                _buildRegisterText(),
                              ],
                            ),
                          ),
                        ),
                      if (!widget.isAdmin) ...[
                        _buildAuthFields(),
                        const Gap(12.0),
                        _buildForgotPassword(),
                        const Gap(60.0),
                        _buildActionButton(
                          'Login',
                          () {
                            context.read<LoginBloc>()
                              ..add(
                                  LoginEvent.emailInput(_emailController.text))
                              ..add(
                                LoginEvent.passwordInput(
                                    _passwordController.text),
                              )
                              ..add(
                                const LoginEvent.login(),
                              );
                          },
                        ),
                        const Gap(16.0),
                        _buildRegisterText(),
                      ],
                    ],
                  ),
                );
              },
              loading: () {
                return const Center(
                  child: Text("Loading"),
                );
              },
              success: (type) {
                return const SizedBox.shrink();
              },
              error: (errorMessage) {
                return Center(
                  child: Text("Error : $errorMessage"),
                );
              },
              emailChanged: (email) {
                return Center(
                  child: Text("Email $email"),
                );
              },
              passwordChanged: (password) {
                return Center(
                  child: Text("Email $password"),
                );
              },
            );
          },
        )),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  Widget _buildAuthFields() {
    return Column(
      children: [
        AuthIconTextField(
          controller: _emailController,
          type: IconTextFieldType.email,
          focusNode: _emailFocusNode,
          hintText: 'Enter Email',
          isTextFieldFocused: _emailFocusNode.hasFocus,
          onTap: () => setState(() => _emailFocusNode.requestFocus()),
        ),
        const Gap(20.0),
        AuthIconTextField(
          controller: _passwordController,
          type: IconTextFieldType.password,
          focusNode: _passwordFocusNode,
          hintText: 'Enter Password',
          isTextFieldFocused: _passwordFocusNode.hasFocus,
          onTap: () => setState(() => _passwordFocusNode.requestFocus()),
        ),
      ],
    );
  }

  Widget _buildForgotPassword() {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () async {
        final emailController =
            TextEditingController(text: _emailController.text);

        final result = await showDialog<String>(
          context: context,
          builder: (context) => AlertDialog(
            backgroundColor: AppColours.white,
            title: const Text('Forgot Password'),
            content: TextField(
              controller: emailController,
              decoration: const InputDecoration(hintText: 'Enter your email'),
              keyboardType: TextInputType.emailAddress,
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(emailController.text);
                },
                child: const Text('Send OTP'),
              ),
            ],
          ),
        );

        // Proceed if user entered something
        if (result != null && result.trim().isNotEmpty) {
          final email = result.trim();

          if (!mounted) return;

          // Show loading spinner
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => const Center(child: CircularProgressIndicator()),
          );

          // Send the OTP via bloc
          context.read<ResetPasswordBloc>().add(
                ResetPasswordEvent.sendOtp(email),
              );

          // Listen for the next state from bloc
          final bloc = context.read<ResetPasswordBloc>();
          final subscription = bloc.stream.listen((state) {
            state.maybeWhen(
              otpSent: () {
                Navigator.of(context).pop(); // Dismiss loading
                if (!context.mounted) return;

                context.pushNamed(
                  GlintAuthRoutes.otp.name,
                  pathParameters: {'email': email},
                );
              },
              error: (message) {
                Navigator.of(context).pop(); // Dismiss loading
                if (!context.mounted) return;

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(message)),
                );
              },
              orElse: () {
                debugPrint('SOMETHINS ELSE HAPPENED');
              },
            );
          });
        }
      },
      child: Align(
        alignment: widget.isAdmin ? Alignment.center : Alignment.centerRight,
        child: Text(
          'Forgot your password?',
          style: AppTheme.simpleText.copyWith(
            color: AppColours.primaryBlue,
            decoration: TextDecoration.underline,
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton(String label, VoidCallback onPressed) {
    return SizedBox(
      width: double.infinity,
      child: GlintElevatedButton(
        label: label,
        customBorderRadius: 10.0,
        customTextStyle: AppTheme.simpleBodyText.copyWith(
          color: AppColours.white,
        ),
        onPressed: onPressed,
      ),
    );
  }

  Widget _buildRegisterText() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: AppTheme.simpleText,
        children: [
          const TextSpan(text: "Don't have an account? "),
          TextSpan(
            text: widget.isAdmin ? "Register now" : "Create now",
            style: const TextStyle(
              color: AppColours.primaryBlue,
              decoration: TextDecoration.underline,
              fontWeight: FontWeight.w600,
            ),
            recognizer: TapGestureRecognizer()..onTap = () {},
          ),
        ],
      ),
    );
  }
}
