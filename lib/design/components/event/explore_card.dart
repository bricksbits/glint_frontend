import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:glint_frontend/design/exports.dart';

class ExploreCard extends StatelessWidget {
  const ExploreCard({
    super.key,
    required this.imagePath,
    required this.title,
    required this.subtitle,
  });

  final String imagePath;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          child: ClipRRect(
            borderRadius: const BorderRadius.all(
              Radius.circular(20.0),
            ),
            child: Image.asset(
              imagePath,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 22.0,
            vertical: 24.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppTheme.headingThree.copyWith(
                  color: AppColours.white,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.normal,
                ),
              ),
              const Gap(12.0),
              Text(
                subtitle,
                overflow: TextOverflow.clip,
                style: AppTheme.simpleText.copyWith(
                  color: AppColours.white,
                  fontSize: 12.0,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
