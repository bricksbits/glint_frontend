import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
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

  SplashScreenBloc() : super(const SplashScreenState.initial()) {
    on<_Started>((event, emit) async {
      await _connectToStreamClient();
      isUserLoggedInUsecase.perform(
        (isLoggedIn) {
          if (isLoggedIn != null) {
            var type = getUserTypeFromName(isLoggedIn);
            switch (type) {
              case UsersType.USER:
                add(
                  SplashScreenEvent.emitNewStates(
                    SplashScreenState.navigateTo(
                      GlintMainRoutes.home.name,
                    ),
                  ),
                );
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
  }

  void emitStates(SplashScreenState states) {}

  Future<void> _connectToStreamClient() async {
    final StreamChatClient chatClient = getIt.get();
    final userId = await getUserId();
    final userToken = await getUserToken(userId);
    await chatClient.connectUser(
      User(id: userId),
      userToken,
    );
  }

  // Todo: Fetch this from Data Layer
  Future<String> getUserId() async {
    return 'tutorial-flutter';
  }

  Future<String> getUserToken(String userId) async {
    return 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoidHV0b3JpYWwtZmx1dHRlciJ9.S-MJpoSwDiqyXpUURgO5wVqJ4vKlIVFLSEyrFYCOE1c';
  }
}
