part of 'admin_create_event_cubit.dart';

@freezed
class AdminCreateEventState with _$AdminCreateEventState {
  const factory AdminCreateEventState.initial({
    @Default(false) bool isLoading,
    @Default("") String error,
    @Default(null) CreateEventRequestDomainModel? createEventBody,
    @Default(null) EventDetailsDomainModel? eventDetailModel,
    @Default([]) List<File?> pictureUploaded,
    @Default(false) bool eventPublished,
    @Default(false) bool eventUpdated,
  }) = _Initial;

  factory AdminCreateEventState.withDefaults() {
    return AdminCreateEventState.initial(
      createEventBody: CreateEventRequestDomainModel.defaultValues(),
    );
  }
}
