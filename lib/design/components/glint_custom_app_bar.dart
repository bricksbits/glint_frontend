import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:glint_frontend/design/common/app_theme.dart';
import 'package:go_router/go_router.dart';

class GlintCustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const GlintCustomAppBar({
    super.key,
    required this.title,
    this.subtitle,
  });

  final String title;
  final String? subtitle;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 88);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,

      // back button
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back,
          color: Colors.black,
          size: 24,
        ),
        onPressed: () => context.pop(),
      ),

      //bottom border
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(0.5),
        child: Container(
          color: const Color(0xFFE5E5E5),
          height: 0.5,
        ),
      ),

      // main content
      flexibleSpace: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20.0,
        ),
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

              // bottom spacing
              const Gap(24.0),
            ],
          ),
        ),
      ),
    );
  }
}
