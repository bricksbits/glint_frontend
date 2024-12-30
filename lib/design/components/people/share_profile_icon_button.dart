import 'package:flutter/material.dart';

class ShareProfileIconButton extends StatelessWidget {
  final VoidCallback onPressed;
  const ShareProfileIconButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.share),
      onPressed: onPressed,
    );
  }
}