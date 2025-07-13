part of 'reset_password_bloc.dart';

@freezed
class ResetPasswordState with _$ResetPasswordState {
  const factory ResetPasswordState.initial() = _Initial;
  const factory ResetPasswordState.loading() = _Loading;
  const factory ResetPasswordState.otpSent() = _OtpSent;
  const factory ResetPasswordState.passwordResetSuccess() = _PasswordResetSuccess;
  const factory ResetPasswordState.error(String message) = _Error;
} 