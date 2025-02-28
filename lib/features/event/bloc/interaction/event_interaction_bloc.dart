import 'package:bloc/bloc.dart';
import 'package:glint_frontend/domain/application_logic/event/user_like_event_user_case.dart';

part 'event_interaction_events.dart';
part 'event_interaction_state.dart';

//bloc
class EventInteractionBloc
    extends Bloc<EventInteractionEvent, EventInteractionState> {
  final UserLikedEventUseCase userLikedEventUseCase;

  EventInteractionBloc({required this.userLikedEventUseCase})
      : super(EventInteractionInitial()) {
    on<MarkUserInterestedEvent>(_onMarkUserInterested);
  }

  Future<void> _onMarkUserInterested(
    MarkUserInterestedEvent event,
    Emitter<EventInteractionState> emit,
  ) async {
    emit(EventInteractionLoading());

    try {
      final stream =
          await userLikedEventUseCase.buildUseCaseStream(event.eventId);
      await for (final _ in stream) {
        emit(EventInteractionSuccess());
      }
    } catch (e) {
      emit(EventInteractionFailure(e.toString()));
    }
  }
}
