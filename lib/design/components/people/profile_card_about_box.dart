import 'package:flutter/material.dart';

class ProfileCardAboutBox extends StatelessWidget {
  final String title;
  final List<Map<String, dynamic>> tags;

  const ProfileCardAboutBox(
      {super.key, required this.title, required this.tags});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
          ),
        ),
        const SizedBox(height: 10),
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
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 16,
            color: Colors.blue,
          ),
          const SizedBox(width: 8),
          Text(
            text,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
