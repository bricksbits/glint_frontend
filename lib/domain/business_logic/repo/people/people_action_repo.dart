import 'package:glint_frontend/utils/network_response.dart';

abstract class PeopleActionRepo {
  Future<Result<void>> userSwipeGesture();

  Future<Result<void>> superLike();

  Future<Result<void>> directMessage();

  Future<Result<bool>> checkMatch();
}
