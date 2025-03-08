part of 'event_interaction_bloc.dart';

// state
abstract class EventInteractionState {}

class EventInteractionInitial extends EventInteractionState {}

class EventInteractionLoading extends EventInteractionState {}

class EventInteractionSuccess extends EventInteractionState {}

class EventInteractionFailure extends EventInteractionState {
  final String error;

  EventInteractionFailure(this.error);
}
