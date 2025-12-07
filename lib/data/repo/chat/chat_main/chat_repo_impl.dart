import 'dart:async';

import 'package:glint_frontend/data/remote/client/http_request_enum.dart';
import 'package:glint_frontend/data/remote/client/my_dio_client.dart';
import 'package:glint_frontend/data/remote/model/response/chat/get_recent_matches_response.dart';
import 'package:glint_frontend/data/remote/model/response/story/story_response.dart';
import 'package:glint_frontend/data/remote/utils/api_call_handler.dart';
import 'package:glint_frontend/domain/business_logic/repo/chat/chat_repo.dart';
import 'package:glint_frontend/features/chat/story/model/recent_matches_model.dart';
import 'package:glint_frontend/features/chat/story/model/view_story_model.dart';
import 'package:glint_frontend/utils/result_sealed.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ChatRepo)
class ChatRepoImpl extends ChatRepo {
  final MyDioClient httpClient;

  ChatRepoImpl(
    this.httpClient,
  );

  @override
  Future<Result<void>> fetchChannels() {
    // TODO: implement fetchChannels
    throw UnimplementedError();
  }

  @override
  Future<Result<List<RecentMatchesModel>>> fetchRecentMatches() async {
    final response = await apiCallHandler(
      httpClient: httpClient,
      requestType: HttpRequestEnum.GET,
      endpoint: "user/recent-matches",
    );

    switch (response) {
      case Success():
        final recentMatchesResponse =
            GetRecentMatchesResponse.fromJson(response.data);
        final matches = recentMatchesResponse.mapToUiModel();
        return Success(matches);
      case Failure():
        return Failure(
          Exception("No Recent matches found"),
        );
    }
  }

  @override
  Future<Result<List<ViewStoryModel>>> fetchStories() async {
    final response = await apiCallHandler(
      httpClient: httpClient,
      requestType: HttpRequestEnum.GET,
      endpoint: "user/content/story",
    );

    switch (response) {
      case Success():
        final storiesResponse = StoryResponse.fromJson(response.data);
        final stories = storiesResponse.mapToUiModel();
        return Success(stories);
      case Failure():
        return Failure(Exception("No stories found"));
    }
  }
}
