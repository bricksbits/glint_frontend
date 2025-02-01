import 'package:glint_frontend/utils/network_response.dart';

abstract class PeopleRepo {
  Future<NetworkResponse<void>> fetchAds();

  Stream<NetworkResponse<void>> fetchProfiles();
}
