import 'dart:async';
import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glint_frontend/di/injection.dart';
import 'package:glint_frontend/domain/business_logic/repo/background/info/user_info_repo.dart';
import 'package:glint_frontend/features/payment/payment_cubit.dart';
import 'package:glint_frontend/utils/logger.dart';
import 'package:glint_frontend/utils/user_info/user_info_manager_cubit.dart';
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
  await Firebase.initializeApp();
  final firebaseInstance = FirebaseMessaging.instance;
  final notificationSettings =
      await firebaseInstance.requestPermission(provisional: true);
  final userInfoRepo = getIt.get<UserInfoManagerCubit>();

  setupFireBase(firebaseInstance, notificationSettings, userInfoRepo);

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

void setupFireBase(
  FirebaseMessaging firebaseInstance,
  NotificationSettings notificationSettings,
  UserInfoManagerCubit userInfoCubit,
) async {
  if (notificationSettings.authorizationStatus ==
          AuthorizationStatus.authorized ||
      notificationSettings.authorizationStatus ==
          AuthorizationStatus.provisional) {
    final fcmToken = await firebaseInstance.getToken();
    if (fcmToken != null) {
      debugLogger(
          "FIREBASE TOKEN FETCH", "Token fetched at startup: $fcmToken");
      userInfoCubit.updateTheFcmLocally(fcmToken);
    } else {
      debugLogger("FIREBASE TOKEN FETCH",
          "Failed to fetch token at startup, it was null.");
    }

    firebaseInstance.onTokenRefresh.listen((newToken) {
      debugLogger("FIREBASE TOKEN REFRESH", "New Token generated: $newToken");
      userInfoCubit.updateTheFcmLocally(newToken);
    }).onError((error) {
      debugLogger(
          "FIREBASE TOKEN REFRESH", "Failed to generate the token, ${error}");
      //Todo: Log the Error to the Analytic here.
    });
  } else {
    debugLogger(
        "FIREBASE PERMISSIONS", "User did not grant notification permissions.");
  }
}
