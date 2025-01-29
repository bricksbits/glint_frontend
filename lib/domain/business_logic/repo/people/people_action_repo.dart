import 'package:glint_frontend/utils/network_response.dart';

abstract class PeopleActionRepo {
  Future<NetworkResponse<void>> userSwipeGesture();

  Future<NetworkResponse<void>> superLike();

  Future<NetworkResponse<void>> directMessage();

  Future<NetworkResponse<bool>> checkMatch();
}
