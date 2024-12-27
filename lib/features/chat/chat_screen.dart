import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
          'Entry point of the chat feature, contains chat channels and other details all delegated to GetStream SDK'),
    );
  }
}
