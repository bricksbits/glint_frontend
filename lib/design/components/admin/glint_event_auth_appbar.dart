import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:glint_frontend/design/exports.dart';

class GlintEventAuthAppbar extends StatelessWidget
    implements PreferredSizeWidget {
  const GlintEventAuthAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: false,
      backgroundColor: AppColours.white,
      title: SvgPicture.asset(
        'lib/assets/images/admin/glint_event_management_logo.svg',
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
