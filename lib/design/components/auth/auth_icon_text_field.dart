import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:glint_frontend/design/common/app_colours.dart';

enum IconTextFieldType {
  email,
  password,
  organization,
  user,
  contact,
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
  String getIcon(IconTextFieldType type) {
    switch (type) {
      case IconTextFieldType.email:
        return 'lib/assets/icons/email_icon.svg';
      case IconTextFieldType.password:
        return 'lib/assets/icons/lock_icon.svg';
      case IconTextFieldType.organization:
        return 'lib/assets/icons/organization.svg';
      case IconTextFieldType.contact:
        return 'lib/assets/icons/contact_icon.svg';
      case IconTextFieldType.user:
        return 'lib/assets/icons/user_icon.svg';
    }
  }

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
                child: SizedBox(
                  width: 20.0,
                  height: 20.0,
                  child: SvgPicture.asset(
                    getIcon(widget.type),
                  ),
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
                  hintStyle: const TextStyle(
                    color: Colors.grey,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w300,
                  ),
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
