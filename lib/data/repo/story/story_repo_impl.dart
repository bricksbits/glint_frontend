import 'dart:io';

import 'package:dio/dio.dart';
import 'package:glint_frontend/data/local/persist/async_encrypted_shared_preference_helper.dart';
import 'package:glint_frontend/data/remote/client/http_request_enum.dart';
import 'package:glint_frontend/data/remote/client/my_dio_client.dart';
import 'package:glint_frontend/data/remote/model/response/chat/story_upload_response.dart';
import 'package:glint_frontend/data/remote/model/response/story/story_response.dart';
import 'package:glint_frontend/data/remote/utils/api_call_handler.dart';
import 'package:glint_frontend/domain/business_logic/models/chat/get_story_model.dart';
import 'package:glint_frontend/domain/business_logic/repo/story/story_repo.dart';
import 'package:glint_frontend/utils/result_sealed.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: StoryRepo)
class StoryRepoImpl extends StoryRepo {
  final MyDioClient httpClient;
  final AsyncEncryptedSharedPreferenceHelper sharedPreferenceHelper;

  StoryRepoImpl(this.httpClient, this.sharedPreferenceHelper);

  @override
  Future<void> deleteStory() {
    // TODO: implement deleteStory
    throw UnimplementedError();
  }

  @override
  Future<Result<List<GetStoryModel>>> getAllStories() async {
    final response = await apiCallHandler(
      httpClient: httpClient,
      requestType: HttpRequestEnum.GET,
      endpoint: "user/content/story",
    );

    switch (response) {
      case Success():
        final storiesResponse = StoryResponse.fromJson(response.data);
        final stories = storiesResponse.mapToDomain();
        return Success(stories);
      case Failure():
        return Failure(Exception("No stories found"));
    }
  }

  @override
  Future<void> getMyStories() {
    // TODO: implement getMyStories
    throw UnimplementedError();
  }

  @override
  Future<int> getMyStoriesViewsCount() async {
    Future.delayed(const Duration(milliseconds: 500));
    return 20;
  }

  @override
  Future<Result<bool>> uploadStory(File newlyUploadedStoryFile) async {
    String fileName = newlyUploadedStoryFile.path.split('/').last;
    FormData formData = FormData.fromMap({
      'story': await MultipartFile.fromFile(newlyUploadedStoryFile.path,
          filename: fileName),
    });

    final response = await apiCallHandler(
        httpClient: httpClient,
        requestType: HttpRequestEnum.UPLOAD,
        endpoint: "user/content/story",
        uploadFilesFormData: formData);

    switch (response) {
      case Success():
        final storiesResponse = StoryUploadResponse.fromJson(response.data);
        if (storiesResponse.filesUploaded?.isNotEmpty == true) {
          return const Success(true);
        } else {
          return Failure(
            Exception("Story ${newlyUploadedStoryFile.path} failed to upload"),
          );
        }
      case Failure():
        return Failure(
          Exception("Not able to upload stories currently, please try again."),
        );
    }
  }
}
