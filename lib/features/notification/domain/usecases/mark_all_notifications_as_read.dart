import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/app_notification.dart';
import '../repositories/notification_repository.dart';

class MarkAllNotificationsAsRead
    implements UseCase<List<AppNotification>, NoParams> {
  final NotificationRepository repository;

  MarkAllNotificationsAsRead(this.repository);

  @override
  Future<Either<Failure, List<AppNotification>>> call(NoParams params) async {
    return await repository.markAllNotificationsAsRead();
  }
}
