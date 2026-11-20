import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sim_sppg_mobile/core/error/failures.dart';
import 'package:sim_sppg_mobile/features/notification/domain/entities/app_notification.dart';
import 'package:sim_sppg_mobile/features/notification/domain/repositories/notification_repository.dart';
import 'package:sim_sppg_mobile/features/notification/domain/usecases/get_notifications.dart';
import 'package:sim_sppg_mobile/features/notification/domain/usecases/mark_all_notifications_as_read.dart';
import 'package:sim_sppg_mobile/features/notification/domain/usecases/mark_notification_as_read.dart';
import 'package:sim_sppg_mobile/features/notification/presentation/bloc/notification_bloc.dart';
import 'package:sim_sppg_mobile/features/notification/presentation/bloc/notification_event.dart';
import 'package:sim_sppg_mobile/features/notification/presentation/bloc/notification_state.dart';

class MockNotificationRepository implements NotificationRepository {
  List<AppNotification> items = [
    const AppNotification(
      id: '1',
      category: 'PERINGATAN OPERASIONAL',
      type: 'operasional',
      title: '28 Nov 2026 — Pembersihan Menyeluruh & Pest Control Dapur',
      description: 'Dapur Sentral LIBUR TOTAL OPERASIONAL.',
      timestamp: '20 Nov 2026 • 08:00 WIB',
      isRead: false,
    ),
    const AppNotification(
      id: '2',
      category: 'PENGAJUAN CUTI',
      type: 'persetujuan',
      title: 'Pengajuan Cuti Menunggu Persetujuan',
      description: 'Rizky Pratama mengajukan cuti.',
      timestamp: '20 Nov 2026 • 07:15 WIB',
      isRead: false,
    ),
    const AppNotification(
      id: '3',
      category: 'PRESENSI HARIAN',
      type: 'operasional',
      title: 'Clock-In Berhasil (Tepat Waktu)',
      description: 'Presensi masuk shift pagi tercatat.',
      timestamp: '20 Nov 2026 • 04:52 WIB',
      isRead: true,
    ),
  ];

  @override
  Future<Either<Failure, List<AppNotification>>> getNotifications() async {
    return Right(items);
  }

  @override
  Future<Either<Failure, List<AppNotification>>> markNotificationAsRead(
      String id) async {
    items = items.map((e) => e.id == id ? e.copyWith(isRead: true) : e).toList();
    return Right(items);
  }

  @override
  Future<Either<Failure, List<AppNotification>>>
      markAllNotificationsAsRead() async {
    items = items.map((e) => e.copyWith(isRead: true)).toList();
    return Right(items);
  }
}

void main() {
  late NotificationBloc bloc;
  late MockNotificationRepository mockRepo;
  late GetNotifications getNotifications;
  late MarkNotificationAsRead markNotificationAsRead;
  late MarkAllNotificationsAsRead markAllNotificationsAsRead;

  setUp(() {
    mockRepo = MockNotificationRepository();
    getNotifications = GetNotifications(mockRepo);
    markNotificationAsRead = MarkNotificationAsRead(mockRepo);
    markAllNotificationsAsRead = MarkAllNotificationsAsRead(mockRepo);

    bloc = NotificationBloc(
      getNotifications: getNotifications,
      markNotificationAsRead: markNotificationAsRead,
      markAllNotificationsAsRead: markAllNotificationsAsRead,
    );
  });

  tearDown(() {
    bloc.close();
  });

  test('initial state should be NotificationInitial', () {
    expect(bloc.state, const NotificationInitial());
  });

  test('should emit NotificationLoaded with unreadCount when LoadNotificationsEvent is added', () async {
    bloc.add(const LoadNotificationsEvent());

    await expectLater(
      bloc.stream,
      emitsInOrder([
        const NotificationLoading(),
        predicate<NotificationLoaded>((state) {
          return state.allNotifications.length == 3 &&
              state.unreadCount == 2 &&
              state.selectedFilter == 'semua';
        }),
      ]),
    );
  });

  test('should filter by persetujuan when FilterNotificationsEvent is added', () async {
    bloc.add(const LoadNotificationsEvent());
    await bloc.stream.firstWhere((s) => s is NotificationLoaded);

    bloc.add(const FilterNotificationsEvent('persetujuan'));

    await expectLater(
      bloc.stream,
      emits(
        predicate<NotificationLoaded>((state) {
          return state.selectedFilter == 'persetujuan' &&
              state.filteredNotifications.length == 1 &&
              state.filteredNotifications.first.category == 'PENGAJUAN CUTI';
        }),
      ),
    );
  });

  test('should mark all notifications as read when MarkAllNotificationsAsReadEvent is added', () async {
    bloc.add(const LoadNotificationsEvent());
    await bloc.stream.firstWhere((s) => s is NotificationLoaded);

    bloc.add(const MarkAllNotificationsAsReadEvent());

    await expectLater(
      bloc.stream,
      emits(
        predicate<NotificationLoaded>((state) {
          return state.unreadCount == 0 &&
              state.allNotifications.every((element) => element.isRead);
        }),
      ),
    );
  });
}
