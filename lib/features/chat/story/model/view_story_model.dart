import 'package:glint_frontend/data/remote/model/response/story/story_response.dart';

class ViewStoryModel {
  final List<String> storiesUrl;
  final String username;
  final String userImageUrl;
  final String storyViewCount;
  final String streakCount;
  final String? streamChannelId;

  ViewStoryModel({
    required this.storiesUrl,
    required this.username,
    required this.userImageUrl,
    required this.storyViewCount,
    required this.streakCount,
    this.streamChannelId,
  });
}

extension ViewStoryModelMapper on StoryResponse {
  List<ViewStoryModel> mapToUiModel() {
    return story.entries.map((item) {
      return ViewStoryModel(
        storiesUrl: item.value.storyUrlList
            .map(
              (storyData) => storyData.presignedUrl,
            )
            .toList(),
        username: "User, ${item.key}",
        userImageUrl: "",
        storyViewCount: "2",
        streakCount: "32",
        streamChannelId: item.value.streamChatChannelId,
      );
    }).toList();
  }
}
