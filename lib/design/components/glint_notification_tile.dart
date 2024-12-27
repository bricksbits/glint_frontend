import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glint_frontend/design/exports.dart';

enum NotificationTileIconState {
  event,
  match,
  stat,
}

class GlintNotificationTile extends StatelessWidget {
  const GlintNotificationTile({
    super.key,
    required this.title,
    required this.subtitle,
    this.iconState,
    this.imageUrl,
    required this.date,
  });

  final String title;
  final String subtitle;
  final NotificationTileIconState? iconState;
  final String? imageUrl;
  final DateTime date;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      minLeadingWidth: 52.0,
      minVerticalPadding: 0,
      leading: Container(
        width: 52.0,
        height: 52.0,
        decoration: BoxDecoration(
          color: AppColours.backgroundShade,
          shape: BoxShape.rectangle,
          // Showing image if given
          image: imageUrl != null
              ? DecorationImage(
                  image: NetworkImage(imageUrl!),
                )
              : null,
          borderRadius: const BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
        alignment: Alignment.center,
        // showing icon if no imageUrl
        child: imageUrl == null && iconState != null
            ? SvgPicture.asset(
                _getSvgAsset(iconState!),
                width:
                    iconState == NotificationTileIconState.stat ? 16.0 : 20.0,
                height:
                    iconState == NotificationTileIconState.stat ? 16.0 : 20.0,
                colorFilter: const ColorFilter.mode(
                  AppColours.primaryBlue,
                  BlendMode.srcIn,
                ),
              )
            : null,
      ),
      title: Text(
        title,
        style: AppTheme.simpleBodyText.copyWith(
          fontWeight: FontWeight.w700,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: AppTheme.simpleText,
      ),
      trailing: Text(
        _formatDate(date),
        textAlign: TextAlign.end,
        style: AppTheme.simpleText,
      ),
    );
  }

  // mapping svg asset path to diff icon state
  String _getSvgAsset(NotificationTileIconState state) {
    switch (state) {
      case NotificationTileIconState.event:
        return 'lib/assets/icons/event_icon.svg';
      case NotificationTileIconState.match:
        return 'lib/assets/icons/match_icon.svg';
      case NotificationTileIconState.stat:
        return 'lib/assets/icons/stat_icon.svg';
    }
  }

  // date time formatting
  String _formatDate(DateTime date) {
    final difference = DateTime.now().difference(date);
    if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else {
      return '${difference.inDays}d ago';
    }
  }
}
