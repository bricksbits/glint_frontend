part of 'register_cubit.dart';

@freezed
class RegisterState with _$RegisterState {
  const factory RegisterState.initial({
    @Default("") String email,
    @Default("") String password,
    @Default("") String name,
    @Default("") String organization,
    @Default("") String contactNumber,
    @Default(false) bool isLoading,
    @Default("") String confirmPassword,
    @Default(false) bool isEmailValid,
    @Default(false) bool isPassWordValid,
    @Default(false) bool isConfirmPassword,
    @Default(false) bool isRegisteredSuccessfully,
    @Default("") String navigateToRoute,
    @Default("") String error,
    @Default('') String currentSuccessStatus,
  }) = _Initial;
}
