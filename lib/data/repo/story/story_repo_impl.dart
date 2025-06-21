import 'package:glint_frontend/domain/business_logic/repo/story/story_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: StoryRepo)
class StoryRepoImpl extends StoryRepo {
  @override
  Future<void> deleteStory() {
    // TODO: implement deleteStory
    throw UnimplementedError();
  }

  @override
  Future<void> getAllStories() {
    // TODO: implement getAllStories
    throw UnimplementedError();
  }

  @override
  Future<void> getMyStories() {
    // TODO: implement getMyStories
    throw UnimplementedError();
  }

  @override
  Future<void> getMyStoriesViewsCount() {
    // TODO: implement getMyStoriesViewsCount
    throw UnimplementedError();
  }

  @override
  Future<void> uploadStory() {
    // TODO: implement uploadStory
    throw UnimplementedError();
  }
}
