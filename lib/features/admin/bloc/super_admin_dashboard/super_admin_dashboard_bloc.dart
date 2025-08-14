import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:glint_frontend/di/injection.dart';
import 'package:glint_frontend/domain/application_logic/admin/approve_published_event_usecase.dart';
import 'package:glint_frontend/domain/application_logic/admin/get_all_events_use_case.dart';
import 'package:glint_frontend/domain/application_logic/admin/reject_published_event_usecase.dart';
import 'package:glint_frontend/domain/business_logic/models/admin/event_approve_reject_domain_model.dart'
    show EventApproveOrRejectDomainModel;
import 'package:glint_frontend/domain/business_logic/models/admin/event_list_domain_model.dart';

part 'super_admin_dashboard_event.dart';

part 'super_admin_dashboard_state.dart';

part 'super_admin_dashboard_bloc.freezed.dart';

class SuperAdminDashboardBloc
    extends Bloc<SuperAdminDashboardEvent, SuperAdminDashboardState> {
  final GetAllEventsUsecase allEventsUseCase = getIt.get();
  final ApprovePublishedEventUsecase approveEventUseCase = getIt.get();
  final RejectPublishedEventUsecase rejectEventUseCase = getIt.get();

  SuperAdminDashboardBloc() : super(const SuperAdminDashboardState()) {
    _fetchPublishEvents();

    on<_ApproveEvent>(
      (event, emit) async {
        add(_UpdateStates((state.copyWith(isLoading: true))));
        final selectedEventId = event.eventId;
        approveEventUseCase.perform((isApproved) {
          if (isApproved != null && isApproved) {
            final itemSelected = state.requestEvents
                .where((eventModel) => eventModel.eventId == selectedEventId)
                .toList(growable: false);
            if (itemSelected.isNotEmpty) {
              state.requestEvents.remove(itemSelected.first);
              state.liveEvents.add(itemSelected.first);
            }
          } else {
            add(
              _UpdateStates(
                state.copyWith(
                    errorMessage:
                        "Can't Approve the request, please try again"),
              ),
            );
          }
        }, (approvedError) {
          add(_UpdateStates(
            (state.copyWith(
                errorMessage:
                    "Can't Approve the request, check your internet connections")),
          ));
        }, () {
          // On Done
          add(_UpdateStates(state.copyWith(isLoading: false)));
        }, EventApproveOrRejectDomainModel(selectedEventId, true));
      },
    );

    on<_RejectEvent>((event, emit) async {
      final selectedEventId = event.eventId;
      rejectEventUseCase.perform(
        (isRejected) {
          if (isRejected != null && isRejected) {
            final itemSelected = state.requestEvents
                .where((eventModel) => eventModel.eventId == selectedEventId)
                .toList(growable: false);

            if (itemSelected.isNotEmpty) {
              state.requestEvents.remove(itemSelected.first);
            }
          } else {
            emit(
              state.copyWith(
                  errorMessage: "Can't Reject the request, please try again"),
            );
          }
        },
        (approvedError) {
          emit(
            state.copyWith(
                errorMessage:
                    "Can't Reject the request, check your internet connections"),
          );
        },
        () {
          emit.isDone;
        },
        EventApproveOrRejectDomainModel(selectedEventId, false),
      );
    });

    on<_SelectLive>((event, emit) async {
      add(const SuperAdminDashboardEvent.updateList());
      emit(state.copyWith(currentTab: EventDisplayType.live));
    });

    on<selectRequests>((event, emit) async {
      add(const SuperAdminDashboardEvent.updateList());
      emit(state.copyWith(currentTab: EventDisplayType.requested));
    });

    on<_UpdateList>(
      (event, emit) {
        final currentTab = state.currentTab;
        switch (currentTab) {
          case EventDisplayType.live:
            emit(
              state.copyWith(currentSelectedList: state.liveEvents),
            );
          case EventDisplayType.requested:
            emit(
              state.copyWith(currentSelectedList: state.requestEvents),
            );
        }
      },
    );

    on<_UpdateStates>(
      (event, emit) {
        final newState = event.state;
        emit(newState);
      },
    );
  }

  Future<void> _fetchPublishEvents() async {
    allEventsUseCase.perform((allEvents) async {
      if (allEvents != null && allEvents.isNotEmpty) {
        var liveEvents = allEvents
            .where((element) => element.eventState == AdminEventState.LIVE)
            .toList();
        var requestEvents = allEvents
            .where((e) => e.eventState == AdminEventState.PENDING)
            .toList();

        add(
          _UpdateStates(
            state.copyWith(
              liveEvents: liveEvents,
              requestEvents: requestEvents,
              currentSelectedList: liveEvents
            ),
          ),
        );
      }
    }, (error) {
      add(
        _UpdateStates(
          state.copyWith(errorMessage: "Can't Fetch Event List, $error"),
        ),
      );
    }, () {
      add(const SuperAdminDashboardEvent.updateList());
    });
  }
}

enum EventDisplayType { live, requested }
