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
          if (_validateEmail(email!)) {
            if (_validatePassword(password!)) {
              loginUser(email!, password!);
            }
          }
        } else {
          add(
            const _EmitState(
              LoginState.error('Please provide your Credentials.'),
            ),
          );
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
    add(const LoginEvent.emitNewState(LoginState.loading(true)));
    signInUserUseCase.perform(
      (response) {
        switch (response) {
          case null:
            add(const LoginEvent.emitNewState(LoginState.loading(false)));
            add(const _EmitState(LoginState.error("Something went wrong")));
            break;
          case Success<UsersType>():
            add(const LoginEvent.emitNewState(LoginState.loading(false)));
            add(_EmitState(LoginState.success(response.data)));
            break;
          case Failure<UsersType>():
            //Todo: Handle the Error Case, When the Image is not uploaded,
            add(const LoginEvent.emitNewState(LoginState.loading(false)));
            add(_EmitState(LoginState.error("${response.message}")));
            break;
        }
      },
      (error) {
        add(const LoginEvent.emitNewState(LoginState.loading(false)));
        if (error is Failure) {
          add(_EmitState(LoginState.error("${error.message}")));
        } else {
          add(const _EmitState(
              LoginState.error("Please check credentials again, wrong info.")));
        }
      },
      () {
        print("Login Bloc : On Done");
      },
      LoginRequestBody(email: validEmail, password: validPassword),
    );
  }

  bool _validateEmail(String email) {
    if (email.isEmpty) {
      add(
        const _EmitState(
          LoginState.error("Email cannot be empty."),
        ),
      );
      return false;
    } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email)) {
      add(
        const _EmitState(
          LoginState.error('Please enter a valid email address.'),
        ),
      );
      return false;
    } else {
      return true;
    }
  }

  bool _validatePassword(String password) {
    const int minLength = 9;
    if (password.isEmpty) {
      add(
        const _EmitState(
          LoginState.error('Password cannot be empty.'),
        ),
      );
      return false;
    } else if (password.length < minLength) {
      add(
        const _EmitState(
          LoginState.error('Password must be at least 10 characters.'),
        ),
      );
      return false;
    } else {
      return true;
    }
  }
}
