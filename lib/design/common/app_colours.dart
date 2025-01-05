import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AppColours {
  static const primaryBlue = Color(0xFF5158BB);
  static const pink = Color(0xFFFC6F6E);
  static const backgroundShade = Color(0xFFF2F3FF);
  static const white = Color(0xFFFFFFFF);
  static const black = Color(0xFF000000);
  static const purpleShade = Color(0xFF9475D2);
  static const gray = Color(0xFFAAAAAA);
  static const chipBackgroundShade = Color(0xFFE9EAF7);

  // with opacity shades
  static final primaryBlue60 = primaryBlue.withAlpha(153);
  static final gray60 = const Color(0xFFAAAAAA).withAlpha(153);

  // Neutral Colors
  static const Color neutral50 = Color(0xFFF9FAFB);
  static const Color neutral100 = Color(0xFFF3F4F6);
  static const Color neutral200 = Color(0xFFE5E7EB);
  static const Color neutral300 = Color(0xFFD2D5DA);
  static const Color neutral400 = Color(0xFF9CA3AF);
  static const Color neutral500 = Color(0xFF6D7280);
  static const Color neutral600 = Color(0xFF4B5563);
  static const Color neutral700 = Color(0xFF374151);
  static const Color neutral800 = Color(0xFF1F2937);
  static const Color neutral900 = Color(0xFF111827);

  // Error Colors
  static const Color error50 = Color(0xFFFEE2E2);
  static const Color error100 = Color(0xFFFEE2E2);
  static const Color error200 = Color(0xFFFECACA);
  static const Color error300 = Color(0xFFFCA5A5);
  static const Color error400 = Color(0xFFF87171);
  static const Color error500 = Color(0xFFEF4444);
  static const Color error600 = Color(0xFFDC2626);
  static const Color error700 = Color(0xFFB91C1C);
  static const Color error800 = Color(0xFF991B1B);
  static const Color error900 = Color(0xFF7F1D1D);

  // Warning Colors
  static const Color warning50 = Color(0xFFFEFCE8);
  static const Color warning100 = Color(0xFFFEF9C3);
  static const Color warning200 = Color(0xFFFEF08A);
  static const Color warning300 = Color(0xFFFDE047);
  static const Color warning400 = Color(0xFFFACC15);
  static const Color warning500 = Color(0xFFEAB308);
  static const Color warning600 = Color(0xFFCA8A04);
  static const Color warning700 = Color(0xFFA16207);
  static const Color warning800 = Color(0xFF854D0E);
  static const Color warning900 = Color(0xFF713F12);

  // Success Colors
  static const Color success50 = Color(0xFFF0FDF4);
  static const Color success100 = Color(0xFFDCFCE7);
  static const Color success200 = Color(0xFFBBF7D0);
  static const Color success300 = Color(0xFF86EFAC);
  static const Color success400 = Color(0xFF4ADE80);
  static const Color success500 = Color(0xFF22C55E);
  static const Color success600 = Color(0xFF16A34A);
  static const Color success700 = Color(0xFF15803D);
  static const Color success800 = Color(0xFF166534);
  static const Color success900 = Color(0xFF14532D);

  final blueGradient = const LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFF000000),
      Color(0xFF6699CC),
    ],
  );

  final angularGradientV3 = const RadialGradient(
    center: Alignment.center,
    radius: 0.5,
    colors: [
      Color(0xFF000000),
      Color(0xFF336699),
    ],
  );

  static const Gradient textLinearGradient = LinearGradient(
    colors: <Color>[
      primaryBlue,
      purpleShade,
    ],
  );
}
