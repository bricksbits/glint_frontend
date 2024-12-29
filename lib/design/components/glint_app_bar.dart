import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:glint_frontend/design/exports.dart';

class GlintAppBar extends StatelessWidget implements PreferredSizeWidget {
  const GlintAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColours.white,
      scrolledUnderElevation: 0,
      centerTitle: false,
      titleSpacing: 0,
      title: Padding(
        padding: const EdgeInsets.only(left: 20.0),
        child: SvgPicture.asset(
          'lib/assets/icons/glint_logo.svg',
        ),
      ),
      actions: [
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

        const Gap(20.0), // for design replication purpose
      ],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
