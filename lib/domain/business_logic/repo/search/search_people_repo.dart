import 'package:glint_frontend/utils/network_response.dart';

abstract class SearchPeopleRepo {
  Future<Result<void>> tempSearch();

  Future<Result<void>> persistPreferenceSearch();
}
