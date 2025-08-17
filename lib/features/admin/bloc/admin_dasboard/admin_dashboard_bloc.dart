import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:glint_frontend/di/injection.dart';
import 'package:glint_frontend/domain/business_logic/models/admin/event_list_domain_model.dart';
import 'package:glint_frontend/domain/business_logic/repo/admin/admin_dasboard_repo.dart';
import 'package:glint_frontend/features/admin/bloc/super_admin_dashboard/super_admin_dashboard_bloc.dart';
import 'package:glint_frontend/utils/result_sealed.dart';

part 'admin_dashboard_event.dart';

part 'admin_dashboard_state.dart';

part 'admin_dashboard_bloc.freezed.dart';

class AdminDashboardBloc
    extends Bloc<AdminDashboardEvent, AdminDashboardState> {
  final AdminDashboardRepo adminRepo = getIt.get<AdminDashboardRepo>();

  AdminDashboardBloc() : super(const AdminDashboardState.initial()) {
    on<_Started>((event, emit) async {
      // TODO: Fetch the data for the Admin Dashboard and the Edit Profile as well.
      final publishedEventResult = await adminRepo.getAllPublishEvents();
      switch (publishedEventResult) {
        case Success<List<AdminEventListDomainModel>>():
          var allPublishedEvents = publishedEventResult.data;
          var recentEvents = allPublishedEvents
              .where((event) =>
                  event.eventState == AdminEventState.LIVE ||
                  event.eventState == AdminEventState.PENDING)
              .toList()
              .take(20)
              .toList();
          add(
            _EmitNewState(
              state.copyWith(
                allPublishedEvents: allPublishedEvents,
                recentEvents: recentEvents,
                isLoading: false,
              ),
            ),
          );
          break;
        case Failure<List<AdminEventListDomainModel>>():
          add(
            _EmitNewState(
              state.copyWith(
                error:
                    "${publishedEventResult.error}, Not able to fetch events,",
                isLoading: false,
              ),
            ),
          );
          break;
      }
    });

    on<_EmitNewState>(
      (event, emit) {
        var newState = event.newState;
        emit(newState);
      },
    );
  }
}
