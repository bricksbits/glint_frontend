import 'dart:io';

import 'package:dio/dio.dart';
import 'package:glint_frontend/data/local/persist/async_encrypted_shared_preference_helper.dart';
import 'package:glint_frontend/data/remote/client/http_request_enum.dart';
import 'package:glint_frontend/data/remote/client/my_dio_client.dart';
import 'package:glint_frontend/data/remote/model/response/chat/story_upload_response.dart';
import 'package:glint_frontend/data/remote/utils/api_call_handler.dart';
import 'package:glint_frontend/domain/business_logic/repo/story/story_repo.dart';
import 'package:glint_frontend/features/chat/story/model/view_story_model.dart';
import 'package:glint_frontend/utils/result_sealed.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: StoryRepo)
class StoryRepoImpl extends StoryRepo {
  final MyDioClient httpClient;
  final AsyncEncryptedSharedPreferenceHelper sharedPreferenceHelper;

  StoryRepoImpl(this.httpClient, this.sharedPreferenceHelper);

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

  @override
  Future<void> deleteStory(File selectedStory) {
    // TODO: implement deleteStory
    throw UnimplementedError();
  }

  @override
  Future<Result<List<ViewStoryModel>>> getMyStories() async {
    await Future.delayed(const Duration(milliseconds: 800));
    return Success(
      [
        ViewStoryModel(
          storyUrl:
              "https://images.unsplash.com/photo-1493612276216-ee3925520721?q=80&w=1064&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
          username: "",
          userImageUrl:
              "https://fastly.picsum.photos/id/237/200/300.jpg?hmac=TmmQSbShHz9CdQm0NkEjx1Dyh_Y984R9LpNrpvH2D_U",
          storyViewCount: "20",
          streakCount: "",
        ),
        ViewStoryModel(
          storyUrl:
              "https://images.unsplash.com/photo-1493612276216-ee3925520721?q=80&w=1064&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
          username: "",
          userImageUrl:
              "https://fastly.picsum.photos/id/237/200/300.jpg?hmac=TmmQSbShHz9CdQm0NkEjx1Dyh_Y984R9LpNrpvH2D_U",
          storyViewCount: "18",
          streakCount: "",
        ),
      ],
    );
  }
}
