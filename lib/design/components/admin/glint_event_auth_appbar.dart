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
            showAccountLifecycleDialog(
              context,
              icon: Icons.power_settings_new_outlined,
              title: 'Logout Account?',
              subtitle: 'Are you sure you want to logout?',
              buttonText: 'Yes, Logout',
              onAccept: () {
                // todo - handle logout
              },
            );
          },
        ),
      ],
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
                  height: 44.0,
                  width: 44.0,
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
