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
    @Default(null) int? passedEventId,
    @Default(null) UsersType? currentUserType,
    @Default(null) DateTime? selectedStartTime,
    @Default(null) DateTime? selectedEntTime,
  }) = _Initial;

  factory AdminCreateEventState.withDefaults() {
    return AdminCreateEventState.initial(
      createEventBody: CreateEventRequestDomainModel.defaultValues(),
    );
  }
}
