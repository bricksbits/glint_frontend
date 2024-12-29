import 'package:flutter/material.dart';
import 'package:glint_frontend/design/exports.dart';

class FilterPreferenceScreen extends StatelessWidget {
  const FilterPreferenceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColours.white,
      appBar: GlintAppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: GlintFilterPrefsCard(),
      ),
      bottomNavigationBar: SizedBox(
        height:
            107.0, // for design replication purpose, app bar will come here.
      ),
    );
  }
}
