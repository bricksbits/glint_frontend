import 'package:glint_frontend/utils/network_response.dart';

abstract class EventRepo {
  Future<NetworkResponse<void>> getAllEvents();

  Future<NetworkResponse<void>> getEventDetails(int? eventId);

  Future<NetworkResponse<void>> userInterested(int? eventId);

  Future<NetworkResponse<void>> fetchInterestedProfiles(int? eventId);

  Future<NetworkResponse<void>> filterEvents();
}
