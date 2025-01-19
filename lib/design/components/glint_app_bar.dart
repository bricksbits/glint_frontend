import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:glint_frontend/design/exports.dart';
import 'package:glint_frontend/navigation/glint_all_routes.dart';
import 'package:go_router/go_router.dart';

enum GlintAppBarActions {
  defaultActions,
  profile,
  event,
}

class GlintAppBar extends StatelessWidget implements PreferredSizeWidget {
  const GlintAppBar({
    super.key,
    this.appBarAction = GlintAppBarActions.defaultActions,
  });

  final GlintAppBarActions appBarAction;

  List<Widget> getAppBarActions(BuildContext context) {
    switch (appBarAction) {
      case GlintAppBarActions.profile:
        return [
          GestureDetector(
            onTap: () {
              // todo - add settings clicked functionality
            },
            child: SvgPicture.asset(
              'lib/assets/icons/settings_icon.svg',
            ),
          ),
          const Gap(20.0),
        ];
      case GlintAppBarActions.event:
        return [
          GestureDetector(
            onTap: () {
              context.pushNamed(GlintMainRoutes.filter.name);
            },
            child: SvgPicture.asset(
              'lib/assets/icons/glint_filter.svg',
            ),
          ),
          const Gap(20.0),
        ];
      case GlintAppBarActions.defaultActions:
        return [
          GestureDetector(
            onTap: () {
              // Replace with rollback functionality
            },
            child: SvgPicture.asset(
              'lib/assets/icons/glint_rollback.svg',
            ),
          ),
          const Gap(18.0),
          GestureDetector(
            onTap: () {
              context.pushNamed(GlintMainRoutes.likes.name);
            },
            child: SvgPicture.asset(
              'lib/assets/icons/glint_heart.svg',
            ),
          ),
          const Gap(18.0),
          GestureDetector(
            onTap: () {
              context.pushNamed(GlintMainRoutes.notifications.name);
            },
            child: SvgPicture.asset(
              'lib/assets/icons/glint_bell.svg',
            ),
          ),
          const Gap(18.0),
          GestureDetector(
            onTap: () {
              context.pushNamed(GlintMainRoutes.filter.name);
            },
            child: SvgPicture.asset(
              'lib/assets/icons/glint_filter.svg',
            ),
          ),
          const Gap(20.0),
        ];
    }
  }

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
      actions: getAppBarActions(context),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
