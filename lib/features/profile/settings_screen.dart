import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get_it/get_it.dart';
import 'package:glint_frontend/design/exports.dart';
import 'package:glint_frontend/domain/application_logic/logout_usecase.dart';
import 'package:glint_frontend/navigation/glint_all_routes.dart';
import 'package:go_router/go_router.dart';
import 'package:package_info_plus/package_info_plus.dart';

class ProfileSettingsScreen extends StatefulWidget {
  const ProfileSettingsScreen({super.key});

  @override
  State<ProfileSettingsScreen> createState() => _ProfileSettingsScreenState();
}

class _ProfileSettingsScreenState extends State<ProfileSettingsScreen> {
  final _locationController = TextEditingController();
  String _appVersion = '';

  @override
  void initState() {
    super.initState();
    // Initialize with default values if needed
    _locationController.text = '';
    _getAppVersion();
  }

  // Add this method to get the app version
  Future<void> _getAppVersion() async {
    final packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      _appVersion = 'v${packageInfo.version} (${packageInfo.buildNumber})';
    });
  }

  @override
  void dispose() {
    _locationController.dispose();
    super.dispose();
  }

  bool _isNotificationsEnabled = true;
  bool _isLikesNotificationEnabled = false;
  bool _isEventsNotificationEnabled = false;
  bool _isNewMatchesNotificationEnabled = false;
  bool _isNewMessagesNotificationEnabled = false;

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
                    showAccountLifecycleDialog(
                      context,
                      icon: Icons.power_settings_new_outlined,
                      title: 'Logout Account?',
                      subtitle: 'Are you sure you want to logout?',
                      buttonText: 'Yes, Logout',
                      buttonabackgroundColor: AppColours.black,
                      onAccept: () {
                        final loginUseCase = GetIt.instance.get<LogoutUserUsecase>();
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
                    showAccountLifecycleDialog(
                      context,
                      icon: Icons.delete_outline_rounded,
                      title: 'Delete Glint Profile',
                      subtitle:
                          'Are you sure you want to delete your Glint Profile permanently?',
                      buttonText: 'Yes, Delete',
                      onAccept: () {
                        // todo - handle logout
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
              onPressed: () {},
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
              // TODO - Open FAQs page
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
                    .copyWith(
              right: 16.0,
              bottom: 4.0,
            ),
            child: Row(
              children: [
                SvgPicture.asset(
                  'lib/assets/icons/glint_bell.svg',
                  placeholderBuilder: (context) =>
                      const Icon(Icons.notifications),
                ),
                const Gap(12.0),
                Text(
                  'Allow Notification',
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
                    setState(() {
                      _isNotificationsEnabled = value;
                      debugPrint('Notifications master toggle: $value');

                      // If notifications are disabled, log that others won't work
                      if (!value) {
                        debugPrint(
                            'All notification subtypes are effectively disabled');
                      }
                    });
                  },
                ),
              ],
            ),
          ),
          const Divider(
            color: AppColours.borderGray,
          ),
          const Gap(12.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0)
                .copyWith(right: 16.0),
            child: Column(
              children: [
                _buildNotificationSwitch(
                  'Likes',
                  _isLikesNotificationEnabled,
                  (value) {
                    setState(() {
                      _isLikesNotificationEnabled = value;
                      debugPrint('Likes notifications: $value');
                    });
                  },
                ),
                const Gap(8.0),
                _buildNotificationSwitch(
                  'Events',
                  _isEventsNotificationEnabled,
                  (value) {
                    setState(() {
                      _isEventsNotificationEnabled = value;
                      debugPrint('Events notifications: $value');
                    });
                  },
                ),
                const Gap(8.0),
                _buildNotificationSwitch(
                  'New Matches',
                  _isNewMatchesNotificationEnabled,
                  (value) {
                    setState(() {
                      _isNewMatchesNotificationEnabled = value;
                      debugPrint('New Matches notifications: $value');
                    });
                  },
                ),
                const Gap(8.0),
                _buildNotificationSwitch(
                  'New Messages',
                  _isNewMessagesNotificationEnabled,
                  (value) {
                    setState(() {
                      _isNewMessagesNotificationEnabled = value;
                      debugPrint('New Messages notifications: $value');
                    });
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
    bool value,
    Function(bool) onChanged,
  ) {
    return Row(
      children: [
        Text(
          label,
          style: AppTheme.simpleText,
        ),
        const Spacer(),
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
