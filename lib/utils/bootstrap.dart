import 'dart:async';
import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glint_frontend/di/injection.dart';
import 'package:glint_frontend/features/payment/payment_cubit.dart';
import 'package:logging/logging.dart';

import '../features/auth/blocs/reset_password/reset_password_bloc.dart';
import 'internet/internet_status_checker_cubit.dart';

Future<void> bootstrap(
  FutureOr<Widget> Function() builder,
) async {
  flutterLogError();
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  final connectivity = Connectivity();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<ResetPasswordBloc>(
          create: (_) => ResetPasswordBloc(),
        ),
        BlocProvider<InternetStatusCheckerCubit>(
          create: (_) => InternetStatusCheckerCubit(connectivity),
        ),
        BlocProvider<PaymentCubit>(
          lazy: true,
          create: (_) => PaymentCubit(),
        ),
      ],
      child: await builder(),
    ),
  );
}

//Todo : Add Analytics here
void flutterLogError() {
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  Logger.root.level = Level.INFO; // defaults to Level.INFO
  Logger.root.onRecord.listen((record) {
    print('${record.level.name}: ${record.time}: ${record.message}');
  });
}
