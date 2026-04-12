import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:glint_frontend/di/injection.dart';
import 'package:glint_frontend/domain/business_logic/models/admin/create_event_request.dart';
import 'package:glint_frontend/domain/business_logic/models/common/UsersType.dart';
import 'package:glint_frontend/domain/business_logic/models/event/event_detail_domain.dart';
import 'package:glint_frontend/domain/business_logic/repo/admin/admin_dasboard_repo.dart';
import 'package:glint_frontend/domain/business_logic/repo/event/events_repo.dart';
import 'package:glint_frontend/features/admin/screen/admin_create_event_screen.dart';
import 'package:glint_frontend/services/image_manager_service.dart';
import 'package:glint_frontend/utils/date_and_time_extensions.dart';
import 'package:glint_frontend/utils/result_sealed.dart';

part 'admin_create_event_state.dart';

part 'admin_create_event_cubit.freezed.dart';

const _kPendingEventDir = "pending_event";

class AdminCreateEventCubit extends Cubit<AdminCreateEventState> {
  final adminDashboardRepo = getIt.get<AdminDashboardRepo>();
  final eventRepo = getIt.get<EventRepo>();
  final ImageService imageService = getIt.get<ImageService>();

  AdminCreateEventCubit() : super(AdminCreateEventState.withDefaults()) {
    getCurrentUser();
  }

  Future<void> getCurrentUser() async {
    final userType = await adminDashboardRepo.getCurrentUserType();
    emitNewState(state.copyWith(currentUserType: userType));
  }

  Future<void> getEventDetailsAndUpdateTheCreateEventBody(int? eventId) async {
    if (eventId == null) return;
    emitNewState(
      state.copyWith(
        passedEventId: eventId,
        isLoading: true,
      ),
    );
    final eventResponse = await eventRepo.getEventDetails(eventId);
    switch (eventResponse) {
      case Success<EventDetailsDomainModel>():
        final createEventBody = eventResponse.data.mapToCreateEvent();
        emitNewState(state.copyWith(
          createEventBody: createEventBody,
          eventDetailModel: eventResponse.data,
          isLoading: false,
        ));
        break;
      case Failure<EventDetailsDomainModel>():
        emitNewState(
          state.copyWith(
            isLoading: false,
            error: "${eventResponse.error}, Can't load the event",
          ),
        );
        break;
    }
  }

  // ── Validation ────────────────────────────────────────────────────────────

  /// Returns a list of human-readable errors. Empty list means the form is valid.
  List<String> getValidationErrors() {
    final errors = <String>[];
    final body = state.createEventBody;

    if (body == null) {
      errors.add("Form data is missing.");
      return errors;
    }

    if (body.eventName.trim().isEmpty) errors.add("• Event name is required.");
    if (state.selectedStartTime == null) {
      errors.add("• Start date & time must be selected.");
    }
    if (state.selectedEntTime == null) {
      errors.add("• End date & time must be selected.");
    }
    if (body.eventLocationName.trim().isEmpty) {
      errors.add("• Event location is required.");
    }
    if (body.eventDescription.trim().isEmpty) {
      errors.add("• Event description is required.");
    }

    // Images required only for new events (not edits)
    if (state.passedEventId == null &&
        !state.pictureUploaded.any((f) => f != null)) {
      errors.add("• At least one event image must be uploaded.");
    }

    return errors;
  }

  bool get isFormValid => getValidationErrors().isEmpty;

  // ── Publish (single-click) ───────────────────────────────────────────────

  Future<void> publishEvent(int? eventId) async {
    if (eventId != null) {
      await _updateEvent(eventId);
    } else {
      await _uploadTempImagesAndCreate();
    }
  }

