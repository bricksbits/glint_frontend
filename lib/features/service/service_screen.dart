import 'package:flutter/material.dart';

class ServiceScreen extends StatelessWidget {
  const ServiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => throw Exception(),
      child: const Center(
        child:
            Text("Throw an Exception for Firebase check"),
      ),
    );
  }
}
