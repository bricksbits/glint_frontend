import 'package:glint_frontend/utils/network_response.dart';

abstract class EventRepo {
  Future<NetworkResponse<void>> getAllEvents();
  Future<NetworkResponse<void>> getEventDetails();
  Future<NetworkResponse<void>> userInterested();
  Future<NetworkResponse<void>> fetchInterestedProfiles();
  Future<NetworkResponse<void>> filterEvents();
}