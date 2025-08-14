import 'dart:async';

import 'package:glint_frontend/domain/business_logic/models/admin/event_list_domain_model.dart';
import 'package:glint_frontend/domain/business_logic/repo/admin/admin_dasboard_repo.dart';
import 'package:glint_frontend/utils/clean_arch_use_case.dart';
import 'package:glint_frontend/utils/result_sealed.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class GetAllEventsUsecase extends UseCase<List<AdminEventListDomainModel>, void> {
  final AdminDashboardRepo adminDashboardRepo;

  GetAllEventsUsecase(this.adminDashboardRepo);

  @override
  Future<Stream<List<AdminEventListDomainModel>>> buildUseCaseStream(
      void params) async {
    final StreamController<List<AdminEventListDomainModel>> controller =
        StreamController();
    try {
      adminDashboardRepo.getAllEvents().then((result) {
        switch (result) {
          case Success(data: var successResult):
            controller.add(successResult);
            controller.close();
          case Failure(error: var error):
            controller.addError(error);
            controller.close();
        }
      }).catchError((caughtError) {
        controller.addError(Exception(caughtError.toString()));
        controller.close();
      });
    } catch (e) {
      controller.addError(Exception(e.toString()));
      controller.close();
    }
    return controller.stream;
  }
}
