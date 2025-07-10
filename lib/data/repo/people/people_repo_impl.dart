import 'package:glint_frontend/data/local/db/dao/profile_dao.dart';
import 'package:glint_frontend/data/local/db/entities/profile_entity.dart';
import 'package:glint_frontend/data/local/persist/async_encrypted_shared_preference_helper.dart';
import 'package:glint_frontend/data/remote/client/http_request_enum.dart';
import 'package:glint_frontend/data/remote/client/my_dio_client.dart';
import 'package:glint_frontend/data/remote/model/response/ads/advertiisment_response.dart';
import 'package:glint_frontend/data/remote/model/response/mapper/people_mapper.dart';
import 'package:glint_frontend/data/remote/model/response/people/get_people_response.dart';
import 'package:glint_frontend/data/remote/utils/api_call_handler.dart';
import 'package:glint_frontend/domain/business_logic/models/ads/ads_list_domain_model.dart';
import 'package:glint_frontend/domain/business_logic/models/common/swipe_gestures_type.dart';
import 'package:glint_frontend/domain/business_logic/repo/people/people_repo.dart';
import 'package:glint_frontend/features/people/model/people_card_model.dart';
import 'package:glint_frontend/utils/result_sealed.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/transformers.dart';

@LazySingleton(as: PeopleRepo)
class PeopleRepoImpl extends PeopleRepo {
  final MyDioClient httpClient;
  final AsyncEncryptedSharedPreferenceHelper sharedPreferenceHelper;
  final ProfileDao profileDao;

  PeopleRepoImpl(
    this.httpClient,
    this.sharedPreferenceHelper,
    this.profileDao,
  );

  // Todo: Avoid making this call when user is already a member
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

  /// Get Profiles only from DB as source of Truth here.
  /// Todo: Save the current user Id and pass it from here
  @override
  Stream<Result<List<PeopleCardModel>>> getProfilesFromDB(){
    return profileDao.getAllProfiles("1").map((profileEntityList) {
      try {
        final uiModels = profileEntityList
            .map((profileEntity) => profileEntity.mapToPeopleUiModel())
            .toList();
        return Result.success(uiModels);
      } catch (e) {
        return Result<List<PeopleCardModel>>.failure(
            Exception("Stream emission failed, $e"));
      }
    }).onErrorReturnWith((error, st) {
      return Result<List<PeopleCardModel>>.failure(
          Exception("Stream emission failed, $error"));
    });
  }

  @override
  Future<Result<bool>> userSwipeGesture(SwipeGestureType gestureType) {
    // TODO: implement userSwipeGesture
    throw UnimplementedError();
  }

  /// Fetch More profiles and save it to DB
  /// Todo: Create matching entity and models for consistent data flow
  /// Todo: Queries for Pagination
  @override
  Future<Result<void>> fetchProfiles() async {
    final response = await apiCallHandler(
      httpClient: httpClient,
      requestType: HttpRequestEnum.GET,
      endpoint: "user/profile",
    );

    switch (response) {
      case Success():
        final peopleResponse = GetPeopleResponse.fromJson(response.data);
        if (peopleResponse.profiles != null) {
          final peopleList = peopleResponse.mapToProfileEntity();
          if (peopleList != null && peopleList.isNotEmpty) {
            profileDao.insertFetchedProfiles(peopleList);
            return const Success([]);
          }
        }
        return const Success([]);
      case Failure():
        return Failure(
            Exception("No more profiles available : ${response.error}"));
    }
  }
}
