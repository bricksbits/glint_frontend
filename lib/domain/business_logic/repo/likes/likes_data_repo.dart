import 'package:glint_frontend/utils/result_sealed.dart';

abstract class LikesDataRepo {
  Future<Result<void>> getUserProfileViews();

  Future<Result<void>> getTopProfiles();

  Future<Result<void>> getLikedProfiles();
}
