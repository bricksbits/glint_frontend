import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:glint_frontend/design/exports.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColours.white,
      body: CustomScrollView(
        slivers: [
          // app bar
          const SliverGlintCustomAppBar(
            title: 'Notifications',
            subtitle: 'Never miss a moment that matters.',
          ),

          // banner
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 24.0,
              ),
              child: _buildNotificationScreenBanner(),
            ),
          ),

          // empty state (if no notifications)
          // SliverFillRemaining(
          //   hasScrollBody: false,
          //   child: _buildNotificationEmptyState(),
          // ),

          //notifications
          SliverList(
            delegate: SliverChildListDelegate(
              [
                _buildLabelWiseNotifications(
                  label: 'Today',
                  notifications: [
                    GlintNotificationTile(
                      title: 'New Matches Await!',
                      subtitle: 'Check out users in your town.',
                      iconState: NotificationTileIconState.match,
                      date: DateTime.now(),
                    ),
                    GlintNotificationTile(
                      title: 'Your Profile Stands Out!',
                      subtitle: 'You’ve received 20+ views today.',
                      iconState: NotificationTileIconState.stat,
                      date: DateTime.now(),
                    ),
                    GlintNotificationTile(
                      title: 'Got a match with Swati',
                      subtitle: 'Message to know more about her',
                      imageUrl:
                          'https://avatars.githubusercontent.com/u/70279771?v=4',
                      date: DateTime.now(),
                    ),
                  ],
                ),
                const Gap(20.0),
                _buildLabelWiseNotifications(
                  label: 'Yesterday',
                  notifications: [
                    GlintNotificationTile(
                      title: 'Event Near You!',
                      subtitle: 'Meet like-minded people IRL.',
                      iconState: NotificationTileIconState.event,
                      date: DateTime.now(),
                    ),
                    GlintNotificationTile(
                      title: 'New Matches Await!',
                      subtitle: 'Check out users in your town.',
                      iconState: NotificationTileIconState.match,
                      date: DateTime.now(),
                    ),
                    GlintNotificationTile(
                      title: 'Your Profile Stands Out!',
                      subtitle: 'You’ve received 20+ views today.',
                      iconState: NotificationTileIconState.stat,
                      date: DateTime.now(),
                    ),
                  ],
                ),
                const Gap(20.0),
                _buildLabelWiseNotifications(
                  label: 'This Week',
                  notifications: [
                    GlintNotificationTile(
                      title: 'Got a match with Swati',
                      subtitle: 'Message to know more about her',
                      imageUrl:
                          'https://avatars.githubusercontent.com/u/70279771?v=4',
                      date: DateTime.now(),
                    ),
                    GlintNotificationTile(
                      title: 'New Matches Await!',
                      subtitle: 'Check out users in your town.',
                      iconState: NotificationTileIconState.match,
                      date: DateTime.now(),
                    ),
                    GlintNotificationTile(
                      title: 'Your Profile Stands Out!',
                      subtitle: 'You’ve received 20+ views today.',
                      iconState: NotificationTileIconState.stat,
                      date: DateTime.now(),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SliverGap(16.0),
          // bottom padding basically
        ],
      ),
    );
  }

  Widget _buildNotificationScreenBanner() {
    return Stack(
      children: [
        SvgPicture.asset(
          'lib/assets/images/notification_container_illustration.svg',
          alignment: Alignment.center,
          width: double.infinity,
          height: 120.0,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 22.0,
            vertical: 24.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Want More Matches?',
                style: AppTheme.headingThree.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.normal,
                ),
              ),
              const Gap(8.0),
              Text(
                'Keep your profile\nupdated and active!',
                style: AppTheme.simpleText.copyWith(
                  color: Colors.white,
                  fontSize: 12.0,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLabelWiseNotifications({
    required String label,
    required List<GlintNotificationTile> notifications,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: AppTheme.simpleBodyText,
          ),
          const Gap(20.0),
          ...notifications,
        ],
      ),
    );
  }

  // empty state
  Widget _buildNotificationEmptyState() {
    return const GlintEmptyState(
      svgPath: 'lib/assets/icons/empty_state_bell_icon.svg',
      title: 'No updates yet',
      subtitle: 'Check out the latest events happening near you!',
    );
  }
}
