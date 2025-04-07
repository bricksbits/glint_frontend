import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:glint_frontend/domain/business_logic/models/admin/event_basic_info_domain_model.dart';
import 'package:glint_frontend/domain/business_logic/models/admin/event_stats_domain_model.dart';

part 'track_specific_event_event.dart';
part 'track_specific_event_state.dart';

part 'track_specific_event_bloc.freezed.dart';

class TrackSpecificEventBloc extends Bloc<TrackSpecificEventEvent, TrackSpecificEventState> {
  TrackSpecificEventBloc() : super(const TrackSpecificEventState.initial()) {
    on<TrackSpecificEventEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
