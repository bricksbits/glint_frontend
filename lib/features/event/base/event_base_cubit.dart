import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:glint_frontend/di/injection.dart';
import 'package:glint_frontend/domain/business_logic/models/event/event_list_domain_model.dart';
import 'package:glint_frontend/domain/business_logic/repo/event/events_repo.dart';
import 'package:glint_frontend/features/people/model/people_card_model.dart';
import 'package:glint_frontend/utils/result_sealed.dart';

part 'event_base_state.dart';

part 'event_base_cubit.freezed.dart';

class EventBaseCubit extends Cubit<EventBaseState> {
  final EventRepo eventRepo = getIt.get<EventRepo>();

  EventBaseCubit() : super(const EventBaseState.initial()) {
    _fetchRecentEvents();
  }

  Future<void> _fetchRecentEvents() async {
    final allEvents = await eventRepo.getAllEvents();
    switch (allEvents) {
      case Success<List<EventListDomainModel>>():
        emitNewState(state.copyWith(allEvents: allEvents.data));
        _splitAllEventsToRespectiveLists();
      case Failure<List<EventListDomainModel>>():
        emitNewState(
          state.copyWith(
            allEvents: [],
          ),
        );
    }
  }

  void _splitAllEventsToRespectiveLists() {
    var events = state.allEvents;
    var hotEventsFiltered = events.where((event) => event.isHotEvent).toList();
    var normalEventsFiltered =
        events.where((event) => !event.isHotEvent).toList();
    emitNewState(
      state.copyWith(
          hotEvents: hotEventsFiltered, normalEvents: normalEventsFiltered),
    );
  }

  void emitNewState(EventBaseState newState) {
    emit(newState);
  }

  Future<void> fetchSelectedEventProfiles(String eventId) async {
    emitNewState(
      state.copyWith(
        selectedEventId: int.parse(eventId),
      ),
    );
    var profileResult =
        await eventRepo.fetchInterestedProfiles(int.parse(eventId));
    switch (profileResult) {
      case Success<List<PeopleCardModel>>():
        emitNewState(
          state.copyWith(
            selectedEventPeople: profileResult.data,
          ),
        );
      case Failure<List<PeopleCardModel>>():
        emitNewState(
          state.copyWith(
            selectedEventPeople: [],
          ),
        );
    }
  }

  Future<void> markInterestedUserIfNotAlready(String eventId) async {
    await eventRepo.userInterested(int.parse(eventId));
  }
}
