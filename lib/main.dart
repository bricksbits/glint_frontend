import 'package:flutter/material.dart';
import 'package:glint_frontend/di/injection.dart';
import 'package:glint_frontend/features/exports.dart';

void main() {
  configureDependencies();
  runApp(
    const MyGlintApp(),
  );
}
