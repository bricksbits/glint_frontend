import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:glint_frontend/data/remote/model/request/auth/login_request_body.dart';
import 'package:glint_frontend/di/injection.dart';
import 'package:glint_frontend/domain/application_logic/auth/sign_in_user_use_case.dart';
import 'package:glint_frontend/domain/business_logic/models/auth/register_user_request.dart';
import 'package:glint_frontend/domain/business_logic/repo/auth/authentication_repo.dart';
import 'package:glint_frontend/domain/business_logic/repo/profile/profile_repo.dart';
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
  final ProfileRepo profileRepo = getIt.get<ProfileRepo>();
  final SignInUserUseCase signInUserUseCase = getIt.get<SignInUserUseCase>();

  RegisterCubit() : super(const RegisterState.initial());

  void enteredEmail(String email) {
    emitNewState(state.copyWith(email: email));
  }

  void enteredPassword(String password) {
    emitNewState(
      state.copyWith(
        password: password,
      ),
    );
  }

  void enteredConfirmPassword(String confirmPassword) {
    emitNewState(
      state.copyWith(
        confirmPassword: confirmPassword,
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
  Future<void> registerUser() async {
    _validateEmail();
    if (state.isEmailValid &&
        state.isPassWordValid &&
        state.isConfirmPassword &&
        state.isPhoneNumberValid) {
      emitNewState(
        state.copyWith(
          isLoading: true,
          currentSuccessStatus: "Registering New User",
        ),
      );
      final userRequestModel = await authenticationRepo.getOnBoardedUser();
      if (state.isEmailValid && state.isPassWordValid) {
        final updatedRequestWithCredentials = userRequestModel?.copyWith(
          email: state.email,
          password: state.password,
          phoneNumber: state.contactNumber,
        );
        if (updatedRequestWithCredentials != null) {
          final isRegisteredResponse = await authenticationRepo.createAccount(
            updatedRequestWithCredentials,
            "user",
          );
          switch (isRegisteredResponse) {
            case Success<void>():
              emitNewState(
                state.copyWith(
                    currentSuccessStatus:
                        "Registered, Setting up your profile,"),
              );
              await authenticationRepo.clearTheDbAfterRegistration();
              await _loginUser(
                state.email,
                state.password,
              );
              break;
            case Failure<void>():
              final reason = isRegisteredResponse.message ??
                  "Register Action failed, please try again.";
              emitNewState(
                state.copyWith(
                  isLoading: false,
                  isRegisteredSuccessfully: false,
                  currentSuccessStatus: "Register Action Failed,",
                  error: reason,
                ),
              );
          }
        }
      } else {
        emit(
          state.copyWith(
              isPassWordValid: false,
              isEmailValid: false,
              error: "Email or password is not valid,"),
        );
      }
    } else {
      _validateEmail();
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
        if (error is Failure) {
          final reason = error.message ?? "Login Failed";
          emit(
            state.copyWith(
              isLoading: false,
              isRegisteredSuccessfully: false,
              error: reason,
            ),
          );
        } else {
          emit(
            state.copyWith(
                isLoading: false,
                isRegisteredSuccessfully: false,
                error: "Authentication failed."),
          );
        }
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
        imageService.clearProfileImagesDirectory();
        break;
      case Failure<void>():
        final reason = imagesUploadResponse.message ?? "Files Upload failed";
        emitNewState(
          state.copyWith(
            isLoading: false,
            error: reason,
          ),
        );
        break;
    }
  }

  Future<void> registerAsAAdmin() async {
    RegisterUserRequest fakeAdminRegisterModel = RegisterUserRequest(
      "ADMIN_USER_ID_TEMP",
      state.name,
      state.email,
      state.password,
      state.contactNumber,
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
      state.contactNumber.isNotEmpty ? state.contactNumber : null,
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

  void _validateEmail() {
    String? error;
    if (state.email.isEmpty) {
      error = 'Email cannot be empty.';
    } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
        .hasMatch(state.email)) {
      error = 'Please enter a valid email address.';
    }

    if (error != null) {
      emitNewState(
        state.copyWith(
          isEmailValid: false,
          error: error,
        ),
      );
    } else {
      error = null;
      emitNewState(
        state.copyWith(
          isEmailValid: true,
          error: "",
        ),
      );
      _validatePassword();
    }
  }

  void _validatePassword() {
    String? error;
    const int minLength = 10;

    if (state.password.isEmpty) {
      error = 'Password cannot be empty.';
    } else if (state.password.length < minLength) {
      error = 'Password must be at least 10 characters.';
    }

    // Emit a new state ONLY if the error status has changed
    if (error != null) {
      emitNewState(
        state.copyWith(
          isPassWordValid: false,
          error: error,
        ),
      );
    } else {
      emitNewState(
        state.copyWith(
          isPassWordValid: true,
          error: "",
        ),
      );
      _validateConfirmPassword();
    }
  }

  void _validateConfirmPassword() {
    String? error;
    const int minLength = 10;

    if (state.confirmPassword.isEmpty) {
      error = 'Confirm Password cannot be empty.';
    } else if (state.confirmPassword.length < minLength) {
      error = 'Confirm Password must be at least $minLength characters.';
    } else if (state.confirmPassword != state.password) {
      error = 'Password and Confirm Password does not match';
    }

    if (error != null) {
      emitNewState(
        state.copyWith(
          isConfirmPassword: false,
          error: error,
        ),
      );
    } else {
      emitNewState(
        state.copyWith(
          isConfirmPassword: true,
          error: "",
        ),
      );
      _validatePhoneNumber();
    }
  }

  void _validatePhoneNumber() {
    final phone = state.contactNumber.trim();
    String? error;

    if (phone.isEmpty) {
      error = 'Phone number cannot be empty.';
    } else if (!RegExp(r'^[6-9]\d{9}$').hasMatch(phone)) {
      error = 'Please enter a valid 10-digit mobile number.';
    }

    if (error != null) {
      emitNewState(state.copyWith(isPhoneNumberValid: false, error: error));
    } else {
      emitNewState(state.copyWith(isPhoneNumberValid: true, error: ""));
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
