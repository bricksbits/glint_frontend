part of 'track_specific_event_bloc.dart';

@freezed
class TrackSpecificEventState with _$TrackSpecificEventState {
  const factory TrackSpecificEventState.initial() = _Initial;

  const factory TrackSpecificEventState.fetched(
      EventStatsDomainModel stats) = _Fetched;

  const factory TrackSpecificEventState.loading() = _Loading;

  const factory TrackSpecificEventState.passedData(
      EventBasicInfoDomainModel eventDetails) = _PassedData;
}
