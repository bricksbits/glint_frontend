import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:glint_frontend/analytics/glint_analytics_service.dart';
import 'package:glint_frontend/design/exports.dart';
import 'package:glint_frontend/di/injection.dart';
import 'package:glint_frontend/features/onboarding/on_boarding_cubit.dart';
import 'package:glint_frontend/navigation/glint_all_routes.dart';
import 'package:glint_frontend/services/notification_permission_service.dart';
import 'package:go_router/go_router.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationPermissionOnboardingScreen extends StatefulWidget {
  const LocationPermissionOnboardingScreen({super.key});

  @override
  State<LocationPermissionOnboardingScreen> createState() =>
      _LocationPermissionOnboardingScreenState();
}

class _LocationPermissionOnboardingScreenState
    extends State<LocationPermissionOnboardingScreen> {
  PermissionButtonState _notifState = PermissionButtonState.notRequested;

  @override
  void initState() {
    context
        .read<OnBoardingCubit>()
        .setUpLastBoardingState(OnBoardingCompletedTill.BIO_DONE);
    _checkNotificationPermission();
    super.initState();
  }

  Future<void> _checkNotificationPermission() async {
    final isGranted =
        await getIt.get<NotificationPermissionService>().isPermissionGranted();
    if (mounted) {
      setState(() {
        _notifState = isGranted
            ? PermissionButtonState.granted
            : PermissionButtonState.notRequested;
      });
    }
  }

  bool _isLocationAttended(OnBoardingState state) =>
      state.locationPermissionDenied == true ||
      state.onBoardingStatus == OnBoardingCompletedTill.COMPLETED;

  bool _isNotifAttended() =>
      _notifState == PermissionButtonState.granted ||
      _notifState == PermissionButtonState.denied;

  void _navigateToRegisterFlow(BuildContext ctx, OnBoardingState state) {
    if (!ctx.mounted) return;
    if (state.onBoardingStatus == OnBoardingCompletedTill.COMPLETED) {
      ScaffoldMessenger.of(ctx).showSnackBar(
        const SnackBar(content: Text("Get Ready for even better experience")),
      );
      GlintAnalyticService.onBoardLocationPermissionEvent(true);
    }
    ctx.go("/${GlintMainRoutes.register.name}", extra: false);
  }

  Future<void> _requestNotificationPermission() async {
    setState(() => _notifState = PermissionButtonState.inProgress);
    final isGranted =
        await getIt.get<NotificationPermissionService>().requestPermission();
    if (!mounted) return;
    setState(() {
      _notifState =
          isGranted ? PermissionButtonState.granted : PermissionButtonState.denied;
    });
    final cubitState = context.read<OnBoardingCubit>().state;
    if (_isLocationAttended(cubitState) && _isNotifAttended()) {
      _navigateToRegisterFlow(context, cubitState);
    }
  }

  Future<void> _handleNotifDenied() async {
    await getIt.get<NotificationPermissionService>().openSettings();
    if (!mounted) return;
    final isGranted =
        await getIt.get<NotificationPermissionService>().isPermissionGranted();
    if (!mounted) return;
    setState(() {
      _notifState = isGranted
          ? PermissionButtonState.granted
          : PermissionButtonState.denied;
    });
    final cubitState = context.read<OnBoardingCubit>().state;
    if (_isLocationAttended(cubitState) && _isNotifAttended()) {
      _navigateToRegisterFlow(context, cubitState);
    }
  }

  PermissionButtonState _locationButtonState(OnBoardingState state) {
    if (state.isLocationLoading == true) return PermissionButtonState.inProgress;
    if (state.locationPermissionDenied == true) return PermissionButtonState.denied;
    if (state.onBoardingStatus == OnBoardingCompletedTill.COMPLETED) {
      return PermissionButtonState.granted;
    }
    return PermissionButtonState.notRequested;
  }

  VoidCallback? _locationTap(BuildContext ctx, OnBoardingState state) {
    switch (_locationButtonState(state)) {
      case PermissionButtonState.notRequested:
        return () =>
            ctx.read<OnBoardingCubit>().enableLocationAndCompleteOnboarding();
      case PermissionButtonState.denied:
        return () async {
          await openAppSettings();
          if (ctx.mounted) {
            ctx.read<OnBoardingCubit>().resetLocationPermissionDenied();
          }
        };
      case PermissionButtonState.inProgress:
      case PermissionButtonState.granted:
        return null;
    }
  }

  VoidCallback? _notifTap() {
    switch (_notifState) {
      case PermissionButtonState.notRequested:
        return _requestNotificationPermission;
      case PermissionButtonState.denied:
        return _handleNotifDenied;
      case PermissionButtonState.inProgress:
      case PermissionButtonState.granted:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OnBoardingCubit, OnBoardingState>(
      listener: (context, state) {
        if (state.locationPermissionDenied == true) {
          GlintAnalyticService.onBoardLocationPermissionEvent(false);
        }

        if (_isLocationAttended(state) && _isNotifAttended()) {
          _navigateToRegisterFlow(context, state);
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: SizedBox(
            width: double.infinity,
            child: Stack(
              children: [
                Positioned.fill(
                  child: Image.asset(
                    'lib/assets/images/onboarding/location_background.png',
                    fit: BoxFit.cover,
                  ),
                ),
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 48.0),
                    child: Column(
                      children: [
                        const Spacer(),
                        _permissionContainer(context, state),
                        const Gap(20.0),
                        Text(
                          'We value your privacy and only use your location to enhance your experience.',
                          style: AppTheme.simpleText.copyWith(
                            fontWeight: FontWeight.w300,
                            fontSize: 12.0,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const Spacer(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _permissionContainer(BuildContext context, OnBoardingState state) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 24.0,
        vertical: 32.0,
      ).copyWith(bottom: 20.0),
      decoration: BoxDecoration(
        color: AppColours.backgroundShade,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Column(
        children: [
          SizedBox.square(
            dimension: 72.0,
            child:
                Image.asset('lib/assets/icons/location_onboarding_icon.png'),
          ),
          const Gap(24.0),
          const Text(
            "See Who's Close to You!",
            style: AppTheme.headingThree,
          ),
          const Gap(10.0),
          const Text(
            'Enabling location helps us find matches closer to you!',
            style: AppTheme.simpleText,
            textAlign: TextAlign.center,
          ),
          const Gap(40.0),
          GestureDetector(
            onTap: () => context.go(
              "/${GlintMainRoutes.register.name}",
              extra: false,
            ),
            child: const Text(
              'Proceed anyway >>',
              style: AppTheme.smallBodyText,
              textAlign: TextAlign.center,
            ),
          ),
          const Gap(40.0),
          PermissionButton(
            buttonState: _notifState,
            enableLabel: 'Enable Notifications',
            onTap: _notifTap(),
          ),
          const Gap(16),
          PermissionButton(
            buttonState: _locationButtonState(state),
            enableLabel: 'Enable Location',
            onTap: _locationTap(context, state),
          ),
        ],
      ),
    );
  }
}
