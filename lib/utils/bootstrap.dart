import 'dart:async';
import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glint_frontend/analytics/glint_analytics_service.dart';
import 'package:glint_frontend/di/injection.dart';
import 'package:glint_frontend/features/payment/payment_cubit.dart';
import 'package:glint_frontend/utils/app_config.dart';
import 'package:glint_frontend/utils/user_info/user_info_manager_cubit.dart';
import 'package:logging/logging.dart';

import '../features/auth/blocs/reset_password/reset_password_bloc.dart';
import 'internet/internet_status_checker_cubit.dart';

Future<void> bootstrap(
  FutureOr<Widget> Function() builder,
) async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppConfig.initialize();
  await Firebase.initializeApp();
  await setupFirebaseCrashlytics();
  GlintAnalyticService.setAnalyticsEnable();
  await configureDependencies();
  final connectivity = Connectivity();
  flutterLogError();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<ResetPasswordBloc>(
          lazy: true,
          create: (_) => ResetPasswordBloc(),
        ),
        BlocProvider<InternetStatusCheckerCubit>(
          create: (_) => InternetStatusCheckerCubit(connectivity),
        ),
        BlocProvider<PaymentCubit>(
          lazy: true,
          create: (_) => PaymentCubit(),
        ),
        BlocProvider<UserInfoManagerCubit>(
          lazy: true,
          create: (_) => getIt.get<UserInfoManagerCubit>(),
        ),
      ],
      child: await builder(),
    ),
  );
}

Future<void> setupFirebaseCrashlytics() async {
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };
  if (kDebugMode) {
    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(false);
  } else {
    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
  }
}

void flutterLogError() {
  FlutterError.onError = (details) {
    GlintAnalyticService.logError(
        "FlutterLogError",
        DateTime.timestamp().millisecondsSinceEpoch.toString(),
        "Flutter System Error Log",
        details.exceptionAsString(),
        details.stack);
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  Logger.root.level = Level.INFO; // defaults to Level.INFO
  Logger.root.onRecord.listen((record) {
    print('${record.level.name}: ${record.time}: ${record.message}');
  });
}
