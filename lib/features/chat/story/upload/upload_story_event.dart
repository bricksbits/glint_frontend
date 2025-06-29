part of 'upload_story_bloc.dart';

@freezed
class UploadStoryEvent with _$UploadStoryEvent {
  const factory UploadStoryEvent.uploadStory() = _UploadStory;

  const factory UploadStoryEvent.getCurrentUserStories() = _CurrentUserStories;

  const factory UploadStoryEvent.updateStateAndEmit(UploadStoryState newState) = _UpdateAndEmitNewState;

  const factory UploadStoryEvent.deleteUserStory(String fileName) = _DeleteUserStory;

  const factory UploadStoryEvent.selectStoryFromGallery() =
      _SelectStoryFromGallery;
}
