part of 'splash_screen_bloc.dart';

@freezed
class SplashScreenEvent with _$SplashScreenEvent {
  const factory SplashScreenEvent.started() = _Started;
  const factory SplashScreenEvent.emitNewStates(SplashScreenState passedState) = _EmitStates;
  const factory SplashScreenEvent.startSplashAnimation() = _SplashAnimationStarted;
}
