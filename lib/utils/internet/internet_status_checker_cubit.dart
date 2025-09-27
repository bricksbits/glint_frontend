import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:meta/meta.dart';

part 'internet_status_checker_state.dart';

class InternetStatusCheckerCubit extends Cubit<InternetStatusCheckerState> {
  final Connectivity _connectivity;
  late final Stream<List<ConnectivityResult>> _connectivityStream;

  InternetStatusCheckerCubit(this._connectivity) : super(InternetStatusConnected()) {
    _connectivityStream = _connectivity.onConnectivityChanged;
    _connectivityStream.listen(_mapResultToStatus);
  }

  void _mapResultToStatus(List<ConnectivityResult> result) {
    final isResult = result.first;
    if (isResult == ConnectivityResult.mobile || isResult == ConnectivityResult.wifi) {
      emit(InternetStatusConnected());
    } else {
      emit(InternetStatusDisConnected());
    }
  }
}
