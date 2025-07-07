import 'package:glint_frontend/domain/business_logic/models/event/event_detail_domain.dart';
import 'package:glint_frontend/domain/business_logic/models/event/event_list_domain_model.dart';
import 'package:glint_frontend/features/people/model/people_card_model.dart';
import 'package:glint_frontend/utils/result_sealed.dart';

abstract class EventRepo {
  Future<Result<List<EventListDomainModel>>> getAllEvents();

  Future<Result<EventDetailsDomainModel>> getEventDetails(int? eventId);

  Future<Result<void>> userInterested(int? eventId);

  Future<Result<List<PeopleCardModel>>> fetchInterestedProfiles(int? eventId);
}
