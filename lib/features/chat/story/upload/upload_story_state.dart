part of 'upload_story_bloc.dart';

@freezed
class UploadStoryState with _$UploadStoryState {
  const factory UploadStoryState.uploadStoryState({
    // When Viewing the Stories
    @Default([]) List<ViewStoryModel> uploadedStories,

    // When uploading the Story
    @Default("") String userName,
    @Default("") String userCircularAvatarUrl,
    @Default(false) bool isVerified,
    @Default(null) File? currentUploadedFile,

    // General
    @Default(false) bool isLoading,
    @Default(null) String? error,
    @Default(false) bool isUploadingStoryEvent,
  }) = _UploadStoryState;
}
