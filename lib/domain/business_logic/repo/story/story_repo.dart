import 'dart:io';

import 'package:glint_frontend/features/chat/story/model/view_story_model.dart';
import 'package:glint_frontend/utils/result_sealed.dart';

abstract class StoryRepo {
  Future<Result<ViewStoryModel>> getMyStories();

  Future<Result<bool>> uploadStory(File newlyUploadedStoryFile);

  Future<Result<void>> deleteStory(File selectedStory);

  Future<Result<void>> likeStory(int storyOwnerId, String storyId);

  Future<Result<void>> disLikeStory(int storyOwnerId, String storyId);
}
