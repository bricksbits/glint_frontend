import 'package:glint_frontend/utils/network_response.dart';

abstract class ChatRepo {
  Future<NetworkResponse<void>> fetchStories();

  Future<NetworkResponse<void>> fetchRecentMatches();

  Future<NetworkResponse<void>> fetchChannels();

  Future<NetworkResponse<void>> uploadStory();

  Future<NetworkResponse<void>> uploadStoryViews();

  Future<NetworkResponse<void>> replyToStory();
}
