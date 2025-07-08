import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:glint_frontend/di/injection.dart';
import 'package:glint_frontend/domain/business_logic/models/event/event_detail_domain.dart';
import 'package:glint_frontend/domain/business_logic/models/event/event_list_domain_model.dart';
import 'package:glint_frontend/domain/business_logic/repo/event/events_repo.dart';
import 'package:glint_frontend/utils/result_sealed.dart';

part 'event_detail_state.dart';

part 'event_detail_cubit.freezed.dart';

class EventDetailCubit extends Cubit<EventDetailState> {
  final EventRepo eventRepo = getIt.get<EventRepo>();

  EventDetailCubit() : super(const EventDetailState.initial());

  void updateSelectedEventId(String eventId) {
    emitNewState(
      state.copyWith(
        selectedEventId: int.parse(eventId),
      ),
    );
  }

  void getDetailsViaArguments(EventListDomainModel passedModel) {
    var updatedModel = state.eventDetails?.copyWith(
      eventId: passedModel.eventId,
      eventName: passedModel.eventName,
      eventdate: passedModel.eventdate,
      eventTime: passedModel.eventTime,
      eventLocation: passedModel.eventLocation,
      eventOldPrice: passedModel.eventOldPrice,
      eventCurrentPrice: passedModel.eventCurrentPrice,
      daysLeft: passedModel.daysLeft,
      peopleInterested: 0,
    );
    emitNewState(state.copyWith(eventDetails: updatedModel));
  }

  Future<void> fetchExtraEventDetails() async {
    var eventDetailResult =
        await eventRepo.getEventDetails(state.selectedEventId);

    switch (eventDetailResult) {
      case Success<EventDetailsDomainModel>():
        var detailsFetched = eventDetailResult.data;
        var currentDetails = state.eventDetails;
        var updatedState = currentDetails?.copyWith(
          eventCoverImageUrl: detailsFetched.eventCoverImageUrl,
          aboutEvent: detailsFetched.aboutEvent,
          eventBy: detailsFetched.eventBy,
          peopleInterested: detailsFetched.peopleInterested,
          location: detailsFetched.location,
        );
        emitNewState(state.copyWith(
          eventDetails: updatedState,
        ));
      case Failure<EventDetailsDomainModel>():
        emitNewState(state.copyWith(
          isLoading: false,
        ));
    }
  }

  void emitNewState(EventDetailState newState) {
    emit(newState);
  }
}
