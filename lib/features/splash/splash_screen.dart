import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:glint_frontend/design/common/app_colours.dart';
import 'package:glint_frontend/di/injection.dart';
import 'package:glint_frontend/navigation/glint_all_routes.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

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
        _navigateBasedOnAuth().then(
          (_) {
            _navigateToRespectedRoutes();
          },
        ).onError((error, stackTraces) {
          print("Splash Screen : Something went wrong");
        });
      }
    });
  }

  Future<void> _navigateBasedOnAuth() async {
    final StreamChatClient chatClient = getIt.get();
    final userId = await getUserId();
    final userToken = await getUserToken(userId);
    await chatClient.connectUser(
      User(id: userId),
      userToken,
    );
  }

  void _navigateToRespectedRoutes() {
    final targetRoute = GlintAdminDasboardRoutes.auth.name;
    if (context.mounted) {
      context.goNamed(targetRoute);
    }
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

Future<String> getUserId() async {
  return 'tutorial-flutter';
}

Future<String> getUserToken(String userId) async {
  return 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoidHV0b3JpYWwtZmx1dHRlciJ9.S-MJpoSwDiqyXpUURgO5wVqJ4vKlIVFLSEyrFYCOE1c';
}
