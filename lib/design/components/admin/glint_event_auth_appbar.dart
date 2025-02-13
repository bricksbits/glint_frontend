import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:glint_frontend/design/exports.dart';

class GlintEventAuthAppbar extends StatefulWidget
    implements PreferredSizeWidget {
  const GlintEventAuthAppbar({
    super.key,
    this.hasLogoutIcon = false,
  });

  final bool hasLogoutIcon;

  @override
  State<GlintEventAuthAppbar> createState() => _GlintEventAuthAppbarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _GlintEventAuthAppbarState extends State<GlintEventAuthAppbar> {
  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 28.0,
              vertical: 32.0,
            ),
            decoration: BoxDecoration(
              color: AppColours.white,
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.power_settings_new_outlined,
                  color: AppColours.red,
                  size: 24.0,
                ),
                const Gap(12.0),
                const Text(
                  "Logout Account",
                  style: AppTheme.heavyBodyText,
                ),
                const Text(
                  "Are you sure you want to logout?",
                  style: AppTheme.simpleText,
                ),
                const Gap(60.0),
                SizedBox(
                  width: 300,
                  height: 56.0,
                  child: GlintElevatedButton(
                    label: 'Yes, Logout',
                    onPressed: () {
                      // todo - add logout functionality
                    },
                    customTextStyle: AppTheme.simpleBodyText.copyWith(
                      color: AppColours.white,
                    ),
                    backgroundColor: AppColours.pink,
                    customBorderRadius: 10.0,
                  ),
                ),
                SizedBox(
                  width: 300,
                  height: 56.0,
                  child: GlintElevatedButton(
                    label: 'Cancel',
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    customTextStyle: AppTheme.simpleBodyText.copyWith(
                      fontWeight: FontWeight.w400,
                    ),
                    backgroundColor: Colors.transparent,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: false,
      scrolledUnderElevation: 0.0,
      backgroundColor: AppColours.white,
      title: SvgPicture.asset(
        'lib/assets/images/admin/glint_event_management_logo.svg',
      ),
      titleSpacing: 24.0,
      actions: widget.hasLogoutIcon == true
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
                    _showLogoutDialog(context);
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
}
