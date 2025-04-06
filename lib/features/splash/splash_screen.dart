import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:glint_frontend/design/common/app_colours.dart';
import 'package:glint_frontend/navigation/glint_all_routes.dart';
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
  final bool isAuthenticated = true;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _navigateBasedOnAuth();
      }
    });
  }

  void _navigateBasedOnAuth() {
    final targetRoute = isAuthenticated
        ? (!kIsWeb
            ? "/${GlintAdminDasboardRoutes.auth.name}"
            : "/${GlintMainRoutes.onBoarding.name}")
        : (kIsWeb
            ? "/${GlintAdminDasboardRoutes.home.name}"
            : "/${GlintMainRoutes.home.name}");

    context.go(targetRoute);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColours.primaryBlue,
      body: Center(
        child: SizedBox(
          height: 200,
          width: 200,
          child: Lottie.asset(
            'lib/assets/animation/splash.json',
            controller: _controller,
            repeat: false,
            onLoaded: (composition) {
              _controller
                ..duration = composition.duration
                ..forward();
            },
          ),
        ),
      ),
    );
  }
}
