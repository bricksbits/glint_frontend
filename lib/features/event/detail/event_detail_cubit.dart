import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:glint_frontend/di/injection.dart';
import 'package:glint_frontend/domain/business_logic/models/event/event_detail_domain.dart';
import 'package:glint_frontend/domain/business_logic/repo/event/events_repo.dart';
import 'package:glint_frontend/navigation/argument_models.dart';
import 'package:glint_frontend/utils/result_sealed.dart';

part 'event_detail_state.dart';

part 'event_detail_cubit.freezed.dart';

class EventDetailCubit extends Cubit<EventDetailState> {
  final EventRepo eventRepo = getIt.get<EventRepo>();

  EventDetailCubit() : super(const EventDetailState.initial());

  void getDetailsViaArguments(
    EventDetailsNavArguments argument,
  ) {
    if (argument.eventId != null) {
      fetchEventDetails(argument.eventId);
    } else {
      var unUploadedFiles = argument.unUploadedFiles
          ?.where((item) => item != null)
          .map((safeFile) => safeFile!)
          .toList();

      emitNewState(
        state.copyWith(
          eventDetails: argument.eventDetails,
          unUploadFiles: unUploadedFiles,
          isLoading: false,
        ),
      );
    }
  }

  //For Usertype : Users.
  Future<void> fetchEventDetails(int? eventId) async {
    emitNewState(state.copyWith(selectedEventId: eventId, isLoading: true));
    var eventDetailResult = await eventRepo.getEventDetails(eventId);
    switch (eventDetailResult) {
      case Success<EventDetailsDomainModel>():
        var detailsFetched = eventDetailResult.data;
        var updatedState = EventDetailsDomainModel(
          eventId: detailsFetched.eventId,
          eventName: detailsFetched.eventName,
          eventdate: detailsFetched.eventdate,
          eventTime: detailsFetched.eventTime,
          eventLocation: detailsFetched.eventLocation,
          eventOldPrice: detailsFetched.eventOldPrice,
          eventCurrentPrice: detailsFetched.eventCurrentPrice,
          daysLeft: detailsFetched.daysLeft,
          eventCoverImageUrl: detailsFetched.eventCoverImageUrl,
          aboutEvent: detailsFetched.aboutEvent,
          eventBy: detailsFetched.eventBy,
          peopleInterested: detailsFetched.peopleInterested,
          location: detailsFetched.location,
        );
        emitNewState(
          state.copyWith(
            eventDetails: updatedState,
            selectedEventId: eventId,
            isLoading: false,
          ),
        );
      case Failure<EventDetailsDomainModel>():
        emitNewState(
          state.copyWith(
            isLoading: false,
          ),
        );
    }
  }

  void emitNewState(EventDetailState newState) {
    emit(newState);
  }
}
