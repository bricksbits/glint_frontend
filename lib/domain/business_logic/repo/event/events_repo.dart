import 'package:glint_frontend/utils/result_sealed.dart';

abstract class EventRepo {
  Future<Result<void>> getAllEvents();

  Future<Result<void>> getEventDetails(int? eventId);

  Future<Result<void>> userInterested(int? eventId);

  Future<Result<void>> fetchInterestedProfiles(int? eventId);

  Future<Result<void>> filterEvents();
}
