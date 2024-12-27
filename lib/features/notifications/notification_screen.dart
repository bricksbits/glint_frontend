import 'package:flutter/material.dart';
import 'package:glint_frontend/design/exports.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: GlintCustomAppBar(
        title: 'Notifications',
        subtitle: 'Never miss a moment that matters.',
      ),
      body: Center(
        child: Text(
            'Will show all the upto last week notifications, and respective events navigation logic'),
      ),
    );
  }
}
