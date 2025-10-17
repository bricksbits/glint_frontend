import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:glint_frontend/design/exports.dart';

class ImLookingForCard extends StatefulWidget {
  const ImLookingForCard(
      {super.key, required this.lookingForCallback, required this.lookingFor});

  final String? lookingFor;
  final Function(String) lookingForCallback;

  @override
  State<ImLookingForCard> createState() => _ImLookingForCardState();
}

class _ImLookingForCardState extends State<ImLookingForCard> {
  String? _lookingFor;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      decoration: BoxDecoration(
        color: AppColours.backgroundShade,
        borderRadius: BorderRadius.circular(20.0),
        image: screenSize.width > 600
            ? null
            : const DecorationImage(
                image: AssetImage(
                  'lib/assets/images/onboarding/get_set_glint_illustration.png',
                ),
                fit: BoxFit.cover,
              ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 24.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              "I'm Looking For",
              style: AppTheme.headingFour.copyWith(
                fontWeight: FontWeight.w700,
                fontStyle: FontStyle.italic,
              ),
            ),
            const Gap(16.0),
            Wrap(
              spacing: 12.0,
              runSpacing: 12.0,
              children: [
                GlintCustomLabelChip(
                  label: 'Long-Term',
                  isSelected: _lookingFor == 'Long Term' ||
                      (widget.lookingFor != null &&
                          widget.lookingFor == 'Long Term'),
                  onTap: () {
                    setState(() => _lookingFor = 'Long Term');
                    widget.lookingForCallback("Long Term");
                  },
                ),
                GlintCustomLabelChip(
                  label: 'Something Casual',
                  isSelected: _lookingFor == 'Something Casual' ||
                      (widget.lookingFor != null &&
                          widget.lookingFor == 'Something Casual'),
                  onTap: () {
                    setState(() => _lookingFor = 'Something Casual');
                    widget.lookingForCallback("Something Casual");
                  },
                ),
                GlintCustomLabelChip(
                  label: 'New Friends',
                  isSelected: _lookingFor == 'New Friends' ||
                      (widget.lookingFor != null &&
                          widget.lookingFor == 'New Friends'),
                  onTap: () {
                    setState(() => _lookingFor = 'New Friends');
                    widget.lookingForCallback("New Friends");
                  },
                ),
                GlintCustomLabelChip(
                  label: 'Not Sure',
                  isSelected: _lookingFor == 'Not Sure' ||
                      (widget.lookingFor != null &&
                          widget.lookingFor == 'Not Sure'),
                  onTap: () {
                    setState(() => _lookingFor = 'Not Sure');
                    widget.lookingForCallback("Not Sure");
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
