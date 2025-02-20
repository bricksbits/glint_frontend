import 'dart:developer';

import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:glint_frontend/domain/business_logic/models/chat/gemini_message_entity.dart';
import 'package:glint_frontend/domain/business_logic/repo/chat/chat_with_repo.dart';
import 'package:glint_frontend/utils/network_response.dart';

class ChatWithRepoImpl extends ChatWithRepo {
  final Gemini geminiChatInstance;

  ChatWithRepoImpl(this.geminiChatInstance);

  @override
  Future<NetworkResponse<void>> bookTicket() {
    // TODO: implement bookTicket
    throw UnimplementedError();
  }

  @override
  Future<NetworkResponse<List<String>>> generateAiMessage(
      List<GeminiMessageEntity>? historyUpTo) {
    geminiChatInstance
        .chat([
          Content(parts: [
            Part.text('Write the first line of a story about a magic backpack.')
          ], role: 'user'),
          Content(parts: [
            Part.text(
                'In the bustling city of Meadow brook, lived a young girl named Sophie. She was a bright and curious soul with an imaginative mind.')
          ], role: 'model'),
          Content(parts: [
            Part.text('Can you set it in a quiet village in 1600s France?')
          ], role: 'user'),
        ])
        .then((value) => log(value?.output ?? 'without output'))
        .catchError((e) => log('chat', error: e));

    throw Exception();
  }

  @override
  Future<NetworkResponse<void>> reactToMessage() {
    // TODO: implement reactToMessage
    throw UnimplementedError();
  }

  @override
  Future<NetworkResponse<void>> sendOneTimeImageMessage() {
    // TODO: implement sendOneTimeImageMessage
    throw UnimplementedError();
  }

  @override
  Future<NetworkResponse<void>> sendTextMessage() {
    // TODO: implement sendTextMessage
    throw UnimplementedError();
  }
}
