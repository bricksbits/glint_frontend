import 'package:glint_frontend/features/auth/create_account_screen.dart';
import 'package:glint_frontend/features/auth/create_password_screen.dart';
import 'package:glint_frontend/features/auth/enter_otp_screen.dart';
import 'package:glint_frontend/features/auth/password_change_confirmation_screen.dart';
import 'package:glint_frontend/features/auth/reset_password_screen.dart';
import 'package:glint_frontend/navigation/glint_all_routes.dart';
import 'package:go_router/go_router.dart';

final glintAuthenticationRoutesBase = [
  GoRoute(
    path: '/${GlintAuthRoutes.register.name}',
    name: GlintAuthRoutes.register.name,
    builder: (context, state) => const CreateAccountScreen(),
  ),
  GoRoute(
    path: '/${GlintAuthRoutes.resetPassword.name}',
    name: GlintAuthRoutes.resetPassword.name,
    builder: (context, state) => const ResetPasswordScreen(),
  ),
  GoRoute(
    path: '/${GlintAuthRoutes.otp.name}',
    name: GlintAuthRoutes.otp.name,
    builder: (context, state) => const EnterOtpScreen(),
  ),
  GoRoute(
    path: '/${GlintAuthRoutes.recreatePassword.name}',
    name: GlintAuthRoutes.recreatePassword.name,
    builder: (context, state) => const CreatePasswordScreen(),
  ),
  GoRoute(
    path: '/${GlintAuthRoutes.passwordSuccess.name}',
    name: GlintAuthRoutes.passwordSuccess.name,
    builder: (context, state) => const PasswordChangeConfirmationScreen(),
  ),
];
