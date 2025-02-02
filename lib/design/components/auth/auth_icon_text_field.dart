import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:glint_frontend/design/common/app_colours.dart';

enum IconTextFieldType {
  email,
  password,
}

class AuthIconTextField extends StatefulWidget {
  const AuthIconTextField({
    super.key,
    required this.controller,
    required this.type,
    required this.hintText,
    required this.isTextFieldFocused,
    required this.onTap,
    this.focusNode,
  });

  final TextEditingController controller;
  final IconTextFieldType type;
  final String hintText;
  final bool isTextFieldFocused;
  final VoidCallback? onTap;
  final FocusNode? focusNode;

  @override
  State<AuthIconTextField> createState() => _AuthIconTextFieldState();
}

class _AuthIconTextFieldState extends State<AuthIconTextField> {
  @override
  Widget build(BuildContext context) {
    const defaultBorder = BorderSide(
      color: AppColours.primaryBlue,
      width: 1.0,
    );
    return SizedBox(
      height: 56.0,
      child: Container(
        decoration: BoxDecoration(
          border: widget.isTextFieldFocused
              ? Border(
                  top: defaultBorder,
                  right: defaultBorder,
                  left: defaultBorder.copyWith(
                    width: 3.0,
                  ),
                  bottom: defaultBorder.copyWith(
                    width: 3.0,
                  ),
                )
              : Border.all(
                  color: AppColours.gray60,
                  width: 1.0,
                ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Row(
          children: [
            SizedBox(
              height: 56.0,
              child: Container(
                padding: const EdgeInsets.all(18.0),
                decoration: BoxDecoration(
                  border: Border(
                    right: BorderSide(
                      color: widget.isTextFieldFocused
                          ? AppColours.primaryBlue
                          : AppColours.gray60,
                      width: 1.0,
                    ),
                  ),
                ),
                child: widget.type == IconTextFieldType.email
                    ? SvgPicture.asset(
                        'lib/assets/icons/email_icon.svg',
                      )
                    : SvgPicture.asset(
                        'lib/assets/icons/lock_icon.svg',
                      ),
              ),
            ),
            Expanded(
              child: TextField(
                controller: widget.controller,
                onTap: widget.onTap,
                focusNode: widget.focusNode,
                decoration: InputDecoration(
                  hintText: widget.hintText,
                  hintStyle: const TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
