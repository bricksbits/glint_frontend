import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:glint_frontend/data/remote/model/request/auth/login_request_body.dart';
import 'package:glint_frontend/di/injection.dart';
import 'package:glint_frontend/domain/application_logic/auth/sign_in_user_use_case.dart';

part 'login_event.dart';

part 'login_state.dart';

part 'login_bloc.freezed.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final SignInUserUseCase signInUserUseCase = getIt.get();

  LoginBloc() : super(const LoginState.initial()) {
    on<LoginEvent>(
      (event, emit) async {
        if (event == const LoginEvent.started()) {
          loginUser();
        }
      },
    );
  }


  Future<void> loginUser() async {
    signInUserUseCase.perform((response) {
      print("Login Bloc : Response $response");
      emit(const LoginState.success());
    }, (error) {
      print("Login Bloc : Error $error");
      emit(LoginState.error("Eroor ${error.toString()}"));
    }, () {
      print("Login Bloc : On Done");
    }, LoginRequestBody(username: "NP", password: "1234"));
  }
}
