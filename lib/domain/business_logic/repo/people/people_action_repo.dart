import 'package:glint_frontend/utils/result_sealed.dart';

abstract class PeopleActionRepo {
  Future<Result<void>> userSwipeGesture();

  Future<Result<void>> superLike();

  Future<Result<void>> directMessage();

  Future<Result<bool>> checkMatch();
}
