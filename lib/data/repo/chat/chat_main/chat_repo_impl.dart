import 'package:dio/dio.dart';
import 'package:glint_frontend/data/local/persist/async_encrypted_shared_preference_helper.dart';
import 'package:glint_frontend/data/remote/client/http_request_enum.dart';
import 'package:glint_frontend/data/remote/client/my_dio_client.dart';
import 'package:glint_frontend/data/remote/model/response/story/story_response.dart';
import 'package:glint_frontend/data/remote/utils/api_call_handler.dart';
import 'package:glint_frontend/domain/business_logic/repo/chat/chat_repo.dart';
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
  Future<Result<void>> fetchRecentMatches() {
    // TODO: implement fetchRecentMatches
    throw UnimplementedError();
  }

  @override
  Future<Result<void>> fetchStories() async {
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
}
