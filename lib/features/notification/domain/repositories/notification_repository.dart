import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/app_notification.dart';

abstract class NotificationRepository {
  Future<Either<Failure, List<AppNotification>>> getNotifications();
  Future<Either<Failure, List<AppNotification>>> markNotificationAsRead(String id);
  Future<Either<Failure, List<AppNotification>>> markAllNotificationsAsRead();
}
