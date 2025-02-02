import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AuthStackedIllustrationScreen extends StatelessWidget {
  const AuthStackedIllustrationScreen({
    super.key,
    required this.body,
  });

  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: body),
        ),

        // bottom glint logo illustration
        Positioned(
          bottom: 0,
          child: SvgPicture.asset(
            'lib/assets/images/auth/auth_glint_logo_illustration.svg',
          ),
        ),
      ],
    );
  }
}
