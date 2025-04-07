import 'package:glint_frontend/utils/result_sealed.dart';

abstract class SearchPeopleRepo {
  Future<Result<void>> tempSearch();

  Future<Result<void>> persistPreferenceSearch();
}
