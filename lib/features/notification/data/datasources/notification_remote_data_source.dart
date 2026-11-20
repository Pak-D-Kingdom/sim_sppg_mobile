import '../models/notification_model.dart';

abstract class NotificationRemoteDataSource {
  Future<List<NotificationModel>> getNotifications();
  Future<List<NotificationModel>> markNotificationAsRead(String id);
  Future<List<NotificationModel>> markAllNotificationsAsRead();
}
