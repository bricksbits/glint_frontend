import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'interested_people_event.dart';
part 'interested_people_state.dart';
part 'interested_people_bloc.freezed.dart';

class InterestedPeopleBloc extends Bloc<InterestedPeopleEvent, InterestedPeopleState> {
  InterestedPeopleBloc() : super(const InterestedPeopleState.initial()) {
    on<InterestedPeopleEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
