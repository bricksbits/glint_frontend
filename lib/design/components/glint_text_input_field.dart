import 'package:flutter/material.dart';
import 'package:glint_frontend/design/common/app_colours.dart';
import 'package:glint_frontend/design/common/app_theme.dart';

class GlintTextInputField extends StatelessWidget {
  const GlintTextInputField(
      {super.key,
      required this.controller,
      this.hintText,
      this.isCenter = false,
      this.onChanged});

  final TextEditingController controller;
  final String? hintText;
  final bool? isCenter;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    const defaultBorder = BorderSide(
      color: AppColours.primaryBlue,
      width: 1.0,
    );
    return Container(
      width: double.infinity,
      height: 52.0,
      decoration: BoxDecoration(
        color: AppColours.white,
        borderRadius: BorderRadius.circular(38.0),
        border: Border(
          top: defaultBorder,
          left: defaultBorder.copyWith(width: 3.0),
          right: defaultBorder,
          bottom: defaultBorder.copyWith(width: 3.0),
        ),
      ),
      child: TextField(
        onChanged: onChanged,
        autocorrect: true,
        maxLength: 25,
        textAlign: isCenter == true ? TextAlign.center : TextAlign.start,
        controller: controller,
        cursorColor: AppColours.primaryBlue,
        style: AppTheme.simpleBodyText.copyWith(
          fontWeight: FontWeight.w400,
          fontSize: 20.0,
          color: AppColours.black,
        ),
        decoration: InputDecoration(
          counterText: '',
          // no counter
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 28.0,
            vertical: 8.0,
          ),
          hintText: hintText,
          hintStyle: AppTheme.simpleBodyText.copyWith(
            fontWeight: FontWeight.w400,
            color: AppColours.gray60,
          ),
        ),
      ),
    );
  }
}
