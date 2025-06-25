import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:glint_frontend/domain/business_logic/models/chat/get_story_model.dart';
import 'package:glint_frontend/features/chat/story/model/story_model.dart';
import 'story_data.dart';

part 'story_response.freezed.dart';

part 'story_response.g.dart';

@freezed
class StoryResponse with _$StoryResponse {
  const factory StoryResponse({
    required Map<String, StoryData> story,
  }) = _StoryResponse;

  factory StoryResponse.fromJson(Map<String, dynamic> json) =>
      _$StoryResponseFromJson(json);
}

extension StoryMappers on StoryResponse {
  List<GetStoryModel> mapToDomain() {
    final List<GetStoryModel> stories = [];
    story.forEach((userId, storyData) {
      final s = GetStoryModel(
          userId,
          storyData.storyUrlList
              .map((storyUrl) => "$storyUrl.${storyUrl.fileExtension}")
              .toList(),
          storyData.streamChatChannelId);
      stories.add(s);
    });
    return stories;
  }
}
