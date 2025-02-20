import 'package:glint_frontend/utils/network_response.dart';

abstract class SearchPeopleRepo {
  Future<NetworkResponse<void>> tempSearch();

  Future<NetworkResponse<void>> persistPreferenceSearch();
}
