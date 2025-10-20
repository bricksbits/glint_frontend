import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:glint_frontend/di/injection.dart';
import 'package:glint_frontend/domain/business_logic/repo/people/people_repo.dart';

part 'filter_preferences_state.dart';

part 'filter_preferences_cubit.freezed.dart';

class FilterPreferencesCubit extends Cubit<FilterPreferencesState> {
  final PeopleRepo peopleRepo = getIt.get<PeopleRepo>();

  FilterPreferencesCubit() : super(const FilterPreferencesState.initial()) {
    initSearchScreen();
  }

  Future<void> updateAgePreferences(int minAge, int maxAge) async {
    peopleRepo.setupMinAndMaxDistanceForProfile(minAge, maxAge);
  }

  Future<void> updateDistancePreferences(int maxDistance) async {
    peopleRepo.setupDistanceForProfileSearch(maxDistance);
  }

  Future<void> applyChanges() async {
    await peopleRepo.fetchProfiles(0);
  }

  Future<void> initSearchScreen() async {
    final (minAge, maxAge, maxDistance) =
        await peopleRepo.getSavedSearchConfig();
    emitNewState(state.copyWith(
        minAge: minAge, maxAge: maxAge, maxDistance: maxDistance));
  }

  void emitNewState(FilterPreferencesState newState) {
    emit(newState);
  }
}
