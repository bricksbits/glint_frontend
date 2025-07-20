part of 'service_screen_cubit.dart';

@freezed
class ServiceScreenState with _$ServiceScreenState {
  const factory ServiceScreenState.initial(
      {@Default([]) List<String> alreadySavedImages}) = _Initial;
}