  Future<void> _uploadTempImagesAndCreate() async {
    final errors = getValidationErrors();
    if (errors.isNotEmpty) {
      emitNewState(state.copyWith(
        error: "Please complete the form:\n${errors.join('\n')}",
      ));
      return;
    }

    emitNewState(state.copyWith(isLoading: true, error: ""));

    final images = state.pictureUploaded.whereType<File>().toList();
    CreateEventRequestDomainModel? bodyToSend = state.createEventBody;

    if (bodyToSend == null) {
      emitNewState(state.copyWith(isLoading: false, error: "No event data found"));
      return;
    }

    // Step 1: upload temp images if any were selected
    if (images.isNotEmpty) {
      final uploadResult = await adminDashboardRepo.uploadTempEventImages(images);
      switch (uploadResult) {
        case Success<String>():
          bodyToSend = bodyToSend.copyWith(tempImageIds: [uploadResult.data]);
          emitNewState(state.copyWith(createEventBody: bodyToSend));
          break;
        case Failure<String>():
          emitNewState(state.copyWith(
            isLoading: false,
            error: "${uploadResult.error}, Can't upload images",
          ));
          return;
      }
    }

    // Step 2: create the event
    final createResult = await adminDashboardRepo.createEvent(bodyToSend);
    switch (createResult) {
      case Success<void>():
        // Clean up locally stored images after successful publish
        await imageService.clearEventImagesDirectory(_kPendingEventDir);
        emitNewState(state.copyWith(eventPublished: true, isLoading: false));
        break;
      case Failure<void>():
        emitNewState(state.copyWith(
          isLoading: false,
          error: "${createResult.error}, Can't publish the event",
        ));
    }
  }

  Future<void> _updateEvent(int eventId) async {
    emitNewState(state.copyWith(isLoading: true, error: ""));
    final createEventBody = state.createEventBody;
    if (createEventBody == null) {
      emitNewState(state.copyWith(isLoading: false, error: "No event data found"));
      return;
    }

    final response = await adminDashboardRepo.editEvent(createEventBody);
    switch (response) {
      case Success<void>():
        emitNewState(state.copyWith(eventUpdated: true, isLoading: false));
        break;
      case Failure<void>():
        emitNewState(state.copyWith(
          isLoading: false,
          error: "${response.error}, Can't update the event",
        ));
    }
  }


  Future<void> pickUpImages() async {
    final eventDirId = state.passedEventId?.toString() ?? _kPendingEventDir;
    final pickedImages = await imageService.pickImagesForEvent(
      eventId: eventDirId,
      maxCount: 6,
    );
    if (pickedImages.isEmpty) return;

    final existing = List<File?>.from(state.pictureUploaded);
    final newFiles = pickedImages.map((img) => img.file).toList();
    emitNewState(
      state.copyWith(pictureUploaded: [...existing, ...newFiles]),
    );
  }

  // ── Form field handlers ──────────────────────────────────────────────────

  void observeEventTitle(String eventTitle) {
    emitNewState(
      state.copyWith(
        createEventBody: getCurrentBodyState()?.copyWith(eventName: eventTitle),
      ),
    );
  }

  void enterEventTyped(EventType eventType) {
    emitNewState(
      state.copyWith(
        createEventBody: getCurrentBodyState()
            ?.copyWith(isHotEvent: eventType == EventType.hot),
      ),
    );
  }

  void enterNumberOfPerson(int totalTickets) {
    emitNewState(
      state.copyWith(
        createEventBody: getCurrentBodyState()?.copyWith(
          totalTicket: totalTickets,
          ticketsRemaining: totalTickets,
        ),
      ),
    );
  }

  void enterEventActualPrice(int actualPrice) {
    emitNewState(
      state.copyWith(
        createEventBody:
            getCurrentBodyState()?.copyWith(originalPrice: actualPrice),
      ),
    );
  }

  void enterEventDiscountedPrice(int discountedPrice) {
    emitNewState(
      state.copyWith(
        createEventBody:
            getCurrentBodyState()?.copyWith(discountedPrice: discountedPrice),
      ),
    );
  }

  void setDiscountActivated(bool activated) {
    emitNewState(
      state.copyWith(
        createEventBody:
            getCurrentBodyState()?.copyWith(discountActivated: activated),
      ),
    );
  }

  void enterGoogleMapUrl(String url) {
    emitNewState(
      state.copyWith(
        createEventBody: getCurrentBodyState()?.copyWith(googleMapUrl: url),
      ),
    );
  }

