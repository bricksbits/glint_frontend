import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:glint_frontend/data/remote/model/request/auth/login_request_body.dart';
import 'package:glint_frontend/di/injection.dart';
import 'package:glint_frontend/domain/application_logic/auth/sign_in_user_use_case.dart';
import 'package:glint_frontend/domain/business_logic/models/common/UsersType.dart';
import 'package:glint_frontend/features/chat/chat_screen.dart';

part 'login_event.dart';

part 'login_state.dart';

part 'login_bloc.freezed.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final SignInUserUseCase signInUserUseCase = getIt.get();

  LoginBloc() : super(const LoginState.initial()) {
    String? email;
    String? password;

    on<_EmailInput>((event, emit) {
      email = event.email;
    });

    on<_PasswordInput>((event, emit) {
      password = event.password;
    });

    on<_Login>(
      (event, emit) async {
        if (email != null && password != null) {
          loginUser(email!, password!);
        }
      },
    );
  }

  Future<void> loginUser(
    String validEmail,
    String validPassword,
  ) async {
    signInUserUseCase.perform(
      (response) {
        emit(const LoginState.success(UsersType.USER));
      },
      (error) {
        print("Login Bloc : Error $error");
        emit(LoginState.error("Eroor ${error.toString()}"));
      },
      () {
        print("Login Bloc : On Done");
      },
      LoginRequestBody(username: validEmail, password: validPassword),
    );
  }
}
