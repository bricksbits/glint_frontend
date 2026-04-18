import 'dart:async';

import 'package:glint_frontend/domain/business_logic/repo/admin/admin_dasboard_repo.dart';
import 'package:glint_frontend/utils/clean_arch_use_case.dart';
import 'package:glint_frontend/utils/result_sealed.dart';
import 'package:injectable/injectable.dart';

class TogglePauseEventParams {
  final String eventId;
  final bool shouldPause;

  const TogglePauseEventParams({
    required this.eventId,
    required this.shouldPause,
  });
}

@LazySingleton()
class TogglePauseEventUseCase extends UseCase<bool, TogglePauseEventParams> {
  final AdminDashboardRepo adminDashboardRepo;

  TogglePauseEventUseCase(this.adminDashboardRepo);

  @override
  Future<Stream<bool?>> buildUseCaseStream(
    TogglePauseEventParams? params,
  ) async {
    final controller = StreamController<bool>();
    try {
      final future = params!.shouldPause
          ? adminDashboardRepo.pauseEvent(params.eventId)
          : adminDashboardRepo.unpauseEvent(params.eventId);

      future.then((result) {
        switch (result) {
          case Success():
            controller.add(true);
            controller.close();
          case Failure(error: var error):
            controller.addError(error);
            controller.close();
        }
      }).catchError((caughtError) {
        controller.addError(Failure(Exception(caughtError.toString())));
        controller.close();
      });
    } catch (e) {
      controller.addError(Failure(Exception(e.toString())));
      controller.close();
    }
    return controller.stream;
  }
}
