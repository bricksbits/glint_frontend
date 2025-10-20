part of 'filter_preferences_cubit.dart';

@freezed
class FilterPreferencesState with _$FilterPreferencesState {
  const factory FilterPreferencesState.initial({
    @Default(19) int minAge,
    @Default(45) int maxAge,
    @Default(20) int maxDistance,
}) = _Initial;
}
