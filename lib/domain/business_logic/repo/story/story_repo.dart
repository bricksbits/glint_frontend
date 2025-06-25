import 'dart:io';

import 'package:glint_frontend/data/remote/model/response/chat/story_upload_response.dart';
import 'package:glint_frontend/domain/business_logic/models/chat/get_story_model.dart';
import 'package:glint_frontend/utils/result_sealed.dart';

abstract class StoryRepo {
  Future<Result<List<GetStoryModel>>> getAllStories();

  Future<void> getMyStories();

  Future<Result<bool>> uploadStory(File newlyUploadedStoryFile);

  Future<void> deleteStory();

  Future<int> getMyStoriesViewsCount();
}
