import 'package:glint_frontend/domain/business_logic/models/chat/gemini_message_entity.dart';
import 'package:glint_frontend/utils/network_response.dart';

abstract class ChatWithRepo {
  Future<NetworkResponse<void>> sendTextMessage();

  Future<NetworkResponse<void>> sendOneTimeImageMessage();

  Future<NetworkResponse<List<String>>> generateAiMessage(
      List<GeminiMessageEntity>? historyUpTo);

  Future<NetworkResponse<void>> reactToMessage();

  Future<NetworkResponse<void>> bookTicket();
}
