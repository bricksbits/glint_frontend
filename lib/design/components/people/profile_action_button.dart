import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileActionButton extends StatelessWidget {
  final String icon;
  final Color color;
  final VoidCallback onPressed;

  const ProfileActionButton({
    super.key,
    required this.icon,
    required this.color,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        shape: const CircleBorder(),
        fixedSize: const Size(54, 54),
      ),
      child: SvgPicture.asset(
        icon,
        width: 28,
        height: 28,
        alignment: Alignment.center,
      ),
    );
  }
}
