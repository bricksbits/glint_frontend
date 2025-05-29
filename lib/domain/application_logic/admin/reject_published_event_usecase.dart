import 'dart:async';

import 'package:glint_frontend/data/repo/admin/admin_dash_board_repo_impl.dart';
import 'package:glint_frontend/domain/business_logic/models/admin/event_approve_reject_domain_model.dart';
import 'package:glint_frontend/domain/business_logic/repo/admin/admin_dasboard_repo.dart';
import 'package:glint_frontend/utils/clean_arch_use_case.dart';
import 'package:glint_frontend/utils/result_sealed.dart';
import 'package:injectable/injectable.dart';

@injectable
class RejectPublishedEventUsecase
    extends UseCase<bool, EventApproveOrRejectDomainModel> {
  final AdminDashboardRepo adminDashBoardRepo;

  RejectPublishedEventUsecase(this.adminDashBoardRepo);

  @override
  Future<Stream<bool>> buildUseCaseStream(
      EventApproveOrRejectDomainModel? params) async {
    final StreamController<bool> controller = StreamController();
    try {
      adminDashBoardRepo.rejectEvent(params!).then((result) {
        switch (result) {
          case Success(data: _):
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
    } catch (e) {
      controller.addError(Exception(e.toString()));
      controller.close();
    }
    return controller.stream;
  }
}
