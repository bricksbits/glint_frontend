import 'package:glint_frontend/data/local/persist/async_encrypted_shared_preference_helper.dart';
import 'package:glint_frontend/data/remote/client/http_request_enum.dart';
import 'package:glint_frontend/data/remote/client/my_dio_client.dart';
import 'package:glint_frontend/data/remote/model/response/ads/advertiisment_response.dart';
import 'package:glint_frontend/data/remote/model/response/people/get_people_response.dart';
import 'package:glint_frontend/data/remote/utils/api_call_handler.dart';
import 'package:glint_frontend/domain/business_logic/models/ads/ads_list_domain_model.dart';
import 'package:glint_frontend/domain/business_logic/models/common/swipe_gestures_type.dart';
import 'package:glint_frontend/domain/business_logic/repo/people/people_repo.dart';
import 'package:glint_frontend/features/people/model/people_model.dart';
import 'package:glint_frontend/utils/result_sealed.dart';

class PeopleRepoImpl extends PeopleRepo {
  final MyDioClient httpClient;
  final AsyncEncryptedSharedPreferenceHelper sharedPreferenceHelper;

  PeopleRepoImpl(
    this.httpClient,
    this.sharedPreferenceHelper,
  );

  @override
  Future<Result<List<AdsListDomainModel>>> fetchAds() async {
    final response = await apiCallHandler(
      httpClient: httpClient,
      requestType: HttpRequestEnum.GET,
      endpoint: "advertisement",
    );

    switch (response) {
      case Success():
        final adsResponse = AdvertiismentResponse.fromJson(response.data);
        if (adsResponse.ads != null) {
          final adsList = adsResponse.ads
              ?.map((element) => AdsListDomainModel(element))
              .toList();
          return Success(adsList ?? []);
        }
        return const Success([]);
      case Failure():
        return Failure(Exception("Ads List failed : ${response.error}"));
    }
  }

  @override
  Stream<Result<List<PeopleUiModel>>> fetchProfiles() async* {
    final response = await apiCallHandler(
      httpClient: httpClient,
      requestType: HttpRequestEnum.GET,
      endpoint: "user/profile",
    );

    switch (response) {
      case Success():
        final peopleResponse = GetPeopleResponse.fromJson(response);
        if (peopleResponse.profiles != null) {
          final peopleList = peopleResponse.mapToUiModelList();
          if (peopleList != null && peopleList.isNotEmpty) {
            yield Success(peopleList);
          }
        }
        yield const Success([]);
      case Failure():
        yield Failure(Exception("Ads List failed : ${response.error}"));
    }
  }

  @override
  Future<Result<bool>> userSwipeGesture(SwipeGestureType gestureType) {
    // TODO: implement userSwipeGesture
    throw UnimplementedError();
  }
}
