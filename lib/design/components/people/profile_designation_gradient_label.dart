import 'package:flutter/material.dart';

class ProfileDesignationGradientLabel extends StatelessWidget {
  final String text;

  const ProfileDesignationGradientLabel({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        gradient: const RadialGradient(
          radius: 2.5,
          colors: [Colors.white, Colors.black12],
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
