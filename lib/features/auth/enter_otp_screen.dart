import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:glint_frontend/design/exports.dart';
import 'package:glint_frontend/features/auth/blocs/reset_password/reset_password_bloc.dart';
import 'package:glint_frontend/navigation/glint_all_routes.dart';
import 'package:go_router/go_router.dart';
import 'package:pinput/pinput.dart';

class EnterOtpScreen extends StatefulWidget {
  const EnterOtpScreen({super.key});

  @override
  State<EnterOtpScreen> createState() => _EnterOtpScreenState();
}

class _EnterOtpScreenState extends State<EnterOtpScreen> {
  final bool isAdmin = true;
  final _codeController = TextEditingController();
  bool buttonDisabled = true;
  String? email;

  @override
  void initState() {
    super.initState();
    // Get email from GoRouter params
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final params = GoRouterState.of(context).uri.queryParameters;
      email = params['email'];
      if (email != null && email!.isNotEmpty) {
        context.read<ResetPasswordBloc>().add(ResetPasswordEvent.sendOtp(email!));
      }
    });
  }

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ResetPasswordBloc>(
      create: (context) => ResetPasswordBloc(),
      child: BlocListener<ResetPasswordBloc, ResetPasswordState>(
        listener: (context, state) {
          state.when(
            initial: () {},
            loading: () {},
            otpSent: () {},
            passwordResetSuccess: () {},
            error: (message) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(message),
                  backgroundColor: Colors.red,
                ),
              );
            },
          );
        },
        child: AuthStackedIllustrationScreen(
          isAdmin: isAdmin,
          body: Column(
            children: [
              if (!isAdmin) ...[
                Center(
                  child: SvgPicture.asset(
                    'lib/assets/images/auth/glint_enter_otp.svg',
                  ),
                ),
                const Gap(40.0),
              ],
              if (isAdmin) ...[
                const Spacer(),
                Text(
                  'Enter OTP',
                  style: AppTheme.headingThree.copyWith(
                    fontStyle: FontStyle.normal,
                  ),
                ),
                const Gap(32.0),
              ],
              SizedBox(
                width: double.infinity,
                child: Pinput(
                  length: 4,
                  separatorBuilder: (_) => const Gap(12.0),
                  preFilledWidget: const Text(
                    '-',
                    style: AppTheme.simpleText,
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  controller: _codeController,
                  defaultPinTheme: defaultPinTheme,
                  focusedPinTheme: focusedPinTheme,
                  submittedPinTheme: submittedPinTheme,
                  onChanged: (pin) => setState(() {
                    buttonDisabled = pin.length != 4;
                  }),
                  onCompleted: (pin) => setState(() {
                    buttonDisabled = pin.length != 4;
                  }),
                ),
              ),
              const Gap(50.0),
              BlocBuilder<ResetPasswordBloc, ResetPasswordState>(
                builder: (context, state) {
                  return SizedBox(
                    width: double.infinity,
                    child: GlintElevatedButton(
                      label: 'Confirm',
                      customBorderRadius: 10.0,
                      customTextStyle: AppTheme.simpleBodyText.copyWith(
                        color: AppColours.white,
                      ),
                      onPressed: buttonDisabled
                          ? null
                          : () {
                              if (email != null && _codeController.text.length == 4) {
                                // Here you would verify OTP with backend, for now just navigate
                                context.go('/${GlintAuthRoutes.recreatePassword.name}?email=$email&otp=${_codeController.text}');
                              }
                            },
                    ),
                  );
                },
              ),
              const Gap(20.0),
              GestureDetector(
                onTap: () {
                  if (email != null) {
                    context.read<ResetPasswordBloc>().add(ResetPasswordEvent.sendOtp(email!));
                  }
                },
                child: Text(
                  'Resend OTP',
                  style: AppTheme.simpleText.copyWith(
                    color: AppColours.primaryBlue,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              if (isAdmin) const Spacer(flex: 4),
            ],
          ),
        ),
      ),
    );
  }
}
