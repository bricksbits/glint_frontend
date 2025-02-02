import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:glint_frontend/design/exports.dart';
import 'package:pinput/pinput.dart';

class EnterOtpScreen extends StatefulWidget {
  const EnterOtpScreen({super.key});

  @override
  State<EnterOtpScreen> createState() => _EnterOtpScreenState();
}

class _EnterOtpScreenState extends State<EnterOtpScreen> {
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
      appBar: AppBar(),
      body: AuthStackedIllustrationScreen(
        body: Column(
          children: [
            // enter otp heading
            Center(
              child: SvgPicture.asset(
                'lib/assets/images/auth/glint_enter_otp.svg',
              ),
            ),

            const Gap(40.0),

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
                        // TODO - add confirm otp functionality
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
            )
          ],
        ),
      ),
    );
  }
}
