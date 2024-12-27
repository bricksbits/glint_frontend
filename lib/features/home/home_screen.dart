import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
          'Home Screen, will work as the host, and contains various screens via Bottom Nav Bar'),
    );
  }
}
