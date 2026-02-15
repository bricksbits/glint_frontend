import 'package:glint_frontend/utils/result_sealed.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart'
    show StreamChatClient;
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart'
    show Channel;

abstract class ChatWithRepo {
  Future<Result<void>> sendTextMessage(
    String channelId,
    String message, {
    bool isReplyingToStory = true,
  });

  Future<Result<void>> sendOneTimeImageMessage();

  Future<Result<void>> generateAiMessage();

  Future<Result<void>> reactToMessage();

  Future<Result<void>> bookTicket();

  Future<void> likeStory(
    String storyOwnerUserId,
    String storyUuid,
  );
}
