import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:glint_frontend/di/injection.dart';
import 'package:glint_frontend/domain/application_logic/auth/sign_in_user_use_case.dart';

part 'login_event.dart';

part 'login_state.dart';

part 'login_bloc.freezed.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {

  LoginBloc() : super(const LoginState.initial()) {
    on<LoginEvent>(
      (event, emit) async {
        if (event == const LoginEvent.started()) {
          loginUser();
        }
      },
    );
  }

  final SignInUserUseCase signInUserUseCase = getIt<SignInUserUseCase>();

  Future<void> loginUser() async {
    print("Login Bloc : Called");
    // signInUserUseCase.perform((response) {
    //   print("Login Bloc : Response $response");
    // }, (error) {
    //   print("Login Bloc : Error $error");
    // }, () {
    //   print("Login Bloc : On Done");
    // }, LoginRequestBody(username: "NP", password: "1234"));
  }
}
