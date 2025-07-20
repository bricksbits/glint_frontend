import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:glint_frontend/di/injection.dart';
import 'package:glint_frontend/domain/business_logic/repo/auth/authentication_repo.dart';
import 'package:glint_frontend/features/onboarding/on_boarding_cubit.dart';
import 'package:glint_frontend/services/image_manager_service.dart';
import 'package:glint_frontend/utils/result_sealed.dart';

part 'register_state.dart';

part 'register_cubit.freezed.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final ImageService imageService = getIt.get<ImageService>();
  final AuthenticationRepo authenticationRepo = getIt.get<AuthenticationRepo>();

  RegisterCubit() : super(const RegisterState.initial());

  //Todo: Do the Verification here
  void enteredEmail(String email) {
    emit(state.copyWith(email: email, isEmailValid: true));
  }

  //Todo: Do the Verification here
  void enteredPassword(String password) {
    emit(
      state.copyWith(
        password: password,
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
    emitNewState(state.copyWith(isLoading: true));
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
          //todo: Emit Success state
          case Success<void>():
            await authenticationRepo.clearTheDbAfterRegistration();
            await _uploadMediaFiles();
          case Failure<void>():
            //todo: Emit Failure state and let them try again.
            emitNewState(state.copyWith(isLoading: false));
        }
      }
    } else {
      emit(state.copyWith(
        isPassWordValid: false,
        isEmailValid: false,
      ));
    }
  }

  Future<void> _uploadMediaFiles() async {
    final savedImages = await imageService.loadSavedImages();
    final mediaFiles = savedImages.map((file) => file.file).toList();
    final imagesUploadResponse =
        await authenticationRepo.uploadMediaFile(mediaFiles);
    switch (imagesUploadResponse) {
      case Success<void>():
        print("File Uploaded successfully");
        emitNewState(
          state.copyWith(
            isRegisteredSuccessfully: true,
            isLoading: false,
          ),
        );
      case Failure<void>():
        emitNewState(state.copyWith(isLoading: false));
    }
  }

  void emitNewState(RegisterState newState) {
    emit(newState);
  }
}
