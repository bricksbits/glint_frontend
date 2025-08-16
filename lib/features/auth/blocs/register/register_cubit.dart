import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:glint_frontend/data/remote/model/request/auth/login_request_body.dart';
import 'package:glint_frontend/di/injection.dart';
import 'package:glint_frontend/domain/application_logic/auth/sign_in_user_use_case.dart';
import 'package:glint_frontend/domain/business_logic/repo/auth/authentication_repo.dart';
import 'package:glint_frontend/services/image_manager_service.dart';
import 'package:glint_frontend/utils/result_sealed.dart';

part 'register_state.dart';

part 'register_cubit.freezed.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final ImageService imageService = getIt.get<ImageService>();
  final AuthenticationRepo authenticationRepo = getIt.get<AuthenticationRepo>();
  final SignInUserUseCase signInUserUseCase = getIt.get<SignInUserUseCase>();

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

  //Todo: Do the Verification here
  void enteredOrganization(String organization) {
    emit(
      state.copyWith(
        organization: organization,
      ),
    );
  }

  //Todo: Do the Verification here
  void enteredContactNumber(String contactNumber) {
    emit(
      state.copyWith(
        contactNumber: contactNumber
      ),
    );
  }

  //Todo: Do the Verification here
  void enteredUserName(String fullName) {
    emit(
      state.copyWith(
        name: fullName
      ),
    );
  }

  // Get Data from DB
  // Get Email and Password from User
  // Hit the Register User API
  // Delete everything from persistence
  //Todo: handle the Role as per the type of registration
  //Todo: Update the FCM token
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
            await _loginUser(
              state.email,
              state.password,
            );
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

  //Todo: Showcase in the UI the various state happening here.
  Future<void> _loginUser(
    String validEmail,
    String validPassword,
  ) async {
    signInUserUseCase.perform(
      (response) {
        _uploadMediaFiles();
      },
      (error) {
        print("Login : Error $error");
        emit(state.copyWith(isLoading: false, isRegisteredSuccessfully: false));
      },
      () {
        print("Login : On Done");
      },
      LoginRequestBody(email: validEmail, password: validPassword),
    );
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
        print("Files not uploaded");
        emitNewState(state.copyWith(isLoading: false));
    }
  }

  void emitNewState(RegisterState newState) {
    emit(newState);
  }
}
