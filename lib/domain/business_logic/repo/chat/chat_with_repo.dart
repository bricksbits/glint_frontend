import 'package:glint_frontend/utils/network_response.dart';

abstract class ChatWithRepo {
  Future<Result<void>> sendTextMessage();

  Future<Result<void>> sendOneTimeImageMessage();

  Future<Result<void>> generateAiMessage();

  Future<Result<void>> reactToMessage();

  Future<Result<void>> bookTicket();
}
