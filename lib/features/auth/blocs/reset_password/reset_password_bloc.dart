import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:glint_frontend/data/remote/model/request/auth/reset_password_with_otp_request_body.dart';
import 'package:glint_frontend/data/remote/model/request/auth/send_otp_request_body.dart';
import 'package:glint_frontend/di/injection.dart';
import 'package:glint_frontend/domain/application_logic/auth/reset_password_with_otp_use_case.dart';
import 'package:glint_frontend/domain/application_logic/auth/send_otp_use_case.dart';

part 'reset_password_bloc.freezed.dart';
part 'reset_password_event.dart';
part 'reset_password_state.dart';

class ResetPasswordBloc extends Bloc<ResetPasswordEvent, ResetPasswordState> {
  final SendOtpUseCase sendOtpUseCase = getIt.get();
  final ResetPasswordWithOtpUseCase resetPasswordWithOtpUseCase = getIt.get();

  ResetPasswordBloc() : super(const ResetPasswordState.initial()) {
    on<_SendOtp>((event, emit) async {
      debugPrint('SEND OTP IS CALLED');
      emit(const ResetPasswordState.loading());
      await _sendOtp(event.email);
    });

    on<_ResetPassword>((event, emit) async {
      emit(const ResetPasswordState.loading());
      await _resetPassword(event.email, event.otp, event.newPassword);
    });
  }

  Future<void> _sendOtp(String email) async {
    sendOtpUseCase.perform(
      (response) {
        emit(const ResetPasswordState.otpSent());
      },
      (error) {
        print("Send OTP Bloc : Error $error");
        emit(ResetPasswordState.error(
            "Failed to send OTP: ${error.toString()}"));
      },
      () {
        print("Send OTP Bloc : On Done");
      },
      SendOtpRequestBody(emailId: email),
    );
  }

  Future<void> _resetPassword(
      String email, String otp, String newPassword) async {
    resetPasswordWithOtpUseCase.perform(
      (response) {
        emit(const ResetPasswordState.passwordResetSuccess());
      },
      (error) {
        print("Reset Password Bloc : Error $error");
        emit(ResetPasswordState.error(
            "Failed to reset password: ${error.toString()}"));
      },
      () {
        print("Reset Password Bloc : On Done");
      },
      ResetPasswordWithOtpRequestBody(
        emailId: email,
        passwordResetOtp: otp,
        newPassword: newPassword,
      ),
    );
  }
}
