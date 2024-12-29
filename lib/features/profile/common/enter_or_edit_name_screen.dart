import 'package:flutter/material.dart';
import 'package:glint_frontend/navigation/glint_all_routes.dart';
import 'package:go_router/go_router.dart';

class EnterOrEditNameScreen extends StatelessWidget {
  const EnterOrEditNameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.goNamed(GlintProfileRoutes.dob.name);
      },
      child: const Center(
        child: Text('Enter your name screen'),
      ),
    );
  }
}
