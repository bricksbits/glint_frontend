part of 'upload_story_bloc.dart';

@freezed
class UploadStoryState with _$UploadStoryState {
  const factory UploadStoryState.uploadStoryState({
    @Default([]) List<String> storiesFilePath,
    @Default("") String currentStoryPath,
    @Default(0) int profileViewCount,
    @Default("") String userName,
    @Default("") String imageUrl,
    @Default(false) bool isVerified,
    @Default("") String? currentUploadedFilePath,
  }) = _UploadStoryState;
}
