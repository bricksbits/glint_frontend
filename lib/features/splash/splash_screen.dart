import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glint_frontend/design/common/app_colours.dart';
import 'package:glint_frontend/features/splash/splash_screen_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  String? _pendingNavigationRoute;
  static const Duration _animationDuration = Duration(seconds: 2);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: _animationDuration,
    );

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        if (_pendingNavigationRoute != null && context.mounted) {
          context.goNamed(_pendingNavigationRoute!);
        }
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleNavigationRequest(String newRoute) {
    _pendingNavigationRoute = newRoute;
    if (_controller.isAnimating) {
      // Already animating — just wait.
      return;
    }
    _controller.forward(); // If animation wasn't started yet.
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashScreenBloc()
        ..add(const SplashScreenEvent.startSplashAnimation()),
      child: BlocListener<SplashScreenBloc, SplashScreenState>(
        listenWhen: (previous, current){
          return true;
        },
        listener: (context, state) {
          state.when(
            initial: () {},
            navigateTo: (newDestination) {
              _handleNavigationRequest(newDestination);
            },
            splashSuccess: () {
              context
                  .read<SplashScreenBloc>()
                  .add(const SplashScreenEvent.started());
              _controller
                ..duration = _animationDuration
                ..forward();
            },
            splashFailure: () {
              _controller
                ..duration = _animationDuration
                ..forward();
            },
          );
        },
        child: Scaffold(
          backgroundColor: AppColours.primaryBlue,
          body: Center(
            child: SizedBox(
              height: 200,
              width: 200,
              child: Lottie.asset(
                'lib/assets/animation/splash.json',
                controller: _controller,
                repeat: false,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