  void enterEventLat(String latText) {
    final lat = double.tryParse(latText) ?? 0.0;
    emitNewState(
      state.copyWith(
        createEventBody:
            getCurrentBodyState()?.copyWith(eventLocationLat: lat),
      ),
    );
  }

  void enterEventLong(String longText) {
    final lng = double.tryParse(longText) ?? 0.0;
    emitNewState(
      state.copyWith(
        createEventBody:
            getCurrentBodyState()?.copyWith(eventLocationLong: lng),
      ),
    );
  }

  void enterEventBy(String eventBy) {
    emitNewState(
      state.copyWith(
        createEventBody: getCurrentBodyState()?.copyWith(eventBy: eventBy),
      ),
    );
  }

  void toggleCategory(String category) {
    final current =
        List<String>.from(state.createEventBody?.categoryList ?? []);
    if (current.contains(category)) {
      current.remove(category);
    } else {
      current.add(category);
    }
    emitNewState(
      state.copyWith(
        createEventBody:
            getCurrentBodyState()?.copyWith(categoryList: current),
      ),
    );
  }

  // ── Date / time ──────────────────────────────────────────────────────────

  void collectEventStartDate(DateTime passedDate) {
    // Preserve any previously-selected time component
    final existing = state.selectedStartTime;
    final combined = existing != null
        ? DateTime(passedDate.year, passedDate.month, passedDate.day,
            existing.hour, existing.minute)
        : DateTime(passedDate.year, passedDate.month, passedDate.day);

    emitNewState(
      state.copyWith(
        selectedStartTime: combined,
        createEventBody: getCurrentBodyState()?.copyWith(
          startDateAndTime: combined.formatToStandard(),
          bookTime: combined.formatToStandard(),
        ),
      ),
    );
  }

  void collectEventStartTime(DateTime passedTime) {
    final base = state.selectedStartTime ?? DateTime.now();
    final combined = DateTime(
        base.year, base.month, base.day, passedTime.hour, passedTime.minute);

    emitNewState(
      state.copyWith(
        selectedStartTime: combined,
        createEventBody: getCurrentBodyState()?.copyWith(
          createdTime: DateTime.now().formatToStandard(),
          startDateAndTime: combined.formatToStandard(),
          bookTime: combined.formatToStandard(),
        ),
      ),
    );
  }

  void collectEventEndDate(DateTime passedDate) {
    final existing = state.selectedEntTime;
    final combined = existing != null
        ? DateTime(passedDate.year, passedDate.month, passedDate.day,
            existing.hour, existing.minute)
        : DateTime(passedDate.year, passedDate.month, passedDate.day);

    emitNewState(
      state.copyWith(
        selectedEntTime: combined,
        createEventBody: getCurrentBodyState()?.copyWith(
          endDateAndTime: combined.formatToStandard(),
        ),
      ),
    );
  }

  void collectEventEndTime(DateTime passedTime) {
    final base = state.selectedEntTime ?? DateTime.now();
    final combined = DateTime(
        base.year, base.month, base.day, passedTime.hour, passedTime.minute);

    emitNewState(
      state.copyWith(
        selectedEntTime: combined,
        createEventBody: getCurrentBodyState()?.copyWith(
          endDateAndTime: combined.formatToStandard(),
        ),
      ),
    );
  }

  void enterEventLocationName(String? eventLocationName) {
    if (eventLocationName != null) {
      emitNewState(
        state.copyWith(
          createEventBody: getCurrentBodyState()?.copyWith(
            eventLocationName: eventLocationName,
          ),
        ),
      );
    }
  }

  void enterEventDescription(String eventDesc) {
    emitNewState(
      state.copyWith(
        createEventBody:
            getCurrentBodyState()?.copyWith(eventDescription: eventDesc),
      ),
    );
  }

  CreateEventRequestDomainModel? getCurrentBodyState() {
    return state.createEventBody;
  }

  void emitNewState(AdminCreateEventState state) {
    emit(state);
  }
}
