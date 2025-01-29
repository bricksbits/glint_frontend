import 'package:glint_frontend/utils/network_response.dart';

abstract class LikesDataRepo {
  Future<NetworkResponse<void>> getUserProfileViews();

  Future<NetworkResponse<void>> getTopProfiles();

  Future<NetworkResponse<void>> getLikedProfiles();
}
