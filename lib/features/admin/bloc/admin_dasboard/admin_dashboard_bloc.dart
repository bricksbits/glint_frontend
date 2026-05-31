import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:glint_frontend/data/local/persist/async_encrypted_shared_preference_helper.dart';
import 'package:glint_frontend/data/local/persist/shared_pref_key.dart';
import 'package:glint_frontend/di/injection.dart';
import 'package:glint_frontend/domain/business_logic/models/admin/event_list_domain_model.dart';
import 'package:glint_frontend/domain/business_logic/repo/admin/admin_dasboard_repo.dart';
import 'package:glint_frontend/features/people/model/people_card_model.dart';
import 'package:glint_frontend/utils/result_sealed.dart';

part 'admin_dashboard_event.dart';

part 'admin_dashboard_state.dart';

part 'admin_dashboard_bloc.freezed.dart';

class AdminDashboardBloc
    extends Bloc<AdminDashboardEvent, AdminDashboardState> {
  final AdminDashboardRepo adminRepo = getIt.get<AdminDashboardRepo>();
  final AsyncEncryptedSharedPreferenceHelper sharedPrefHelper =
      getIt.get<AsyncEncryptedSharedPreferenceHelper>();

  AdminDashboardBloc() : super(const AdminDashboardState.initial()) {
    on<_Started>((event, emit) async {
      add(const AdminDashboardEvent.fetchAdminProfile());
      final publishedEventResult = await adminRepo.getAllPublishEvents();
      switch (publishedEventResult) {
        case Success<List<AdminEventListDomainModel>>():
          var allPublishedEvents = publishedEventResult.data;
          var recentEvents = allPublishedEvents
              .where(
                (event) =>
                    event.eventState == AdminEventState.LIVE ||
                    event.eventState == AdminEventState.PENDING,
              )
              .toList()
              .take(5)
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

    on<_FetchAdminProfile>((event, emit) async {
      await adminRepo.getAndCacheAdminProfile();

      final adminName = await sharedPrefHelper
          .getString(SharedPreferenceKeys.userNameKey);
      final adminOrg = await sharedPrefHelper
          .getString(SharedPreferenceKeys.adminUserOrganizationKey);
      final currentUser = await adminRepo.getCurrentUserDetails();

      add(
        _EmitNewState(
          state.copyWith(
            adminUserName:
                adminName.isNotEmpty ? adminName : "Event Manager",
            adminOrganization:
                adminOrg.isNotEmpty ? adminOrg : "For Organization",
            currentUser: currentUser,
          ),
        ),
      );
    });

    on<_SaveAdminProfile>((event, emit) async {
      add(_EmitNewState(
          state.copyWith(isSaving: true, isSaveSuccess: false, isSaveError: false)));

      final result =
          await adminRepo.updateAdminProfile(event.name, event.organization);

      switch (result) {
        case Success():
          final adminName = await sharedPrefHelper
              .getString(SharedPreferenceKeys.userNameKey);
          final adminOrg = await sharedPrefHelper
              .getString(SharedPreferenceKeys.adminUserOrganizationKey);
          final currentUser = await adminRepo.getCurrentUserDetails();
          add(
            _EmitNewState(
              state.copyWith(
                isSaving: false,
                isSaveSuccess: true,
                isSaveError: false,
                adminUserName:
                    adminName.isNotEmpty ? adminName : state.adminUserName,
                adminOrganization:
                    adminOrg.isNotEmpty ? adminOrg : state.adminOrganization,
                currentUser: currentUser,
              ),
            ),
          );
          break;
        case Failure():
          add(
            _EmitNewState(
              state.copyWith(
                isSaving: false,
                isSaveSuccess: false,
                isSaveError: true,
                error: result.error.toString(),
              ),
            ),
          );
          break;
      }
    });

    on<_ResetSaveStatus>((event, emit) {
      emit(state.copyWith(isSaveSuccess: false, isSaveError: false, error: ""));
    });

    on<_EmitNewState>(
      (event, emit) {
        var newState = event.newState;
        emit(newState);
      },
    );
  }
}
