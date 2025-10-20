part of 'login_bloc.dart';

@freezed
class LoginState with _$LoginState {
  const factory LoginState.initial() = _Initial;
  const factory LoginState.loading(bool isLoading) = _Loading;
  const factory LoginState.success(UsersType type) = _Success; // Add success state if needed
  const factory LoginState.error(String message) = _Error;
  const factory LoginState.emailChanged(String email) = _EmailChanged;
  const factory LoginState.passwordChanged(String password) = _PasswordChanged;
}
