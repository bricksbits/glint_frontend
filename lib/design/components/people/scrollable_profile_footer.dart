import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:glint_frontend/design/exports.dart';

class ScrollableProfileFooter extends StatelessWidget {
  const ScrollableProfileFooter({
    super.key,
    required this.onLikedProfile,
    required this.onDiLikedProfile,
  });

  final VoidCallback onLikedProfile;
  final VoidCallback onDiLikedProfile;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180.0,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: () {
                    onDiLikedProfile();
                  },
                  child: Container(
                    width: 88.0,
                    height: 88.0,
                    decoration: const BoxDecoration(
                      color: AppColours.red,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.close, // Replace with your custom icon
                      color: Colors.white,
                      size: 44.0,
                    ),
                  ),
                ),
                const Gap(8.0),
                Text(
                  'Dislike',
                  style: AppTheme.simpleText.copyWith(
                    color: AppColours.black,
                  ),
                ),
              ],
            ),
            const Gap(32.0),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: () {
                    onLikedProfile();
                  },
                  child: Container(
                    width: 88.0,
                    height: 88.0,
                    decoration: const BoxDecoration(
                      color: AppColours.primaryBlue,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.favorite, // Replace with your custom icon
                      color: Colors.white,
                      size: 44.0,
                    ),
                  ),
                ),
                const Gap(8.0),
                Text(
                  'Like',
                  style: AppTheme.simpleText.copyWith(
                    color: AppColours.black,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
