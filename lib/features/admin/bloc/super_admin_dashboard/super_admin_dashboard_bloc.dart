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
  final ApprovePublishedEventUsecase approveEventUseCase =
      getIt.get();
  final RejectPublishedEventUsecase rejectEventUseCase =
      getIt.get();

  List<EventListDomainModel> liveEvents = [];
  List<EventListDomainModel> requestEvents = [];

  SuperAdminDashboardBloc() : super(const SuperAdminDashboardState()) {
    on<_Fetch>((event, emit) async {
      final allEvents = allEventsUseCase;
      allEvents.perform((allEvents) async {
        if (allEvents != null && allEvents.isNotEmpty) {
          liveEvents = allEvents
              .where((element) => element.eventState == AdminEventState.LIVE)
              .toList();
          requestEvents = allEvents
              .where((e) => e.eventState == AdminEventState.PENDING)
              .toList();
        }
      }, (error) {
        emit(state.copyWith(errorMessage: "Can't Fetch Event List, $error"));
      }, () {
        add(const SuperAdminDashboardEvent.updateList());
        emit.isDone;
      });
    });

    on<_ApproveEvent>(
      (event, emit) async {
        emit(state.copyWith(isLoading: true));
        final selectedEventId = event.eventId;
        final usecase = approveEventUseCase;
        usecase.perform((isApproved) {
          if (isApproved != null && isApproved) {
            final itemSelected = requestEvents
                .where((eventModel) => eventModel.eventId == selectedEventId);
            if (itemSelected.isNotEmpty) {
              requestEvents.remove(itemSelected.first);
              liveEvents.add(itemSelected.first);
            }
            add(const SuperAdminDashboardEvent.fetch());
          } else {
            emit(
              state.copyWith(
                  errorMessage: "Can't Approve the request, please try again"),
            );
          }
        }, (approvedError) {
          emit(state.copyWith(
              errorMessage:
                  "Can't Approve the request, check your internet connections"));
        }, () {
          emit.isDone;
        }, EventApproveOrRejectDomainModel(selectedEventId, true));
      },
    );

    on<_RejectEvent>((event, emit) async {
      final selectedEventId = event.eventId;
      final usecase = rejectEventUseCase;
      usecase.perform(
        (isRejected) {
          if (isRejected != null && isRejected) {
            final itemSelected = requestEvents
                .where((eventModel) => eventModel.eventId == selectedEventId);
            if (itemSelected.isNotEmpty) {
              requestEvents.remove(itemSelected.first);
            }
            add(const SuperAdminDashboardEvent.fetch());
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
            emit(state.copyWith(currentSelectedList: liveEvents));
          case EventDisplayType.requested:
            emit(state.copyWith(currentSelectedList: requestEvents));
        }
      },
    );
  }
}

enum EventDisplayType { live, requested }
