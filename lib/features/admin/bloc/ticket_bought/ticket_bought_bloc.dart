import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'ticket_bought_event.dart';
part 'ticket_bought_state.dart';
part 'ticket_bought_bloc.freezed.dart';

class TicketBoughtBloc extends Bloc<TicketBoughtEvent, TicketBoughtState> {
  TicketBoughtBloc() : super(const TicketBoughtState.initial()) {
    on<TicketBoughtEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
