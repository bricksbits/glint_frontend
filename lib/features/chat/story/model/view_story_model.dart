import 'package:glint_frontend/data/remote/model/response/story/story_response_body.dart';

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

extension ViewStoryModelMapper on StoryResponseBody {
  List<ViewStoryModel> mapToUiModel() {
    return data?.stories?.map((item) {
          int storiesViews = item.storyViews ?? 0;
          int storiesLikes = item.storyLikes ?? 0;
          return ViewStoryModel(
            storiesUrl: item.storyUrlList
                    ?.map(
                      (storyData) => storyData.presignedUrl ?? "",
                    )
                    .toList() ??
                [],
            username: item.username ?? "",
            userImageUrl: item.profilePicture ?? "",
            storyViewCount: storiesViews.toString(),
            streakCount: storiesLikes.toString(),
            streamChannelId: item.streamChatChannelId,
          );
        }).toList() ??
        [];
  }
}
