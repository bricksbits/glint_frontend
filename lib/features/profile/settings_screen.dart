import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get_it/get_it.dart';
import 'package:glint_frontend/analytics/glint_analytics_service.dart';
import 'package:glint_frontend/design/common/custom_snackbar.dart';
import 'package:glint_frontend/design/exports.dart';
import 'package:glint_frontend/domain/application_logic/logout_usecase.dart';
import 'package:glint_frontend/features/profile/settings_cubit.dart';
import 'package:glint_frontend/navigation/glint_all_routes.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileSettingsScreen extends StatelessWidget {
  const ProfileSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: false,
      backgroundColor: AppColours.backgroundShade,
      appBar: AppBar(
        backgroundColor: AppColours.white,
        centerTitle: false,
        scrolledUnderElevation: 0,
        automaticallyImplyLeading: true,
        title: const Text(
          'Settings',
          style: AppTheme.headingThree,
        ),
      ),
      body: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 12.0,
              ),
              child: Column(
                children: [
                  const Gap(12.0),
                  _buildLocationTile(context),

                  // Notification Preferences
                  const Gap(16.0),
                  _buildNotificationPrefsTile(context, state),

                  // support
                  const Gap(16.0),
                  _buildSupportTiles(context),

                  const Gap(32.0),
                  // log out button
                  SizedBox(
                    width: double.infinity,
                    child: GlintIconElevatedButton(
                      backgroundColor: AppColours.black,
                      label: Text(
                        'Log Out',
                        style: AppTheme.simpleBodyText.copyWith(
                          color: AppColours.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      onPressed: () {
                        GlintAnalyticService.onSettingLogoutEvent();
                        showAccountLifecycleDialog(
                          context,
                          icon: Icons.power_settings_new_outlined,
                          title: 'Logout Account?',
                          subtitle: 'Are you sure you want to logout?',
                          buttonText: 'Yes, Logout',
                          buttonabackgroundColor: AppColours.black,
                          onAccept: () {
                            final loginUseCase =
                                GetIt.instance.get<LogoutUserUsecase>();
                            loginUseCase.perform((success) {
                              if (success != null && success) {
                                context.goNamed(GlintMainRoutes.starter.name);
                              }
                            }, (error) {}, () {});
                          },
                        );
                      },
                    ),
                  ),

                  const Gap(12.0),

                  // delete your account button
                  SizedBox(
                    width: double.infinity,
                    child: GlintIconElevatedButton(
                      backgroundColor: AppColours.rejectedColor,
                      label: Text(
                        'Delete Your Account',
                        style: AppTheme.simpleBodyText.copyWith(
                          color: AppColours.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      onPressed: () {
                        GlintAnalyticService.onSettingLogoutEvent();
                        showAccountLifecycleDialog(
                          context,
                          icon: Icons.delete_outline_rounded,
                          title: 'Delete Glint Profile',
                          subtitle:
                              'Are you sure you want to delete your Glint Profile permanently?',
                          buttonText: 'Yes, Delete',
                          onAccept: () {
                            showCustomSnackbar(context,
                                message:
                                    "We are working on deleting User, until then please log out");
                          },
                        );
                      },
                    ),
                  ),
                  const Gap(42.0),
                  Center(
                    child: Column(
                      children: [
                        SvgPicture.asset(
                          'lib/assets/icons/glint_name_logo.svg',
                        ),
                        const Gap(4.0),
                        Text(
                          state.appVersion,
                          style: AppTheme.simpleText,
                        ),
                        const Gap(12.0),
                        const Text(
                          "Made with ❤️ in Bhilai",
                          style: AppTheme.simpleText,
                        ),
                      ],
                    ),
                  ),
                  const Gap(12.0),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildLocationTile(BuildContext context) => const _LocationTile();

  Widget _buildSupportTiles(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColours.white,
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(
          color: AppColours.borderGray,
          width: 1.0,
        ),
      ),
      child: Column(
        children: [
          ListTile(
            contentPadding: const EdgeInsets.only(left: 24.0, right: 8.0),
            leading: SvgPicture.asset(
              'lib/assets/icons/glint_contactUs.svg',
            ),
            title: const Text(
              'Contact Us',
              style: AppTheme.simpleBodyText,
            ),
            trailing: IconButton(
              onPressed: () {
                GlintAnalyticService.onSettingContactUsEvent();
                launchUrl(
                  Uri.parse('https://glintapp.io'),
                  mode: LaunchMode.externalApplication,
                );
              },
              icon: const Icon(
                Icons.arrow_forward_rounded,
              ),
              color: AppColours.black,
            ),
          ),
          const Divider(
            color: AppColours.borderGray,
          ),
          ListTile(
            contentPadding: const EdgeInsets.only(left: 24.0, right: 8.0),
            leading: SvgPicture.asset(
              'lib/assets/icons/glint_faq.svg',
            ),
            title: const Text(
              'FAQs',
              style: AppTheme.simpleBodyText,
            ),
            trailing: IconButton(
              onPressed: () {
                GlintAnalyticService.onSettingFaqEvent();
                launchUrl(
                  Uri.parse('https://glintapp.io/#faqs'),
                  mode: LaunchMode.externalApplication,
                );
              },
              icon: const Icon(
                Icons.arrow_forward_rounded,
              ),
              color: AppColours.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationPrefsTile(
      BuildContext context, SettingsState state) {
    return Container(
      padding: const EdgeInsets.only(bottom: 12.0),
      decoration: BoxDecoration(
        color: AppColours.white,
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(
          color: AppColours.borderGray,
          width: 1.0,
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10.0)
                    .copyWith(right: 16.0, bottom: 4.0),
            child: Row(
              children: [
                SvgPicture.asset(
                  'lib/assets/icons/glint_bell.svg',
                  placeholderBuilder: (context) =>
                      const Icon(Icons.notifications),
                ),
                const Gap(12.0),
                Text(
                  'Allow Notifications',
                  style: AppTheme.simpleBodyText.copyWith(
                    color: AppColours.black,
                  ),
                ),
                const Spacer(),
                Switch.adaptive(
                  value: state.isNotificationsEnabled,
                  activeColor: AppColours.primaryBlue,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  onChanged: (value) {
                    GlintAnalyticService.onNotificationSettingsUpdateEvent();
                    context.read<SettingsCubit>().toggleNotifications(value);
                  },
                ),
              ],
            ),
          ),
          const Divider(color: AppColours.borderGray),
          const Gap(12.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0)
                .copyWith(right: 16.0),
            child: Column(
              children: [
                _buildNotificationSwitch(
                  context,
                  'Matches',
                  'New matches, super likes & stories',
                  state.isMatchesEnabled,
                  state.isNotificationsEnabled,
                  (value) => context.read<SettingsCubit>().toggleMatches(value),
                ),
                const Gap(8.0),
                _buildNotificationSwitch(
                  context,
                  'Events',
                  'New events near you & approvals',
                  state.isEventsEnabled,
                  state.isNotificationsEnabled,
                  (value) => context.read<SettingsCubit>().toggleEvents(value),
                ),
                const Gap(8.0),
                _buildNotificationSwitch(
                  context,
                  'Tickets',
                  'Bookings, cancellations & refunds',
                  state.isTicketsEnabled,
                  state.isNotificationsEnabled,
                  (value) => context.read<SettingsCubit>().toggleTickets(value),
                ),
                const Gap(8.0),
                _buildNotificationSwitch(
                  context,
                  'Reminders',
                  'Event reminders & membership alerts',
                  state.isRemindersEnabled,
                  state.isNotificationsEnabled,
                  (value) =>
                      context.read<SettingsCubit>().toggleReminders(value),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationSwitch(
    BuildContext context,
    String label,
    String subtitle,
    bool value,
    bool isNotificationsEnabled,
    ValueChanged<bool> onChanged,
  ) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: AppTheme.simpleText),
              const Gap(2.0),
              Text(
                subtitle,
                style: AppTheme.simpleText.copyWith(
                  fontSize: 11.0,
                  color: AppColours.darkGray,
                ),
              ),
            ],
          ),
        ),
        Switch.adaptive(
          value: value,
          activeColor: AppColours.primaryBlue,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          onChanged: !isNotificationsEnabled ? null : onChanged,
        ),
      ],
    );
  }
}

class _LocationTile extends StatefulWidget {
  const _LocationTile();

  @override
  State<_LocationTile> createState() => _LocationTileState();
}

class _LocationTileState extends State<_LocationTile> {
  final _locationController = TextEditingController();

  @override
  void dispose() {
    _locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 22.0),
      decoration: BoxDecoration(
        color: AppColours.white,
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(
          color: AppColours.borderGray,
          width: 1.0,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SvgPicture.asset('lib/assets/icons/glint_location.svg'),
              const Gap(8.0),
              Text(
                'Add Location Manually',
                style: AppTheme.simpleBodyText.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColours.black,
                ),
              ),
            ],
          ),
          const Gap(12),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _locationController,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.only(right: 4.0, bottom: 0),
                    hintText: 'Bhilai, Chhattisgarh',
                    hintStyle: TextStyle(color: AppColours.darkGray),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: AppColours.primaryBlue),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: AppColours.primaryBlue),
                    ),
                  ),
                ),
              ),
              const Gap(42.0),
              Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColours.primaryBlue,
                ),
                child: IconButton(
                  icon: const Icon(Icons.arrow_forward, color: AppColours.white),
                  onPressed: () {
                    // TODO - Action for changing location.
                    GlintAnalyticService.onSettingLocationNameProvidedEvent();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                            'Location would be updated to: ${_locationController.text}'),
                        duration: const Duration(seconds: 2),
                        backgroundColor: AppColours.primaryBlue,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
