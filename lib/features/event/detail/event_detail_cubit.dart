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
          errorMessage: null,
        ),
      );
    }
  }

  Future<void> fetchEventDetails(int? eventId) async {
    emitNewState(state.copyWith(
      selectedEventId: eventId,
      isLoading: true,
      errorMessage: null,
    ));
    final result = await eventRepo.getEventDetails(eventId);
    switch (result) {
      case Success<EventDetailsDomainModel>():
        emitNewState(
          state.copyWith(
            eventDetails: result.data,
            selectedEventId: eventId,
            isLoading: false,
            errorMessage: null,
          ),
        );
      case Failure<EventDetailsDomainModel>():
        emitNewState(
          state.copyWith(
            isLoading: false,
            errorMessage: result.error.toString(),
          ),
        );
    }
  }

  void retry() {
    if (state.selectedEventId != null) {
      fetchEventDetails(state.selectedEventId);
    }
  }

  void emitNewState(EventDetailState newState) {
    emit(newState);
  }
}
