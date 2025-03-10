import 'package:glint_frontend/utils/network_response.dart';

abstract class PeopleRepo {
  Future<Result<void>> fetchAds();

  Stream<Result<void>> fetchProfiles();
}
