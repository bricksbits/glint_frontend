part of 'upload_story_bloc.dart';

@freezed
class UploadStoryEvent with _$UploadStoryEvent {
  const factory UploadStoryEvent.started() = _Started;
}
