import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:glint_frontend/design/exports.dart';

class GlintAppBar extends StatelessWidget implements PreferredSizeWidget {
  const GlintAppBar({
    super.key,
    this.isProfileScreen = false,
  });

  final bool? isProfileScreen;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColours.white,
      scrolledUnderElevation: 0,
      centerTitle: false,
      titleSpacing: 0,
      title: Padding(
        padding: EdgeInsets.only(
          left: isProfileScreen == true ? 24.0 : 20.0,
        ),
        child: SvgPicture.asset(
          'lib/assets/icons/glint_logo.svg',
        ),
      ),
      actions: [
        if (isProfileScreen == true) ...[
          GestureDetector(
            onTap: () {
              //todo - rollback functionality
            },
            child: SvgPicture.asset(
              'lib/assets/icons/settings_icon.svg',
            ),
          ),
          const Gap(4.0),
        ],

        if (isProfileScreen == false) ...[
          GestureDetector(
            onTap: () {
              //todo - rollback functionality
            },
            child: SvgPicture.asset(
              'lib/assets/icons/glint_rollback.svg',
            ),
          ),
          const Gap(18.0),
          GestureDetector(
            onTap: () {
              //todo - navigate to like screen
            },
            child: SvgPicture.asset(
              'lib/assets/icons/glint_heart.svg',
            ),
          ),
          const Gap(18.0),
          GestureDetector(
            onTap: () {
              //todo - navigate to notifications screen
            },
            child: SvgPicture.asset(
              'lib/assets/icons/glint_bell.svg',
            ),
          ),
          const Gap(18.0),
          GestureDetector(
            onTap: () {
              //todo - navigate to filter screen
            },
            child: SvgPicture.asset(
              'lib/assets/icons/glint_filter.svg',
            ),
          ),
        ],

        const Gap(20.0), // for design replication purpose
      ],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
