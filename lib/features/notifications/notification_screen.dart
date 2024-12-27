import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:glint_frontend/design/exports.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const GlintCustomAppBar(
        title: 'Notifications',
        subtitle: 'Never miss a moment that matters.',
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 18.0,
        ),
        child: Column(
          children: [
            _buildNotificationScreenBanner(),
          ],
        ),
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
              const SizedBox(height: 8.0),
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
}
