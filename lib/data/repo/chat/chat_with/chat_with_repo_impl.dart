import 'package:glint_frontend/data/remote/client/http_request_enum.dart';
import 'package:glint_frontend/data/remote/client/my_dio_client.dart';
import 'package:glint_frontend/data/remote/model/request/chat/like_story_request_body.dart';
import 'package:glint_frontend/data/remote/model/response/universal/universal_success_response_body.dart';
import 'package:glint_frontend/data/remote/utils/api_call_handler.dart';
import 'package:glint_frontend/domain/business_logic/repo/chat/chat_with_repo.dart';
import 'package:glint_frontend/services/chat_service.dart';
import 'package:glint_frontend/utils/logger.dart';
import 'package:glint_frontend/utils/result_sealed.dart';
import 'package:injectable/injectable.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart' show Channel;
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart'
    show StreamChatClient, Message;

@LazySingleton(as: ChatWithRepo)
class ChatWithRepoImpl extends ChatWithRepo {
  final MyDioClient httpClient;
  final ChatService chatService;

  ChatWithRepoImpl(
    this.httpClient,
    this.chatService,
  );

  @override
  Future<Result<void>> sendTextMessage(
    String channelId,
    String message, {
    bool isReplyingToStory = true,
  }) async {
    return await chatService
        .sendMessageToChannel(
            channelId: channelId,
            text: message,
            isStoryReply: isReplyingToStory)
        .then((_) => const Result.success(""))
        .onError((error, st) => Result.failure(Exception(error)));
  }

  @override
  Future<void> likeStory(
    String storyOwnerUserId,
    String storyUuid,
  ) async {
    final requestbody = LikeStoryRequestBody(
        storyOwnerUserId: int.parse(storyOwnerUserId), storyUuid: storyUuid);

    final response = await apiCallHandler(
      httpClient: httpClient,
      requestType: HttpRequestEnum.POST,
      endpoint: "user/content/story/like",
      requestBody: requestbody.toJson(),
    );

    switch (response) {
      case Success():
        final storiesResponse =
            UniversalSuccessResponseBody.fromJson(response.data, (json) {});
        if (storiesResponse.success == true) {
          debugLogger("[LikeStory]", storiesResponse.message);
        } else {
          debugLogger("[LikeStory]", storiesResponse.message);
        }
      case Failure():
        debugLogger("[LikeStory]", response.error.toString());
    }
  }

  @override
  Future<Result<void>> bookTicket() {
    // TODO: implement bookTicket
    throw UnimplementedError();
  }

  @override
  Future<Result<void>> generateAiMessage() {
    // TODO: implement generateAiMessage
    throw UnimplementedError();
  }

  @override
  Future<Result<void>> reactToMessage() {
    // TODO: implement reactToMessage
    throw UnimplementedError();
  }

  @override
  Future<Result<void>> sendOneTimeImageMessage() {
    // TODO: implement sendOneTimeImageMessage
    throw UnimplementedError();
  }
}
