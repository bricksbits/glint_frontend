part of 'event_detail_cubit.dart';

@freezed
class EventDetailState with _$EventDetailState {
  const factory EventDetailState.initial({
    @Default(null) int? selectedEventId,
    @Default(null) EventDetailsDomainModel? eventDetails,
    @Default(true) bool isLoading,
    @Default(false) bool isEventPreviewForAdmin,
    @Default(null) List<File>? unUploadFiles,
    @Default(null) String? errorMessage,
  }) = _Initial;
}
