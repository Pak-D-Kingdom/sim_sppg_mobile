import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/app_notification.dart';
import '../repositories/notification_repository.dart';

class MarkNotificationAsReadParams extends Equatable {
  final String id;

  const MarkNotificationAsReadParams({required this.id});

  @override
  List<Object?> get props => [id];
}

class MarkNotificationAsRead
    implements UseCase<List<AppNotification>, MarkNotificationAsReadParams> {
  final NotificationRepository repository;

  MarkNotificationAsRead(this.repository);

  @override
  Future<Either<Failure, List<AppNotification>>> call(
      MarkNotificationAsReadParams params) async {
    return await repository.markNotificationAsRead(params.id);
  }
}
