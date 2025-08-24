import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:glint_frontend/data/remote/model/request/admin/create_event_request_body.dart';
import 'package:glint_frontend/di/injection.dart';
import 'package:glint_frontend/domain/business_logic/models/admin/create_event_request.dart';
import 'package:glint_frontend/domain/business_logic/models/event/event_detail_domain.dart';
import 'package:glint_frontend/domain/business_logic/repo/admin/admin_dasboard_repo.dart';
import 'package:glint_frontend/domain/business_logic/repo/event/events_repo.dart';
import 'package:glint_frontend/features/admin/screen/admin_create_event_screen.dart';
import 'package:glint_frontend/services/image_manager_service.dart';
import 'package:glint_frontend/utils/date_and_time_extensions.dart';
import 'package:glint_frontend/utils/result_sealed.dart';

part 'admin_create_event_state.dart';

part 'admin_create_event_cubit.freezed.dart';

class AdminCreateEventCubit extends Cubit<AdminCreateEventState> {
  final adminDashboardRepo = getIt.get<AdminDashboardRepo>();
  final eventRepo = getIt.get<EventRepo>();
  final ImageService imageService = getIt.get<ImageService>();

  AdminCreateEventCubit() : super(AdminCreateEventState.withDefaults());

  Future<void> getEventDetailsAndUpdateTheCreateEventBody(int? eventId) async {
    if (eventId == null) return;
    final eventResponse = await eventRepo.getEventDetails(eventId);
    switch (eventResponse) {
      case Success<EventDetailsDomainModel>():
        final createEventBody = eventResponse.data.mapToCreateEvent();
        emitNewState(state.copyWith(
          createEventBody: createEventBody,
          isLoading: false,
        ));
        break;
      case Failure<EventDetailsDomainModel>():
        emitNewState(
          state.copyWith(
            isLoading: false,
            error: "${eventResponse.error}, Can't Publish the event",
          ),
        );
        break;
    }
  }

  void publishEvent(int? eventId) {
    eventId != null ? updateEvent(eventId) : createEvent();
  }

  Future<void> createEvent() async {
    emitNewState(
      state.copyWith(
        isLoading: true,
      ),
    );
    var createEventBody = state.createEventBody;
    if (createEventBody != null) {
      final response = await adminDashboardRepo.createEvent(createEventBody);
      switch (response) {
        case Success<void>():
          emitNewState(state.copyWith(eventPublished: true));
          break;
        case Failure<void>():
          emitNewState(
            state.copyWith(
              isLoading: false,
              error: "${response.error}, Can't Publish the event",
            ),
          );
          break;
      }
    } else {
      emitNewState(
        state.copyWith(
          isLoading: false,
          error: "No Data found",
        ),
      );
    }
  }

  Future<void> updateEvent(int eventId) async {
    var createEventBody = state.createEventBody;
    if (createEventBody != null) {
      final response = await adminDashboardRepo.createEvent(createEventBody);
      switch (response) {
        case Success<void>():
          emitNewState(state.copyWith(eventPublished: true));
          break;
        case Failure<void>():
          emitNewState(
            state.copyWith(
              isLoading: false,
              error: "${response.error}, Can't Publish the event",
            ),
          );
          break;
      }
    }
  }

  Future<void> pickUpImages() async {
    final pickedImages = await imageService.pickImages(maxCount: 6);
    emitNewState(
      state.copyWith(
        pictureUploaded: pickedImages.map((image) => image.file).toList(),
      ),
    );
  }

  Future<void> uploadMedia() async {
    var images = state.pictureUploaded.map((item) => item!).toList();
    final imageUploadResponse =
        await adminDashboardRepo.uploadEventMediaFiles("2", images);
    switch (imageUploadResponse) {
      case Success<void>():
        emit(state.copyWith(eventPublished: true, isLoading: false));
      case Failure<void>():
        emit(state.copyWith(
            isLoading: false,
            error: "${imageUploadResponse.error}, Can't upload the media"));
    }
  }

  CreateEventRequestDomainModel? getCurrentBodyState() {
    return state.createEventBody;
  }

  void observeEventTitle(String eventTitle) {
    emitNewState(
      state.copyWith(
        createEventBody: getCurrentBodyState()?.copyWith(
          eventName: eventTitle,
        ),
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

  void eventDate(DateTime passedTime) {
    var createdTime = DateTime.now().formatToStandard();
    var bookByTime = passedTime.addAndFormat(hours: 6);
    var startTime = passedTime.formatToStandard();
    var endByTime = passedTime.addAndFormat(days: 2);
    emitNewState(
      state.copyWith(
        createEventBody: getCurrentBodyState()?.copyWith(
          createdTime: createdTime,
          startDateAndTime: startTime,
          bookTime: bookByTime,
          endDateAndTime: endByTime,
        ),
      ),
    );
  }

  void enterEventLatLongValue(
    double? latitude,
    double? longitude,
    String? eventLocationName,
  ) {
    if (latitude != null && longitude != null) {
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
        createEventBody: getCurrentBodyState()?.copyWith(
          eventDescription: eventDesc,
        ),
      ),
    );
  }

  bool validateAllFieldsBeforePublishing() {
    return false;
  }

  void emitNewState(AdminCreateEventState state) {
    emit(state);
  }
}
