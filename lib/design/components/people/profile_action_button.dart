import 'package:flutter/material.dart';

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
        padding: const EdgeInsets.all(16),
      ),
      child: ImageIcon(
        AssetImage(icon),
        color: Colors.white,
      ),
    );
  }
}
