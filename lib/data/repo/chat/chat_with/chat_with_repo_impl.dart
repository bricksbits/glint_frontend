import 'package:glint_frontend/domain/business_logic/repo/chat/chat_with_repo.dart';
import 'package:glint_frontend/utils/result_sealed.dart';
import 'package:injectable/injectable.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart' show Channel;
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart'
    show StreamChatClient, Message;

@LazySingleton(as: ChatWithRepo)
class ChatWithRepoImpl extends ChatWithRepo {
  @override
  Future<Result<void>> sendTextMessage(
    StreamChatClient client,
    Channel channel,
    String message,
  ) async {
    return await channel
        .sendMessage(
          Message(
            text: message,
          ),
        )
        .then((_) => const Result.success(""))
        .onError((error, st) => Result.failure(Exception(error)));
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
