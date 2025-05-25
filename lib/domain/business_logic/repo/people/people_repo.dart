import 'package:glint_frontend/domain/business_logic/models/ads/ads_list_domain_model.dart';
import 'package:glint_frontend/domain/business_logic/models/common/swipe_gestures_type.dart';
import 'package:glint_frontend/features/people/model/people_model.dart';
import 'package:glint_frontend/utils/result_sealed.dart';

abstract class PeopleRepo {
  Future<Result<List<AdsListDomainModel>>> fetchAds();

  Stream<Result<List<PeopleUiModel>>> fetchProfiles();

  Future<Result<bool>> userSwipeGesture(SwipeGestureType gestureType);
}
