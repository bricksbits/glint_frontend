import 'package:freezed_annotation/freezed_annotation.dart';
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

