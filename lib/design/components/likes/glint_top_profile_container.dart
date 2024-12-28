import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../common/app_theme.dart';

class GlintTopProfileContainer extends StatelessWidget {
  const GlintTopProfileContainer({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.viewCount,
  });

  final String imageUrl;
  final String name;
  final int viewCount;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: imageUrl,
          fit: BoxFit.cover,
          imageBuilder: (context, imageProvider) {
            return Container(
              height: 165.0,
              width: 132.0,
              margin: const EdgeInsets.only(
                right: 12.0,
              ),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(
                  Radius.circular(
                    20.0,
                  ),
                ),
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
        ),

        // dark overlay
        Positioned.fill(
          child: Container(
            height: 165.0,
            width: 132.0,
            margin: const EdgeInsets.only(
              right: 12.0,
            ),
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

        // overlay main content
        Container(
          height: 165.0,
          width: 132.0,
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 14.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                name,
                style: AppTheme.headingThree.copyWith(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.normal,
                  color: Colors.white,
                ),
              ),
              const Gap(4.0),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10.0,
                  vertical: 4.0,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: Colors.black,
                ),
                child: RichText(
                  text: TextSpan(
                    text: '$viewCount',
                    style: AppTheme.simpleText.copyWith(
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      fontSize: 12.0,
                    ),
                    children: [
                      TextSpan(
                        text: ' views',
                        style: AppTheme.simpleText.copyWith(
                          color: Colors.white,
                          fontSize: 12.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
