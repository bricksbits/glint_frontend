import 'package:glint_frontend/utils/network_response.dart';

abstract class ProfileRepo {
  Future<NetworkResponse<void>> fetchUserProfile();

  Future<NetworkResponse<void>> fetchPaymentHistory();

  Future<NetworkResponse<void>> fetchTicketHistory();

  Future<NetworkResponse<void>> buySubscription();

  Future<NetworkResponse<void>> updateProfileData();

  Future<NetworkResponse<void>> updateMedia();

  Future<NetworkResponse<void>> verifyUser();
}