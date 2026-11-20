import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/usecase/usecase.dart';
import '../../domain/entities/app_notification.dart';
import '../../domain/usecases/get_notifications.dart';
import '../../domain/usecases/mark_all_notifications_as_read.dart';
import '../../domain/usecases/mark_notification_as_read.dart';
import 'notification_event.dart';
import 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final GetNotifications getNotifications;
  final MarkNotificationAsRead markNotificationAsRead;
  final MarkAllNotificationsAsRead markAllNotificationsAsRead;

  NotificationBloc({
    required this.getNotifications,
    required this.markNotificationAsRead,
    required this.markAllNotificationsAsRead,
  }) : super(const NotificationInitial()) {
    on<LoadNotificationsEvent>(_onLoadNotifications);
    on<FilterNotificationsEvent>(_onFilterNotifications);
    on<MarkNotificationAsReadEvent>(_onMarkNotificationAsRead);
    on<MarkAllNotificationsAsReadEvent>(_onMarkAllNotificationsAsRead);
  }

  List<AppNotification> _filterList(
      List<AppNotification> all, String filter) {
    if (filter == 'operasional') {
      return all
          .where((e) =>
              e.type == 'operasional' ||
              e.category.contains('OPERASIONAL') ||
              e.category.contains('PRESENSI'))
          .toList();
    } else if (filter == 'persetujuan') {
      return all
          .where((e) =>
              e.type == 'persetujuan' ||
              e.category.contains('CUTI') ||
              e.category.contains('APPROVAL'))
          .toList();
    }
    return all;
  }

  Future<void> _onLoadNotifications(
    LoadNotificationsEvent event,
    Emitter<NotificationState> emit,
  ) async {
    emit(const NotificationLoading());
    final result = await getNotifications(const NoParams());

    result.fold(
      (failure) => emit(NotificationError(message: failure.message)),
      (notifications) {
        final unreadCount =
            notifications.where((element) => !element.isRead).length;
        emit(
          NotificationLoaded(
            allNotifications: notifications,
            filteredNotifications: _filterList(notifications, 'semua'),
            selectedFilter: 'semua',
            unreadCount: unreadCount,
          ),
        );
      },
    );
  }

  void _onFilterNotifications(
    FilterNotificationsEvent event,
    Emitter<NotificationState> emit,
  ) {
    if (state is NotificationLoaded) {
      final loaded = state as NotificationLoaded;
      final filtered = _filterList(loaded.allNotifications, event.filter);
      emit(
        loaded.copyWith(
          selectedFilter: event.filter,
          filteredNotifications: filtered,
        ),
      );
    }
  }

  Future<void> _onMarkNotificationAsRead(
    MarkNotificationAsReadEvent event,
    Emitter<NotificationState> emit,
  ) async {
    final currentFilter = (state is NotificationLoaded)
        ? (state as NotificationLoaded).selectedFilter
        : 'semua';

    final result = await markNotificationAsRead(
      MarkNotificationAsReadParams(id: event.id),
    );

    result.fold(
      (failure) => emit(NotificationError(message: failure.message)),
      (notifications) {
        final unreadCount =
            notifications.where((element) => !element.isRead).length;
        emit(
          NotificationLoaded(
            allNotifications: notifications,
            filteredNotifications: _filterList(notifications, currentFilter),
            selectedFilter: currentFilter,
            unreadCount: unreadCount,
          ),
        );
      },
    );
  }

  Future<void> _onMarkAllNotificationsAsRead(
    MarkAllNotificationsAsReadEvent event,
    Emitter<NotificationState> emit,
  ) async {
    final currentFilter = (state is NotificationLoaded)
        ? (state as NotificationLoaded).selectedFilter
        : 'semua';

    final result = await markAllNotificationsAsRead(const NoParams());

    result.fold(
      (failure) => emit(NotificationError(message: failure.message)),
      (notifications) {
        emit(
          NotificationLoaded(
            allNotifications: notifications,
            filteredNotifications: _filterList(notifications, currentFilter),
            selectedFilter: currentFilter,
            unreadCount: 0,
          ),
        );
      },
    );
  }
}
