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
  static const Duration _animationDuration = Duration(seconds: 2);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);

    _controller.addStatusListener((status) {
      print("Splash Screen Animation Completed");
    });
  }

  void _navigateToRespectedRoutes(String newRoute) {
    if (context.mounted) {
      context.goNamed(newRoute);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
              _navigateToRespectedRoutes(newDestination);
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
