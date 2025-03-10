import 'package:glint_frontend/utils/network_response.dart';

abstract class EventRepo {
  Future<Result<void>> getAllEvents();

  Future<Result<void>> getEventDetails();

  Future<Result<void>> userInterested();

  Future<Result<void>> fetchInterestedProfiles();

  Future<Result<void>> filterEvents();
}
