import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:glint_frontend/design/common/app_colours.dart';
import 'package:glint_frontend/design/components/people/profile_section_header.dart';

class ProfileCardAboutBox extends StatelessWidget {
  final String title;
  final List<Map<String, dynamic>> tags;
  final String name;

  const ProfileCardAboutBox({
    super.key,
    required this.title,
    required this.tags,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            ProfileSectionHeader(title: title),
            const Gap(4.0),
            Text(
              name,
              style: const TextStyle(
                fontFamily: 'Cambon',
                fontSize: 18,
                fontWeight: FontWeight.w400,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
        const Gap(10.0),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: tags
              .map(
                (tag) => ProfileCardAboutBoxTag(
                  icon: tag['icon'],
                  text: tag['text'],
                ),
              )
              .toList(),
        ),
        const Gap(8.0),
      ],
    );
  }
}

class ProfileCardAboutBoxTag extends StatelessWidget {
  final IconData icon;
  final String text;

  const ProfileCardAboutBoxTag(
      {super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: AppColours.chipBackgroundShade,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 16,
            color: AppColours.purpleShade,
          ),
          const SizedBox(width: 8),
          Text(
            text,
            style: const TextStyle(
                fontSize: 14,
                fontFamily: 'AlbertSans',
                color: Colors.black,
                fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }
}
