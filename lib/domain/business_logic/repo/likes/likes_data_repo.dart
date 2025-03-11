import 'package:glint_frontend/utils/network_response.dart';

abstract class LikesDataRepo {
  Future<Result<void>> getUserProfileViews();

  Future<Result<void>> getTopProfiles();

  Future<Result<void>> getLikedProfiles();
}
