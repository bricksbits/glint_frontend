import 'dart:async';

import 'package:glint_frontend/domain/business_logic/models/admin/create_event_request.dart';
import 'package:glint_frontend/domain/business_logic/repo/admin/admin_dasboard_repo.dart';
import 'package:glint_frontend/utils/clean_arch_use_case.dart';
import 'package:glint_frontend/utils/result_sealed.dart';

class PublishEventUseCase extends UseCase<bool, CreateEventRequestDomainModel> {
  final AdminDashboardRepo adminDashboardRepo;

  PublishEventUseCase(this.adminDashboardRepo);

  @override
  Future<Stream<bool?>> buildUseCaseStream(
      CreateEventRequestDomainModel? params) async {
    final StreamController<bool> controller = StreamController();
    try {
      if (params != null) {
        adminDashboardRepo.editEvent(params).then((result) {
          switch (result) {
            case Success(data: var successResult):
              controller.add(true);
              controller.close();
            case Failure(error: var error):
              controller.addError(error);
              controller.close();
          }
        }).catchError((caughtError) {
          controller.addError(Exception(caughtError.toString()));
          controller.close();
        });
      }
    } catch (e) {
      controller.addError(Exception(e.toString()));
      controller.close();
    }
    return controller.stream;
  }
}
