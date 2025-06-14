part of 'register_cubit.dart';

@freezed
class RegisterState with _$RegisterState {
  const factory RegisterState.initial({
    @Default("") String email,
    @Default("") String password,
    @Default(false) bool isLoading,
    @Default("") String confirmPassword,
    @Default(true) bool isEmailValid,
    @Default(true) bool isPassWordValid,
    @Default(true) bool isConfirmPassword,
    @Default(false) bool isRegisteredSuccessfully,
  }) = _Initial;
}
