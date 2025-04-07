import 'dart:async';

import 'package:glint_frontend/domain/business_logic/models/admin/event_interested_user_domain_model.dart';
import 'package:glint_frontend/domain/business_logic/repo/admin/admin_dasboard_repo.dart';
import 'package:glint_frontend/utils/clean_arch_use_case.dart';
import 'package:glint_frontend/utils/result_sealed.dart';

class GetAllInterestedUsersUseCase
    extends UseCase<EventInterestedUserDomainModel, int> {
  final AdminDashboardRepo adminDashboardRepo;

  GetAllInterestedUsersUseCase(this.adminDashboardRepo);

  @override
  Future<Stream<EventInterestedUserDomainModel?>> buildUseCaseStream(
      int? params) async {
    final StreamController<EventInterestedUserDomainModel> controller =
        StreamController();
    try {
      adminDashboardRepo.fetchInterestedProfiles(params ?? 0).then((result) {
        switch (result) {
          case Success(data: var successResult):
            controller.add(successResult);
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
