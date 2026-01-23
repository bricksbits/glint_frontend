import 'dart:convert';

import 'package:glint_frontend/data/local/persist/async_encrypted_shared_preference_helper.dart';
import 'package:glint_frontend/data/remote/client/http_request_enum.dart';
import 'package:glint_frontend/data/remote/client/my_dio_client.dart';
import 'package:glint_frontend/data/remote/model/response/mapper/people_mapper.dart';
import 'package:glint_frontend/data/remote/model/response/people/get_people_response.dart';
import 'package:glint_frontend/data/remote/model/response/universal/universal_error_response_body.dart';
import 'package:glint_frontend/data/remote/model/response/universal/universal_success_response_body.dart';
import 'package:glint_frontend/data/remote/utils/api_call_handler.dart';
import 'package:glint_frontend/domain/business_logic/repo/likes/likes_data_repo.dart';
import 'package:glint_frontend/features/people/model/people_card_model.dart';
import 'package:glint_frontend/utils/result_sealed.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: LikesDataRepo)
class LikesDataRepoImpl extends LikesDataRepo {
  final MyDioClient httpClient;
  final AsyncEncryptedSharedPreferenceHelper sharedPreferenceHelper;

  LikesDataRepoImpl(
    this.httpClient,
    this.sharedPreferenceHelper,
  );

  @override
  Future<Result<List<PeopleCardModel>>> getLikedProfiles() async {
    final response = await apiCallHandler(
      httpClient: httpClient,
      requestType: HttpRequestEnum.GET,
      endpoint: "user/right-swipes",
    );

    switch (response) {
      case Success():
        final peopleResponse =
            UniversalSuccessResponseBody<GetPeopleResponse>.fromJson(
          response.data,
          (json) => GetPeopleResponse.fromJson(json),
        );
        if (peopleResponse.success && peopleResponse.data != null) {
          if (peopleResponse.data?.profiles != null) {
            final peopleList = peopleResponse.data!.mapToUiModel();
            if (peopleList.isNotEmpty) {
              return Success(peopleList);
            }
          }
          return const Success([]);
        } else {
          return Failure(Exception(peopleResponse.message));
        }

      case Failure():
        return Failure(
          Exception("No more profiles available : ${response.error}"),
        );
    }
  }

  @override
  Future<Result<List<PeopleCardModel>>> getSuperLikedProfiles() async {
    final response = await apiCallHandler(
      httpClient: httpClient,
      requestType: HttpRequestEnum.GET,
      endpoint: "user/super-likes",
    );

    switch (response) {
      case Success():
        final peopleResponse =
            UniversalSuccessResponseBody<GetPeopleResponse>.fromJson(
          response.data,
          (json) => GetPeopleResponse.fromJson(json),
        );
        if (peopleResponse.success && peopleResponse.data != null) {
          if (peopleResponse.data?.profiles != null) {
            final peopleList = peopleResponse.data!.mapToUiModel();
            if (peopleList.isNotEmpty) {
              return Success(peopleList);
            }
          }
          return const Success([]);
        } else {
          return Failure(Exception(peopleResponse.message));
        }
      case Failure():
        return Failure(
          Exception("No more profiles available : ${response.error}"),
        );
    }
  }

  @override
  Future<Result<List<PeopleCardModel>>> getTopProfiles() async {
    final response = await apiCallHandler(
      httpClient: httpClient,
      requestType: HttpRequestEnum.GET,
      endpoint: "user/top-profiles",
    );

    switch (response) {
      case Success():
        final peopleResponse =
            UniversalSuccessResponseBody<GetPeopleResponse>.fromJson(
          response.data,
          (json) => GetPeopleResponse.fromJson(json),
        );
        if (peopleResponse.success && peopleResponse.data != null) {
          if (peopleResponse.data?.profiles != null) {
            final peopleList = peopleResponse.data!.mapToUiModel();
            if (peopleList.isNotEmpty) {
              return Success(peopleList);
            }
          }
          return const Success([]);
        } else {
          return Failure(Exception(peopleResponse.message));
        }
      case Failure():
        return Failure(
          Exception("No more profiles available : ${response.error}"),
        );
    }
  }

  @override
  Future<Result<int>> getUserProfileViews() async {
    // TODO: Save the Profiles Views count while logging and Save it to the Shared pref.
    return const Success(45);
  }
}
