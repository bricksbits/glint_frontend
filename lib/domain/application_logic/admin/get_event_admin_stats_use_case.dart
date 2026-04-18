import 'dart:async';

import 'package:glint_frontend/domain/business_logic/models/admin/event_stats_domain_model.dart';
import 'package:glint_frontend/domain/business_logic/repo/admin/admin_dasboard_repo.dart';
import 'package:glint_frontend/utils/clean_arch_use_case.dart';
import 'package:glint_frontend/utils/result_sealed.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class GetEventAdminStatsUseCase extends UseCase<EventStatsDomainModel, int> {
  final AdminDashboardRepo adminDashboardRepo;

  GetEventAdminStatsUseCase(this.adminDashboardRepo);

  @override
  Future<Stream<EventStatsDomainModel?>> buildUseCaseStream(int? params) async {
    final controller = StreamController<EventStatsDomainModel?>();
    try {
      adminDashboardRepo.getEventAdminStats(params!).then((result) {
        switch (result) {
          case Success(data: var stats):
            controller.add(stats);
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
