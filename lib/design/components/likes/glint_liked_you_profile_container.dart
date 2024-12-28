import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:glint_frontend/design/exports.dart';

class GlintLikedYouProfileContainer extends StatelessWidget {
  const GlintLikedYouProfileContainer({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.age,
  });

  final String imageUrl;
  final String name;
  final int age;

  @override
  Widget build(BuildContext context) {
    const bool isBlur = true; // toggle blur effect
    return Stack(
      children: [
        // Blurred Background Image
        Positioned.fill(
          child: ClipRRect(
            borderRadius: const BorderRadius.all(
              Radius.circular(20.0),
            ),
            child: Stack(
              children: [
                CachedNetworkImage(
                  imageUrl: imageUrl,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator.adaptive(),
                  ),
                  errorWidget: (context, url, error) => const Center(
                    child: Icon(Icons.error),
                  ),
                ),
                BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: isBlur ? 10.0 : 0,
                    sigmaY: isBlur ? 10.0 : 0,
                  ),
                  child: Container(
                    color: Colors.white.withAlpha(0),
                  ),
                ),
              ],
            ),
          ),
        ),

        // dark overlay
        Positioned.fill(
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(
                  20.0,
                ),
              ),
              gradient: LinearGradient(
                colors: [
                  Colors.transparent,
                  Colors.transparent,
                  Colors.black38,
                  Colors.black54,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
        ),

        // Foreground Text
        Positioned.fill(
          child: Padding(
            padding: const EdgeInsets.only(
              bottom: 20.0,
              left: 20.0,
            ),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: RichText(
                text: TextSpan(
                  text: '${name[0].toUpperCase()}, ',
                  style: AppTheme.simpleText.copyWith(
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    fontSize: 20.0,
                  ),
                  children: [
                    TextSpan(
                      text: age.toString(),
                      style: AppTheme.headingThree.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 20.0,
                        fontStyle: FontStyle.normal,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
