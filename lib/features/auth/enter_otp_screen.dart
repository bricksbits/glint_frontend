import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:glint_frontend/design/exports.dart';
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

  @override
  void dispose() {
    // TODO: implement dispose
    _codeController.dispose();
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
            if (!isAdmin) ...[
              // enter otp heading
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
                onChanged: (pin) => {
                  setState(() {
                    if (pin.length != 6) {
                      buttonDisabled = true;
                    }
                  })
                },
                onCompleted: (pin) => {
                  setState(() {
                    buttonDisabled = false;
                  })
                },
              ),
            ),

            const Gap(50.0),

            // Confirm button
            SizedBox(
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
                        context.go(
                            "/${GlintAdminDasboardRoutes.auth.name}/${GlintAuthRoutes.recreatePassword.name}");
                        debugPrint('confirm otp button pressed');
                      },
              ),
            ),

            const Gap(20.0),

            // resend otp text
            GestureDetector(
              onDoubleTap: () {},
              onTap: () {
                // TODO - add resend otp functionality
                debugPrint('resend otp button pressed');
              },
              child: Text(
                'Resend OTP',
                style: AppTheme.simpleText.copyWith(
                  color: AppColours.primaryBlue,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),

            if (isAdmin)
              const Spacer(
                flex: 4,
              )
          ],
        ),
      ),
    );
  }
}
