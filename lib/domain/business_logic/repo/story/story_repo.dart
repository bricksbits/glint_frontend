abstract class StoryRepo {
  Future<void> getAllStories();

  Future<void> getMyStories();

  Future<void> uploadStory();

  Future<void> deleteStory();

  Future<void> getMyStoriesViewsCount();
}
