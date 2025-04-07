import 'package:glint_frontend/utils/result_sealed.dart';

abstract class ChatRepo {
  Future<Result<void>> fetchStories();

  Future<Result<void>> fetchRecentMatches();

  Future<Result<void>> fetchChannels();

  Future<Result<void>> uploadStory();

  Future<Result<void>> uploadStoryViews();

  Future<Result<void>> replyToStory();
}
