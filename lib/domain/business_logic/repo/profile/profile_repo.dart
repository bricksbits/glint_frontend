import 'package:glint_frontend/utils/network_response.dart';

abstract class ProfileRepo {
  Future<Result<void>> fetchUserProfile();

  Future<Result<void>> fetchPaymentHistory();

  Future<Result<void>> fetchTicketHistory();

  Future<Result<void>> buySubscription();

  Future<Result<void>> updateProfileData();

  Future<Result<void>> updateMedia();

  Future<Result<void>> verifyUser();
}