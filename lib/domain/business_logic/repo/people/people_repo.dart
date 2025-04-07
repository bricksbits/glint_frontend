import 'package:glint_frontend/utils/result_sealed.dart';

abstract class PeopleRepo {
  Future<Result<void>> fetchAds();

  Stream<Result<void>> fetchProfiles();
}
