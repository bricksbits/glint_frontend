import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glint_frontend/design/exports.dart';

class CreateEventSuffixIconField extends StatelessWidget {
  const CreateEventSuffixIconField({
    super.key,
    required this.child,
    this.assetPath,
    this.icon,
    required this.onPressed,
  });

  final Widget child;
  final String? assetPath;
  final IconData? icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // input field date
        GestureDetector(
          onTap: onPressed,
          child: Container(
            width: double.infinity,
            height: 56.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(
                width: 1.0,
                color: AppColours.backgroundShade,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: child,
              ),
            ),
          ),
        ),

        // suffix icon
        Positioned(
          top: 0,
          right: 0,
          child: Container(
            width: 60,
            height: 56.0,
            decoration: const BoxDecoration(
              color: AppColours.backgroundShade,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(10.0),
                bottomRight: Radius.circular(10.0),
              ),
            ),
            child: Center(
              child: assetPath != null
                  ? SvgPicture.asset(
                      assetPath!,
                      height: 22.0,
                      width: 22.0,
                    )
                  : Icon(
                      icon,
                      size: 22.0,
                      color: AppColours.primaryBlue,
                    ),
            ),
          ),
        )
      ],
    );
  }
}
