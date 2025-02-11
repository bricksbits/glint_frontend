import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:glint_frontend/design/exports.dart';

class GlintEventAuthAppbar extends StatelessWidget
    implements PreferredSizeWidget {
  const GlintEventAuthAppbar({
    super.key,
    this.hasLogoutIcon = false,
  });

  final bool hasLogoutIcon;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: false,
      backgroundColor: AppColours.white,
      title: SvgPicture.asset(
        'lib/assets/images/admin/glint_event_management_logo.svg',
      ),
      titleSpacing: 24.0,
      actions: hasLogoutIcon == true
          ? [
              Container(
                height: 50.0,
                width: 50.0,
                decoration: BoxDecoration(
                  color: AppColours.lightRed,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: IconButton(
                  onPressed: () {
                    // todo - add admin log out functionality
                  },
                  icon: const Icon(
                    Icons.power_settings_new_outlined,
                    color: AppColours.red,
                    size: 24.0,
                  ),
                ),
              ),
              const Gap(24.0), // for design mirroring purpose
            ]
          : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
