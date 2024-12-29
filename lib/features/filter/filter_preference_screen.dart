import 'package:flutter/material.dart';
import 'package:glint_frontend/design/exports.dart';

class FilterPreferenceScreen extends StatelessWidget {
  const FilterPreferenceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColours.white,
      appBar: AppBar(
        backgroundColor: AppColours.white, // Matches the screen background
      ),
      body: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: GlintFilterPrefsCard(),
      ),
      bottomNavigationBar: const SizedBox(height: 120.0),
    );
  }
}
