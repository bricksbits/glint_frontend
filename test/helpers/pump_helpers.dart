import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

import 'package:glint_frontend/features/auth/blocs/login/login_bloc.dart';
import 'package:glint_frontend/features/auth/blocs/register/register_cubit.dart';
import 'package:glint_frontend/features/onboarding/on_boarding_cubit.dart';
import 'package:glint_frontend/features/people/bloc/people_cards_bloc.dart';
import 'package:glint_frontend/features/chat/base/chat_screen_cubit.dart';
import 'package:glint_frontend/features/event/base/event_base_cubit.dart';
import 'package:glint_frontend/features/payment/payment_cubit.dart';
import 'package:glint_frontend/features/profile/settings_cubit.dart';
import 'package:glint_frontend/features/notifications/notification_cubit.dart';
import 'package:glint_frontend/features/admin/bloc/admin_dasboard/admin_dashboard_bloc.dart';
import 'package:glint_frontend/features/splash/splash_screen_bloc.dart';
import 'package:glint_frontend/utils/internet/internet_status_checker_cubit.dart';
import 'package:glint_frontend/utils/user_info/user_info_manager_cubit.dart';

Future<void> pumpWidget(
  WidgetTester tester,
  Widget widget, {
  GoRouter? router,
  List<BlocProvider>? blocProviders,
}) async {
  final wrappedWidget = MaterialApp(
    home: blocProviders != null && blocProviders.isNotEmpty
        ? MultiBlocProvider(
            providers: blocProviders,
            child: widget,
          )
        : widget,
  );

  await tester.pumpWidget(wrappedWidget);
  await tester.pumpAndSettle();
}

Future<void> pumpRouterApp(
  WidgetTester tester, {
  required GoRouter router,
  List<BlocProvider>? blocProviders,
}) async {
  final routerApp = MaterialApp.router(
    routerConfig: router,
  );

  final wrappedApp = blocProviders != null && blocProviders.isNotEmpty
      ? MultiBlocProvider(
          providers: blocProviders,
          child: routerApp,
        )
      : routerApp;

  await tester.pumpWidget(wrappedApp);
}

GoRouter createTestRouter({
  required String initialLocation,
  required List<RouteBase> routes,
}) {
  return GoRouter(
    initialLocation: initialLocation,
    routes: routes,
  );
}
