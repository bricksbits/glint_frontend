import 'package:flutter/material.dart';

class FilterPreferenceScreen extends StatelessWidget {
  const FilterPreferenceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
          'Filter Screen, where the last value will get save to shared Prefs'),
    );
  }
}
