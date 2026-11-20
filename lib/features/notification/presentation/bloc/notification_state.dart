import 'package:equatable/equatable.dart';
import '../../domain/entities/app_notification.dart';

abstract class NotificationState extends Equatable {
  const NotificationState();

  @override
  List<Object?> get props => [];
}

class NotificationInitial extends NotificationState {
  const NotificationInitial();
}

class NotificationLoading extends NotificationState {
  const NotificationLoading();
}

class NotificationLoaded extends NotificationState {
  final List<AppNotification> allNotifications;
  final List<AppNotification> filteredNotifications;
  final String selectedFilter; // 'semua', 'operasional', 'persetujuan'
  final int unreadCount;

  const NotificationLoaded({
    required this.allNotifications,
    required this.filteredNotifications,
    this.selectedFilter = 'semua',
    required this.unreadCount,
  });

  NotificationLoaded copyWith({
    List<AppNotification>? allNotifications,
    List<AppNotification>? filteredNotifications,
    String? selectedFilter,
    int? unreadCount,
  }) {
    return NotificationLoaded(
      allNotifications: allNotifications ?? this.allNotifications,
      filteredNotifications:
          filteredNotifications ?? this.filteredNotifications,
      selectedFilter: selectedFilter ?? this.selectedFilter,
      unreadCount: unreadCount ?? this.unreadCount,
    );
  }

  @override
  List<Object?> get props => [
        allNotifications,
        filteredNotifications,
        selectedFilter,
        unreadCount,
      ];
}

class NotificationError extends NotificationState {
  final String message;

  const NotificationError({required this.message});

  @override
  List<Object?> get props => [message];
}
