import 'package:flutter/material.dart';
import 'package:glint_frontend/design/common/app_colours.dart';

class AppTheme {
  // Define text styles
  static const TextStyle simpleText = TextStyle(
    fontFamily: 'AlbertSans',
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: Colors.black87,
  );

  static const TextStyle simpleBodyText = TextStyle(
    fontFamily: 'AlbertSans',
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: Colors.black87,
  );

  static const TextStyle heavyBodyText = TextStyle(
    fontFamily: 'AlbertSans',
    fontSize: 18.0,
    fontWeight: FontWeight.w700,
    color: Colors.black87,
  );

  static const TextStyle logoHeadingText = TextStyle(
    fontFamily: 'AlbertSans',
    fontSize: 24.0,
    fontWeight: FontWeight.w700,
    color: Colors.black,
  );

  static const TextStyle smallBodyText = TextStyle(
    fontFamily: 'AlbertSans',
    fontSize: 12.0,
    fontWeight: FontWeight.normal,
    color: Colors.black,
  );

  static const TextStyle headingOne = TextStyle(
    fontFamily: 'Cambon',
    fontSize: 28,
    fontWeight: FontWeight.w700,
    fontStyle: FontStyle.italic,
    color: Colors.black,
  );

  static const TextStyle headingTwo = TextStyle(
    fontFamily: 'Cambon',
    fontSize: 24,
    fontWeight: FontWeight.w700,
    fontStyle: FontStyle.italic,
    color: Colors.black,
  );

  static const TextStyle headingThree = TextStyle(
    fontFamily: 'Cambon',
    fontSize: 16,
    fontWeight: FontWeight.w600,
    fontStyle: FontStyle.italic,
    color: Colors.black,
  );

  static const TextStyle lightText = TextStyle(
    fontFamily: 'Cambon',
    fontSize: 16,
    fontWeight: FontWeight.w200,
    color: Colors.black,
  );

  // Define ThemeData
  static ThemeData get theme {
    return ThemeData(
      primaryColor: AppColours.primaryBlue,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColours.primaryBlue, // Use seed for light/dark shades
        primary: AppColours.primaryBlue,
        secondary: AppColours.backgroundShade, // Example secondary color
      ),
      textTheme: const TextTheme(
          headlineLarge: headingOne,
          headlineMedium: headingTwo,
          headlineSmall: headingThree,
          bodyMedium: simpleBodyText,
          bodySmall: simpleText),
    );
  }
}
