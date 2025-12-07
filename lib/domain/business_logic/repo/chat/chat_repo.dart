import 'package:glint_frontend/features/chat/story/model/recent_matches_model.dart';
import 'package:glint_frontend/features/chat/story/model/view_story_model.dart';
import 'package:glint_frontend/utils/result_sealed.dart';

abstract class ChatRepo {
  Future<Result<List<ViewStoryModel>>> fetchStories();

  Future<void> fetchRecentMatches();

  Future<Result<void>> fetchChannels();

  void disposeRecentChatStream();

  Stream<Result<List<RecentMatchesModel>>> recentMatchesStreamGetter();
}
