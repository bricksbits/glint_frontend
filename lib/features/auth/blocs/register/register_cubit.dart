import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:glint_frontend/di/injection.dart';
import 'package:glint_frontend/domain/business_logic/repo/auth/authentication_repo.dart';
import 'package:glint_frontend/features/onboarding/on_boarding_cubit.dart';
import 'package:glint_frontend/utils/result_sealed.dart';

part 'register_state.dart';

part 'register_cubit.freezed.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final AuthenticationRepo authenticationRepo = getIt.get<AuthenticationRepo>();

  RegisterCubit() : super(const RegisterState.initial());

  void enteredEmail(String email) {
    // Do the Verification here
    emit(state.copyWith(email: email, isEmailValid: true));
  }

  void enteredPassword(String password) {
    // Do the Verification here
    emit(
      state.copyWith(
        email: password,
        isPassWordValid: true,
      ),
    );
  }

  // Get Data from DB
  // Get Email and Password from User
  // Hit the Register User API
  // Delete everything from persistence
  //Todo: handle the Role as per the type of registration
  Future<void> registerUser() async {
    final userRequestModel = await authenticationRepo.getOnBoardedUser();
    if (state.isEmailValid && state.isPassWordValid) {
      final updatedRequestWithCredentials = userRequestModel?.copyWith(
        email: state.email,
        password: state.password,
      );
      if (updatedRequestWithCredentials != null) {
        final isRegisteredResponse = await authenticationRepo.createAccount(
          updatedRequestWithCredentials,
          "user",
        );
        switch (isRegisteredResponse) {
          case Success<void>():
            await authenticationRepo.clearTheDbAfterRegistration();
          //todo: Emit Success state
          case Failure<void>():
          //todo: Emit Failure state and let them try again.
        }
      }
    } else {
      emit(state.copyWith(
        isPassWordValid: false,
        isEmailValid: false,
      ));
    }
  }

  void emitNewState(RegisterState newState) {
    emit(newState);
  }
}
