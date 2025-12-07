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
  eventProfile,
}

//Todo : Create a GlintAppBar State Handler
class GlintAppBar extends StatelessWidget implements PreferredSizeWidget {
  const GlintAppBar(
      {super.key,
      this.appBarAction = GlintAppBarActions.defaultActions,
      this.eventName,
      this.eventTimeLeft});

  final GlintAppBarActions appBarAction;
  final String? eventName;
  final String? eventTimeLeft;

  List<Widget> getAppBarActions(BuildContext context) {
    switch (appBarAction) {
      case GlintAppBarActions.profile:
        return [
          GestureDetector(
            onTap: () async {
              context.pushNamed(GlintProfileRoutes.paymentHistory.name);
            },
            child: SvgPicture.asset(
              'lib/assets/icons/rupee_icon.svg',
            ),
          ),
          const Gap(20.0),
          GestureDetector(
            onTap: () async {
              context.pushNamed(GlintMainRoutes.settings.name);
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
            onTap: () async {
              context.pushNamed(GlintEventRoutes.tickets.name);
            },
            child: SvgPicture.asset(
              'lib/assets/icons/glint-ticket.svg',
            ),
          ),
          const Gap(20.0),
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
      case GlintAppBarActions.eventProfile:
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
      title: eventName != null && eventTimeLeft != null
          ? Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Row(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "$eventName",
                        style: AppTheme.simpleBodyText,
                      ),
                      Text(
                        "$eventTimeLeft days remaining...",
                        style: AppTheme.smallBodyText,
                      ),
                    ],
                  )
                ],
              ),
            )
          : Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: SvgPicture.asset(
                'lib/assets/icons/glint_logo.svg',
              ),
            ),
      //bottom border for event screen
      bottom: (appBarAction == GlintAppBarActions.event ||
              appBarAction == GlintAppBarActions.defaultActions)
          ? PreferredSize(
              preferredSize: const Size.fromHeight(1.2),
              child: Container(
                color: AppColours.borderGray,
                height: 1.2,
              ),
            )
          : null,
      actions: getAppBarActions(context),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
