import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:glint_frontend/data/remote/model/request/auth/login_request_body.dart';
import 'package:glint_frontend/di/injection.dart';
import 'package:glint_frontend/domain/application_logic/auth/sign_in_user_use_case.dart';
import 'package:glint_frontend/domain/business_logic/models/auth/register_user_request.dart';
import 'package:glint_frontend/domain/business_logic/repo/auth/authentication_repo.dart';
import 'package:glint_frontend/navigation/glint_all_routes.dart';
import 'package:glint_frontend/services/image_manager_service.dart';
import 'package:glint_frontend/utils/logger.dart';
import 'package:glint_frontend/utils/result_sealed.dart';
import 'package:intl/intl.dart';

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
      state.copyWith(contactNumber: contactNumber),
    );
  }

  //Todo: Do the Verification here
  void enteredUserName(String fullName) {
    emit(
      state.copyWith(name: fullName),
    );
  }

  // Get Data from DB
  // Get Email and Password from User
  // Hit the Register User API
  // Delete everything from persistence
  //Todo: handle the Role as per the type of registration
  //Todo: Update the FCM token
  Future<void> registerUser() async {
    emitNewState(
      state.copyWith(
          isLoading: true, currentSuccessStatus: "Registering New User"),
    );
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
            emitNewState(
              state.copyWith(
                  currentSuccessStatus: "Registered, Login you now to system"),
            );
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

  Future<void> _loginUser(
    String validEmail,
    String validPassword,
  ) async {
    signInUserUseCase.perform(
      (response) {
        _uploadMediaFiles();
      },
      (error) {
        print("Login : Error ${error.toString()}");
        emit(state.copyWith(isLoading: false, isRegisteredSuccessfully: false));
      },
      () {
        print("Login : On Done");
      },
      LoginRequestBody(email: validEmail, password: validPassword),
    );
  }

  Future<void> _loginAdmin(
    String validEmail,
    String validPassword,
  ) async {
    signInUserUseCase.perform(
      (response) {
        emitNewState(
          state.copyWith(
            isRegisteredSuccessfully: true,
            isLoading: false,
            navigateToRoute: GlintAdminDasboardRoutes.adminHome.name,
          ),
        );
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
    emitNewState(
      state.copyWith(
        currentSuccessStatus: "Uploading your images..",
      ),
    );
    final savedImages = await imageService.loadSavedImages();
    final mediaFiles = savedImages.map((file) => file.file).toList();
    final imagesUploadResponse =
        await authenticationRepo.uploadMediaFile(mediaFiles);
    switch (imagesUploadResponse) {
      case Success<void>():
        emitNewState(
          state.copyWith(
            isRegisteredSuccessfully: true,
            isLoading: false,
            navigateToRoute: GlintMainRoutes.home.name,
          ),
        );
      case Failure<void>():
        print("Files not uploaded");
        emitNewState(state.copyWith(
          isLoading: false,
        ));
    }
  }

  Future<void> registerAsAAdmin() async {
    RegisterUserRequest fakeAdminRegisterModel = RegisterUserRequest(
      "ADMIN_USER_ID_TEMP",
      state.name,
      state.email,
      state.password,
      "A Event admin doesn't needed a bio",
      calculateMockDob(),
      "6.0",
      "education",
      state.organization,
      "male",
      "female",
      "never",
      "never",
      "never",
      "Something Casual",
      [],
      "18",
    );
    final response = await authenticationRepo.createAccount(
      fakeAdminRegisterModel,
      "event admin",
    );

    switch (response) {
      case Success<void>():
        _loginAdmin(state.email, state.password);
      case Failure<void>():
        debugLogger(
            "RegisterCubit", "Something went wrong, can't register the admin");
    }
  }

  String calculateMockDob() {
    final now = DateTime.now();
    final date18YearsAgo = DateTime(
      now.year - 18,
      now.month,
      now.day,
      now.hour,
      now.minute,
      now.second,
    );
    final formatted = DateFormat('yyyy-MM-dd HH:mm:ss').format(date18YearsAgo);
    return formatted;
  }

  void emitNewState(RegisterState newState) {
    emit(newState);
  }
}
