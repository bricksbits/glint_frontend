import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glint_frontend/di/injection.dart';
import 'package:glint_frontend/features/exports.dart';
import 'package:glint_frontend/utils/bootstrap.dart';
import 'package:glint_frontend/utils/internet/internet_status_checker_cubit.dart';

Future<void> main() async {
  bootstrap(() => MyGlintApp());
}
