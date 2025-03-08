part of 'event_interaction_bloc.dart';

// event
abstract class EventInteractionEvent {}

class MarkUserInterestedEvent extends EventInteractionEvent {
  final int eventId;

  MarkUserInterestedEvent(this.eventId);
}
