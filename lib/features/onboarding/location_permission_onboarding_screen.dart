import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:glint_frontend/data/local/persist/async_encrypted_shared_preference_helper.dart';
import 'package:glint_frontend/design/exports.dart';
import 'package:glint_frontend/features/onboarding/on_boarding_cubit.dart';
import 'package:glint_frontend/navigation/glint_all_routes.dart';
import 'package:go_router/go_router.dart';

class LocationPermissionOnboardingScreen extends StatefulWidget {
  const LocationPermissionOnboardingScreen({super.key});

  @override
  State<LocationPermissionOnboardingScreen> createState() =>
      _LocationPermissionOnboardingScreenState();
}

class _LocationPermissionOnboardingScreenState
    extends State<LocationPermissionOnboardingScreen> {
  @override
  void initState() {
    context
        .read<OnBoardingCubit>()
        .setUpLastBoardingState(OnBoardingCompletedTill.BIO_DONE);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnBoardingCubit, OnBoardingState>(
      builder: (context, state) {
        return Scaffold(
          body: SizedBox(
            width: double.infinity,
            child: Stack(
              children: [
                // Background Image
                Positioned.fill(
                  child: Image.asset(
                    'lib/assets/images/onboarding/location_background.png',
                    fit: BoxFit.cover,
                  ),
                ),

                // Main content goes here
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 48.0),
                    child: Column(
                      children: [
                        const Spacer(),
                        _locationPermissionContainer(context),
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

  Widget _locationPermissionContainer(BuildContext context) {
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
            child: Image.asset('lib/assets/icons/location_onboarding_icon.png'),
          ),
          const Gap(24.0),
          const Text(
            "See Who’s Close to You!",
            style: AppTheme.headingThree,
          ),
          const Gap(10.0),
          const Text(
            'Enabling location helps us find matches closer to you!',
            style: AppTheme.simpleText,
            textAlign: TextAlign.center,
          ),
          const Gap(40.0),
          BlocConsumer<OnBoardingCubit, OnBoardingState>(
            listener: (context, state) {
              if (state.locationPermissionDenied == true) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text("Location permission is required")),
                );
              }

              if (state.onBoardingStatus == OnBoardingCompletedTill.COMPLETED &&
                  state.isLocationLoading == false &&
                  state.locationPermissionDenied == false) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text("Get Ready for even better experience")),
                );
                final target = GlintMainRoutes.register.name;
                context.go(
                  "/$target",
                  extra: false,
                );
              }
            },
            builder: (context, state) {
              final isLoading = state.isLocationLoading ?? false;
              return SizedBox(
                width: double.infinity,
                child: GlintElevatedButton(
                  label: isLoading ? 'Enabling...' : 'Enable Location',
                  onPressed: isLoading
                      ? null
                      : () async {
                          context
                              .read<OnBoardingCubit>()
                              .enableLocationAndCompleteOnboarding();
                        },
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
