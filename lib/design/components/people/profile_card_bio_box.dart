import 'package:flutter/material.dart';

class ProfileCardBioBox extends StatelessWidget {
  final String content;

  const ProfileCardBioBox({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        content,
        style: const TextStyle(
          fontSize: 16,
          fontStyle: FontStyle.italic,
        ),
      ),
    );
  }
}
