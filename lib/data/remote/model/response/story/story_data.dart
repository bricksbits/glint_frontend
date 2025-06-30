import 'package:freezed_annotation/freezed_annotation.dart';
import 'story_url.dart';

part 'story_data.freezed.dart';
part 'story_data.g.dart';

@freezed
class StoryData with _$StoryData {
  const factory StoryData({
    @JsonKey(name: 'story_url_list') required List<StoryUrl> storyUrlList,
    @JsonKey(name: 'stream_chat_channel_id') required String streamChatChannelId,
  }) = _StoryData;

  factory StoryData.fromJson(Map<String, dynamic> json) =>
      _$StoryDataFromJson(json);
}
