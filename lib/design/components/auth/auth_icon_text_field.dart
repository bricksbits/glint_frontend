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
  });

  final TextEditingController controller;
  final IconTextFieldType type;
  final String hintText;

  @override
  State<AuthIconTextField> createState() => _AuthIconTextFieldState();
}

class _AuthIconTextFieldState extends State<AuthIconTextField> {
  bool isTextFieldFocused = false;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    const defaultBorder = BorderSide(
      color: AppColours.primaryBlue,
      width: 1.0,
    );
    return SizedBox(
      width: screenSize.width * 0.85,
      height: 56.0,
      child: Container(
        decoration: BoxDecoration(
          border: isTextFieldFocused
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
                      color: isTextFieldFocused
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
                onTap: () {
                  debugPrint('Text field tapped');
                  setState(() {
                    isTextFieldFocused = true;
                  });
                },
                onTapOutside: (_) {
                  debugPrint('Text field outside tapped');
                  setState(() {
                    isTextFieldFocused = false;
                  });
                },
                decoration: const InputDecoration(
                  hintText: 'Enter Email',
                  hintStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
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
