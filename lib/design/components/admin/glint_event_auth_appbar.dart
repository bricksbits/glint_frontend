import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:glint_frontend/design/exports.dart';

class GlintEventAuthAppbar extends StatefulWidget
    implements PreferredSizeWidget {
  const GlintEventAuthAppbar({
    super.key,
    this.hasAdminActions = false,
  });

  final bool hasAdminActions;

  @override
  State<GlintEventAuthAppbar> createState() => _GlintEventAuthAppbarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _GlintEventAuthAppbarState extends State<GlintEventAuthAppbar> {
  // show edit profile and logout popup
  void _showProfileMenu(BuildContext context, RelativeRect position) {
    showMenu(
      context: context,
      position: position,
      color: AppColours.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      items: [
        PopupMenuItem(
          child: const Row(
            children: [
              Icon(Icons.edit, size: 20),
              SizedBox(width: 12),
              Text(
                'Edit Profile',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          onTap: () {
            //todo - Handle navigation edit profile
          },
        ),
        PopupMenuItem(
          child: Row(
            children: [
              Icon(Icons.logout, size: 20, color: Colors.red[400]),
              const SizedBox(width: 12),
              Text(
                'Logout',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.red[400],
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          onTap: () {
            // Handle logout
            _showLogoutDialog(context);
          },
        ),
      ],
    );
  }

  // logout dialog pop up
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
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1.0),
        child: Container(
          color: AppColours.lightGray,
          height: 1.0,
        ),
      ),
      titleSpacing: 24.0,
      actions: widget.hasAdminActions == true
          ? [
              GestureDetector(
                onTap: () {
                  final RenderBox button =
                      context.findRenderObject() as RenderBox;
                  final Offset offset = button.localToGlobal(Offset.zero);
                  _showProfileMenu(
                    context,
                    RelativeRect.fromLTRB(
                      MediaQuery.of(context).size.width - 200,
                      offset.dy + button.size.height,
                      MediaQuery.of(context).size.width - 10,
                      offset.dy + button.size.height,
                    ),
                  );
                },
                child: Container(
                  height: 50.0,
                  width: 50.0,
                  padding: const EdgeInsets.all(14.0),
                  decoration: BoxDecoration(
                    color: AppColours.backgroundShade,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: SvgPicture.asset(
                    'lib/assets/icons/user_icon.svg',
                    colorFilter: const ColorFilter.mode(
                      AppColours.primaryBlue,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
              const Gap(24.0), // for design mirroring purpose
            ]
          : null,
    );
  }
}
