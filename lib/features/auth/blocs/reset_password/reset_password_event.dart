part of 'reset_password_bloc.dart';

@freezed
class ResetPasswordEvent with _$ResetPasswordEvent {
  const factory ResetPasswordEvent.sendOtp(String email) = _SendOtp;

  const factory ResetPasswordEvent.resetPassword(
      String email, String otp, String newPassword) = _ResetPassword;

  const factory ResetPasswordEvent.emitNewState(ResetPasswordState newState) =
      _EmitNewState;
}
