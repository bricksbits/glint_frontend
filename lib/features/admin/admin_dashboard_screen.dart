import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:glint_frontend/design/exports.dart';

class AdminDashboardScreen extends StatelessWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String eventManagerName = 'Abhishek';
    String eventOrganizationName = 'Invisible Studios';
    return Scaffold(
      backgroundColor: AppColours.white,
      appBar: const GlintEventAuthAppbar(
        hasLogoutIcon: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28.0),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // event manager greeting
              Text(
                'Hello $eventManagerName',
                style: AppTheme.headingThree.copyWith(
                  fontStyle: FontStyle.italic,
                ),
              ),
              const Gap(8.0),

              // event manager details
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(
                    'lib/assets/icons/organization.svg',
                    colorFilter: const ColorFilter.mode(
                      AppColours.primaryBlue,
                      BlendMode.srcIn,
                    ),
                  ),
                  const Gap(10.0),
                  SizedBox(
                    height: 22.0,
                    child: VerticalDivider(
                      width: 2.0,
                      color: AppColours.gray60,
                    ),
                  ),
                  const Gap(10.0),
                  Text(
                    eventOrganizationName,
                    style: AppTheme.simpleBodyText.copyWith(
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),

              const Gap(48.0),

              // Redirect Options
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 210.0),
                    child: _buildRedirectOption(
                      label: 'Create Event',
                      icon: Icons.add,
                      onPressed: () {
                        // todo - redirect create event
                      },
                    ),
                  ),
                  const Gap(24.0),
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 210.0),
                    child: _buildRedirectOption(
                      label: 'Track Event',
                      icon: Icons.graphic_eq,
                      onPressed: () {
                        // todo - redirect track event
                      },
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRedirectOption({
    required String label,
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return Column(
      children: [
        // icon container
        Container(
          padding: const EdgeInsets.symmetric(
            vertical: 24.0,
          ),
          decoration: const BoxDecoration(
            color: AppColours.backgroundShade,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.0),
              topRight: Radius.circular(10.0),
            ),
          ),
          child: Center(
            child: IconButton(
              onPressed: onPressed,
              icon: Icon(
                icon,
                size: 32.0,
                color: AppColours.primaryBlue,
              ),
            ),
          ),
        ),

        // text container
        Container(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          decoration: const BoxDecoration(
            color: AppColours.primaryBlue,
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(10.0),
              bottomLeft: Radius.circular(10.0),
            ),
          ),
          child: Center(
            child: Text(
              label,
              style: AppTheme.simpleText.copyWith(
                color: AppColours.white,
                fontSize: 12.0,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
