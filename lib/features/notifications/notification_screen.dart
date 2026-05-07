import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:glint_frontend/design/exports.dart';
import 'package:glint_frontend/features/notifications/notification_cubit.dart';
import 'package:glint_frontend/features/notifications/notification_item.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NotificationCubit(),
      child: BlocBuilder<NotificationCubit, NotificationState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: AppColours.white,
            body: CustomScrollView(
              slivers: [
                const SliverGlintCustomAppBar(
                  title: 'Notifications',
                  subtitle: 'Never miss a moment that matters.',
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 24.0,
                    ),
                    child: _buildBanner(),
                  ),
                ),
                if (state.isLoading)
                  const SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(child: CircularProgressIndicator()),
                  )
                else if (state.error.isNotEmpty)
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: _buildErrorState(context),
                  )
                else if (state.notificationGroups.isEmpty)
                  const SliverFillRemaining(
                    hasScrollBody: false,
                    child: GlintEmptyState(
                      svgPath: 'lib/assets/icons/empty_state_bell_icon.svg',
                      title: 'No updates yet',
                      subtitle:
                          'Check out the latest events happening near you!',
                    ),
                  )
                else
                  ...state.notificationGroups.map(_buildGroupSliver),
                const SliverGap(24.0),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildGroupSliver(NotificationGroup group) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(group.label, style: AppTheme.simpleBodyText),
            const Gap(12.0),
            ...group.items.map(
              (item) => GlintNotificationTile(
                title: item.title,
                subtitle: item.body,
                iconState: _iconState(item.type),
                date: item.createdAt,
                isRead: item.isRead,
              ),
            ),
            const Gap(20.0),
          ],
        ),
      ),
    );
  }

  NotificationTileIconState? _iconState(NotificationType type) {
    switch (type) {
      case NotificationType.match:
        return NotificationTileIconState.match;
      case NotificationType.event:
        return NotificationTileIconState.event;
      case NotificationType.activity:
      case NotificationType.reminder:
        return NotificationTileIconState.stat;
      case NotificationType.unknown:
        return null;
    }
  }

  Widget _buildBanner() {
    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(20.0)),
            child: SvgPicture.asset(
              'lib/assets/images/notification_container_illustration.svg',
              fit: BoxFit.cover,
            ),
          ),
        ),
        Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: 22.0, vertical: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Want More Matches?',
                style: AppTheme.headingFour.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
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

  Widget _buildErrorState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Due to Server Failure, please try again later.',
            style: TextStyle(fontSize: 14, color: Colors.grey),
            textAlign: TextAlign.center,
          ),
          const Gap(16.0),
          TextButton(
            onPressed: () =>
                context.read<NotificationCubit>().fetchNotifications(),
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}
