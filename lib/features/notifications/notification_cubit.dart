import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:glint_frontend/di/injection.dart';
import 'package:glint_frontend/domain/business_logic/repo/notification/notification_repo.dart';
import 'package:glint_frontend/features/notifications/notification_item.dart';
import 'package:glint_frontend/utils/result_sealed.dart';

part 'notification_state.dart';
part 'notification_cubit.freezed.dart';

class NotificationCubit extends Cubit<NotificationState> {
  final _repo = getIt.get<NotificationRepo>();

  NotificationCubit() : super(const NotificationState.initial()) {
    fetchNotifications();
  }

  Future<void> fetchNotifications() async {
    emit(state.copyWith(isLoading: true, error: ''));
    final result = await _repo.getNotificationHistory(0);
    switch (result) {
      case Success():
        final items = result.data.notifications
            .map(NotificationItem.fromHistoryItem)
            .toList()
          ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
        emit(state.copyWith(
          isLoading: false,
          notificationGroups: _groupNotifications(items),
        ));
        break;
      case Failure():
        emit(state.copyWith(
          isLoading: false,
          error: result.message ?? 'Failed to load notifications',
        ));
        break;
    }
  }

  List<NotificationGroup> _groupNotifications(List<NotificationItem> items) {
    final now = DateTime.now();
    final todayStart = DateTime(now.year, now.month, now.day);
    final yesterdayStart = todayStart.subtract(const Duration(days: 1));

    final today = <NotificationItem>[];
    final yesterday = <NotificationItem>[];
    final earlier = <NotificationItem>[];

    for (final item in items) {
      final d = DateTime(
          item.createdAt.year, item.createdAt.month, item.createdAt.day);
      if (!d.isBefore(todayStart)) {
        today.add(item);
      } else if (!d.isBefore(yesterdayStart)) {
        yesterday.add(item);
      } else {
        earlier.add(item);
      }
    }

    return [
      if (today.isNotEmpty) NotificationGroup(label: 'Today', items: today),
      if (yesterday.isNotEmpty)
        NotificationGroup(label: 'Yesterday', items: yesterday),
      if (earlier.isNotEmpty)
        NotificationGroup(label: 'Earlier', items: earlier),
    ];
  }

  void emitNewState(NotificationState newState) => emit(newState);
}
