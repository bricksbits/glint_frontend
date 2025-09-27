import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:glint_frontend/data/local/persist/async_encrypted_shared_preference_helper.dart';
import 'package:glint_frontend/data/local/persist/shared_pref_key.dart';
import 'package:glint_frontend/di/injection.dart';
import 'package:glint_frontend/domain/application_logic/auth/is_user_logged_in_use_case.dart';
import 'package:glint_frontend/domain/business_logic/models/common/UsersType.dart';
import 'package:glint_frontend/navigation/glint_all_routes.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

part 'splash_screen_event.dart';

part 'splash_screen_state.dart';

part 'splash_screen_bloc.freezed.dart';

class SplashScreenBloc extends Bloc<SplashScreenEvent, SplashScreenState> {
  final IsUserLoggedInUsecase isUserLoggedInUsecase = getIt.get();
  final AsyncEncryptedSharedPreferenceHelper sharedPreferenceHelper =
      getIt.get();

  SplashScreenBloc() : super(const SplashScreenState.initial()) {
    on<_Started>((event, emit) async {
      isUserLoggedInUsecase.perform(
        (isLoggedIn) {
          if (isLoggedIn != null) {
            var type = getUserTypeFromName(isLoggedIn);
            switch (type) {
              case UsersType.USER:
                _connectToStreamClient().then((_) {
                  add(
                    SplashScreenEvent.emitNewStates(
                      SplashScreenState.navigateTo(
                        GlintMainRoutes.home.name,
                      ),
                    ),
                  );
                }, onError: (e, st) {
                  add(
                    SplashScreenEvent.emitNewStates(
                      SplashScreenState.navigateTo(
                        GlintMainRoutes.home.name,
                      ),
                    ),
                  );
                });
                break;
              case UsersType.ADMIN:
                add(
                  SplashScreenEvent.emitNewStates(
                    SplashScreenState.navigateTo(
                      GlintAdminDasboardRoutes.adminHome.name,
                    ),
                  ),
                );
                break;
              case UsersType.SUPER_ADMIN:
                add(
                  SplashScreenEvent.emitNewStates(
                    SplashScreenState.navigateTo(
                      GlintAdminDasboardRoutes.superAdminHome.name,
                    ),
                  ),
                );
                break;
            }
          } else {
            add(
              SplashScreenEvent.emitNewStates(
                SplashScreenState.navigateTo(
                  GlintMainRoutes.starter.name,
                ),
              ),
            );
          }
        },
        (onError) {
          emit(const SplashScreenState.splashFailure());
        },
        () {},
      );
    });

    on<_SplashAnimationStarted>((event, emit) {
      emit(const SplashScreenState.splashSuccess());
    });

    on<_EmitStates>((event, emit) {
      final newState = event.passedState;
      emit(newState);
    });

    on<_ConnectToStreamClient>((event, emit) {
      _connectToStreamClient();
    });
  }

  void emitStates(SplashScreenState states) {}

  Future<void> _connectToStreamClient() async {
    final StreamChatClient chatClient = getIt.get<StreamChatClient>();
    final userId = await getUserId();
    final userToken = await getUserToken(userId);
    final userName = await getUserName();
    final userImage = await getUserImage();
    await chatClient.connectUser(
      User(
        id: userId,
        name: userName,
        image: userImage
      ),
      userToken,
    );
  }

  Future<String> getUserImage() async {
    final pic =
    await sharedPreferenceHelper.getString(SharedPreferenceKeys.userPrimaryPicUrlKey);
    return pic;
  }

  Future<String> getUserId() async {
    final userId =
        await sharedPreferenceHelper.getString(SharedPreferenceKeys.userIdKey);
    return "user_$userId";
  }

  Future<String> getUserName() async {
    final userName = await sharedPreferenceHelper
        .getString(SharedPreferenceKeys.userNameKey);
    return userName;
  }

  Future<String> getUserToken(String userId) async {
    final userToken = await sharedPreferenceHelper
        .getString(SharedPreferenceKeys.streamTokenKey);
    return userToken;
  }
}
