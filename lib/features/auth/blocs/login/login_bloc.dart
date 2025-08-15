import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:glint_frontend/data/remote/model/request/auth/login_request_body.dart';
import 'package:glint_frontend/di/injection.dart';
import 'package:glint_frontend/domain/application_logic/auth/sign_in_user_use_case.dart';
import 'package:glint_frontend/domain/business_logic/models/common/UsersType.dart';
import 'package:glint_frontend/features/chat/chat_screen.dart';
import 'package:glint_frontend/utils/result_sealed.dart';

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

    on<_EmitState>(
      (event, emit) {
        var newState = event.state;
        emit(newState);
      },
    );
  }

  Future<void> loginUser(
    String validEmail,
    String validPassword,
  ) async {
    signInUserUseCase.perform(
      (response) {
        switch (response) {
          case null:
            add(const _EmitState(LoginState.error("Something went wrong")));
          case Success<UsersType>():
            add(_EmitState(LoginState.success(response.data)));
          case Failure<UsersType>():
            add(const _EmitState(LoginState.error("Something went wrong")));
        }
      },
      (error) {
        add(_EmitState(LoginState.error("Something went wrong,$error")));
      },
      () {
        print("Login Bloc : On Done");
      },
      LoginRequestBody(email: validEmail, password: validPassword),
    );
  }
}
