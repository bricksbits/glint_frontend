part of 'login_bloc.dart';

@freezed
class LoginEvent with _$LoginEvent {
  const factory LoginEvent.login() = _Login;

  const factory LoginEvent.emailInput(String email) = _EmailInput;

  const factory LoginEvent.passwordInput(String password) = _PasswordInput;
}
