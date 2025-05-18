import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:glint_frontend/di/injection.dart';
import 'package:glint_frontend/domain/application_logic/auth/is_user_logged_in_use_case.dart';
import 'package:glint_frontend/navigation/glint_all_routes.dart';

part 'splash_screen_event.dart';

part 'splash_screen_state.dart';

part 'splash_screen_bloc.freezed.dart';

class SplashScreenBloc extends Bloc<SplashScreenEvent, SplashScreenState> {
  final Future<IsUserLoggedInUsecase> isUserLoggedInUsecase = getIt.getAsync();

  SplashScreenBloc() : super(const SplashScreenState.initial()) {
    on<SplashScreenEvent>((event, emit) async {
      final usecase = await isUserLoggedInUsecase;
      usecase.perform((isLoggedIn) {
        if (isLoggedIn != null) {
          if (isLoggedIn) {
            emit(SplashScreenState.navigateTo(
                GlintAdminDasboardRoutes.home.name));
          } else {
            emit(SplashScreenState.navigateTo(
                GlintAdminDasboardRoutes.auth.name));
          }
        }
      }, (onError) {
        print("Something went wrong");
      }, () {
        print("on Done, Splash Screen Bloc");
      });
    });
  }
}
