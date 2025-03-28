import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileActionButton extends StatelessWidget {
  final String icon;
  final Color color;
  final VoidCallback onPressed;
  final bool isSmall;

  const ProfileActionButton({
    super.key,
    required this.icon,
    required this.color,
    required this.onPressed,
    this.isSmall = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: isSmall == true ? 48.0 : 52.0,
      width: isSmall == true ? 48.0 : 52.0,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: const CircleBorder(),
          padding: EdgeInsets.zero,
        ),
        child: Center(
          child: SvgPicture.asset(
            icon,
            height: 24.0,
            width: 24.0,
            alignment: Alignment.center,
          ),
        ),
      ),
    );
  }
}
