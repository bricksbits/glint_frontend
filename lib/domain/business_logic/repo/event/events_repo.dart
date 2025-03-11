import 'package:glint_frontend/utils/network_response.dart';

abstract class EventRepo {
  Future<Result<void>> getAllEvents();

  Future<Result<void>> getEventDetails(int? eventId);

  Future<Result<void>> userInterested(int? eventId);

  Future<Result<void>> fetchInterestedProfiles(int? eventId);

  Future<Result<void>> filterEvents();
}
