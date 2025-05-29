import 'package:flutter/material.dart';
import 'package:glint_frontend/di/injection.dart';
import 'package:glint_frontend/features/exports.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  runApp(
    MyGlintApp(),
  );
}
