import 'package:glint_frontend/utils/network_response.dart';

abstract class ChatWithRepo {
  Future<NetworkResponse<void>> sendTextMessage();

  Future<NetworkResponse<void>> sendOneTimeImageMessage();

  Future<NetworkResponse<void>> generateAiMessage();

  Future<NetworkResponse<void>> reactToMessage();

  Future<NetworkResponse<void>> bookTicket();
}
