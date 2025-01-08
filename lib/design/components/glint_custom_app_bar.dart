import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:glint_frontend/design/exports.dart';
import 'package:go_router/go_router.dart';

class SliverGlintCustomAppBar extends StatelessWidget {
  const SliverGlintCustomAppBar({
    super.key,
    required this.title,
    this.subtitle,
  });

  final String title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: AppColours.white,
      elevation: 0,
      scrolledUnderElevation: 0,
      floating: true,
      pinned: true,
      expandedHeight: subtitle == null ? 120.0 : 144.0,
      // go back button
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back,
          color: Colors.black,
          size: 24,
        ),
        onPressed: () => context.pop(),
      ),
      // bottom border
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(0.5),
        child: Container(
          height: 0.5,
          color: const Color(0xFFE5E5E5),
        ),
      ),
      // main content
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: EdgeInsets.zero,
        collapseMode: CollapseMode.parallax,
        centerTitle: false,
        background: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTheme.headingTwo,
                ),
                if (subtitle != null) ...[
                  const Gap(4.0),
                  Text(
                    subtitle!,
                    style: AppTheme.simpleText,
                  ),
                ],
                const Gap(24.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
