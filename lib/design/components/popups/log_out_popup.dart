import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:glint_frontend/design/exports.dart';

void showAccountLifecycleDialog(
  BuildContext context, {
  required IconData icon,
  required String title,
  required String subtitle,
  required String buttonText,
  required VoidCallback onAccept,
  Color? buttonabackgroundColor,
}) {
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 28.0,
            vertical: 32.0,
          ),
          decoration: BoxDecoration(
            color: AppColours.white,
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                color: AppColours.red,
                size: 24.0,
              ),
              const Gap(12.0),
              Text(
                title,
                style: AppTheme.heavyBodyText,
              ),
              const Gap(4.0),
              Text(
                subtitle,
                textAlign: TextAlign.center,
                style: AppTheme.simpleText,
              ),
              const Gap(42.0),
              SizedBox(
                width: 300,
                height: 56.0,
                child: GlintElevatedButton(
                  label: buttonText,
                  onPressed: onAccept,
                  customTextStyle: AppTheme.simpleBodyText.copyWith(
                    color: AppColours.white,
                  ),
                  backgroundColor: buttonabackgroundColor ?? AppColours.pink,
                  customBorderRadius: 10.0,
                ),
              ),
              SizedBox(
                width: 300,
                height: 56.0,
                child: GlintElevatedButton(
                  label: 'Cancel',
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  customTextStyle: AppTheme.simpleBodyText.copyWith(
                    fontWeight: FontWeight.w400,
                  ),
                  backgroundColor: Colors.transparent,
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
