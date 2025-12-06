import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glint_frontend/features/auth/blocs/reset_password/reset_password_bloc.dart';
import 'package:glint_frontend/features/auth/create_password_screen.dart';
import 'package:glint_frontend/features/auth/enter_otp_screen.dart';
import 'package:glint_frontend/features/auth/password_change_confirmation_screen.dart';
import 'package:glint_frontend/features/auth/reset_password_screen.dart';
import 'package:glint_frontend/navigation/glint_all_routes.dart';
import 'package:go_router/go_router.dart';

final glintAuthenticationRoutesBase = [
  GoRoute(
    path: '/${GlintAuthRoutes.resetPassword.name}',
    name: GlintAuthRoutes.resetPassword.name,
    pageBuilder: (context, state) {
      var resetPasswordBloc = context.read<ResetPasswordBloc>();
      return MaterialPage(
        child: BlocProvider.value(
          value: resetPasswordBloc,
          child: const ResetPasswordScreen(),
        ),
      );
    },
  ),
  GoRoute(
    path: '/${GlintAuthRoutes.otp.name}/:email',
    name: GlintAuthRoutes.otp.name,
    pageBuilder: (context, state) {
      var resetPasswordBloc = context.read<ResetPasswordBloc>();
      final email = state.pathParameters['email'];
      return MaterialPage(
        child: BlocProvider.value(
          value: resetPasswordBloc,
          child: EnterOtpScreen(email: email),
        ),
      );
    },
  ),
  GoRoute(
    path: '/${GlintAuthRoutes.recreatePassword.name}',
    name: GlintAuthRoutes.recreatePassword.name,
    pageBuilder: (context, state) {
      var resetPasswordBloc = context.read<ResetPasswordBloc>();
      final extra = state.extra as Map<String, dynamic>;
      final email = extra['email'] ?? '';
      final otp = extra['otp'] ?? '';
      return MaterialPage(
        child: BlocProvider.value(
          value: resetPasswordBloc,
          child: CreatePasswordScreen(
            email: email,
            otp: otp,
          ),
        ),
      );
    },
  ),
  GoRoute(
    path: '/${GlintAuthRoutes.passwordSuccess.name}',
    name: GlintAuthRoutes.passwordSuccess.name,
    pageBuilder: (context, state) {
      var resetPasswordBloc = context.read<ResetPasswordBloc>();
      return MaterialPage(
        child: BlocProvider.value(
          value: resetPasswordBloc,
          child: const PasswordChangeConfirmationScreen(),
        ),
      );
    },
    builder: (context, state) => const PasswordChangeConfirmationScreen(),
  ),
];
