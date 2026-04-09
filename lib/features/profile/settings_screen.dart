import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get_it/get_it.dart';
import 'package:glint_frontend/analytics/glint_analytics_service.dart';
import 'package:glint_frontend/data/local/persist/async_encrypted_shared_preference_helper.dart';
import 'package:glint_frontend/data/local/persist/shared_pref_key.dart';
import 'package:glint_frontend/design/common/custom_snackbar.dart';
import 'package:glint_frontend/design/exports.dart';
import 'package:glint_frontend/domain/application_logic/logout_usecase.dart';
import 'package:glint_frontend/navigation/glint_all_routes.dart';
import 'package:glint_frontend/utils/app_config.dart';
import 'package:go_router/go_router.dart';
import 'package:package_info_plus/package_info_plus.dart';

class ProfileSettingsScreen extends StatefulWidget {
  const ProfileSettingsScreen({super.key});

  @override
  State<ProfileSettingsScreen> createState() => _ProfileSettingsScreenState();
}

class _ProfileSettingsScreenState extends State<ProfileSettingsScreen> {
  final _locationController = TextEditingController();
  final _prefs = GetIt.instance.get<AsyncEncryptedSharedPreferenceHelper>();
  String _appVersion = '';
  String _envName = '';

  @override
  void initState() {
    super.initState();
    _locationController.text = '';
    _getAppVersion();
    _loadNotificationPrefs();
  }

  // Add this method to get the app version
  Future<void> _getAppVersion() async {
    final packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      _envName = AppConfig.envType;
      _appVersion =
          'v${packageInfo.version} (${packageInfo.buildNumber}) $_envName';
    });
  }

  @override
  void dispose() {
    _locationController.dispose();
    super.dispose();
  }

  bool _isNotificationsEnabled = true;
  bool _isMatchesEnabled = true;
  bool _isEventsEnabled = true;
  bool _isTicketsEnabled = true;
  bool _isRemindersEnabled = true;

  Future<void> _loadNotificationPrefs() async {
    final matches =
        await _prefs.getBoolean(SharedPreferenceKeys.notifMatchesEnabledKey);
    final events =
        await _prefs.getBoolean(SharedPreferenceKeys.notifEventsEnabledKey);
    final tickets =
        await _prefs.getBoolean(SharedPreferenceKeys.notifTicketsEnabledKey);
    final reminders =
        await _prefs.getBoolean(SharedPreferenceKeys.notifRemindersEnabledKey);
    // getBoolean returns false as default — treat false as "not yet set" and
    // default to true for a fresh install.
    setState(() {
      _isMatchesEnabled = matches;
      _isEventsEnabled = events;
      _isTicketsEnabled = tickets;
      _isRemindersEnabled = reminders;
    });
  }

  Future<void> _saveNotificationPref(String key, bool value) async {
    await _prefs.saveBoolean(key, value);
  }

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
      body: SingleChildScrollView(
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
              _buildNotificationPrefsTile(context),

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
                      _appVersion,
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
      ),
    );
  }

  Widget _buildLocationTile(
    BuildContext context,
  ) {
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
          // Label
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

          // Text field + button
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _locationController,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.only(right: 4.0, bottom: 0),
                    hintText: 'Bhilai, Chhattisgarh',
                    hintStyle: TextStyle(
                      color: AppColours.darkGray,
                    ),
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
                  icon: const Icon(
                    Icons.arrow_forward,
                    color: AppColours.white,
                  ),
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
                //Todo; Open Website with Contact as Route
                GlintAnalyticService.onSettingContactUsEvent();
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
              onPressed: () {},
              icon: const Icon(
                Icons.arrow_forward_rounded,
              ),
              color: AppColours.black,
            ),
            onTap: () {
              //Todo; Open Website with FAQ as Route
              GlintAnalyticService.onSettingFaqEvent();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationPrefsTile(BuildContext context) {
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
                  value: _isNotificationsEnabled,
                  activeColor: AppColours.primaryBlue,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  onChanged: (value) {
                    GlintAnalyticService.onNotificationSettingsUpdateEvent();
                    setState(() => _isNotificationsEnabled = value);
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
                  'Matches',
                  'New matches, super likes & stories',
                  _isMatchesEnabled,
                  (value) {
                    setState(() => _isMatchesEnabled = value);
                    _saveNotificationPref(
                        SharedPreferenceKeys.notifMatchesEnabledKey, value);
                  },
                ),
                const Gap(8.0),
                _buildNotificationSwitch(
                  'Events',
                  'New events near you & approvals',
                  _isEventsEnabled,
                  (value) {
                    setState(() => _isEventsEnabled = value);
                    _saveNotificationPref(
                        SharedPreferenceKeys.notifEventsEnabledKey, value);
                  },
                ),
                const Gap(8.0),
                _buildNotificationSwitch(
                  'Tickets',
                  'Bookings, cancellations & refunds',
                  _isTicketsEnabled,
                  (value) {
                    setState(() => _isTicketsEnabled = value);
                    _saveNotificationPref(
                        SharedPreferenceKeys.notifTicketsEnabledKey, value);
                  },
                ),
                const Gap(8.0),
                _buildNotificationSwitch(
                  'Reminders',
                  'Event reminders & membership alerts',
                  _isRemindersEnabled,
                  (value) {
                    setState(() => _isRemindersEnabled = value);
                    _saveNotificationPref(
                        SharedPreferenceKeys.notifRemindersEnabledKey, value);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationSwitch(
    String label,
    String subtitle,
    bool value,
    Function(bool) onChanged,
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
          onChanged: !_isNotificationsEnabled ? null : onChanged,
        ),
      ],
    );
  }
}
