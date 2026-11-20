import 'package:get_it/get_it.dart';
import 'core/network/dio_client.dart';
import 'features/home/data/datasources/home_remote_data_source.dart';
import 'features/home/data/datasources/home_remote_data_source_impl.dart';
import 'features/home/data/repositories/home_repository_impl.dart';
import 'features/home/domain/repositories/home_repository.dart';
import 'features/home/domain/usecases/get_home_dashboard.dart';
import 'features/home/presentation/bloc/home_bloc.dart';
import 'features/notification/data/datasources/notification_remote_data_source.dart';
import 'features/notification/data/datasources/notification_remote_data_source_impl.dart';
import 'features/notification/data/repositories/notification_repository_impl.dart';
import 'features/notification/domain/repositories/notification_repository.dart';
import 'features/notification/domain/usecases/get_notifications.dart';
import 'features/notification/domain/usecases/mark_all_notifications_as_read.dart';
import 'features/notification/domain/usecases/mark_notification_as_read.dart';
import 'features/notification/presentation/bloc/notification_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features - Notification
  // Bloc
  sl.registerFactory(
    () => NotificationBloc(
      getNotifications: sl(),
      markNotificationAsRead: sl(),
      markAllNotificationsAsRead: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => GetNotifications(sl()));
  sl.registerLazySingleton(() => MarkNotificationAsRead(sl()));
  sl.registerLazySingleton(() => MarkAllNotificationsAsRead(sl()));

  // Repository
  sl.registerLazySingleton<NotificationRepository>(
    () => NotificationRepositoryImpl(
      remoteDataSource: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<NotificationRemoteDataSource>(
    () => NotificationRemoteDataSourceImpl(
      dioClient: sl(),
    ),
  );

  //! Features - Home
  // Bloc
  sl.registerFactory(
    () => HomeBloc(
      getHomeDashboard: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => GetHomeDashboard(sl()));

  // Repository
  sl.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImpl(
      remoteDataSource: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<HomeRemoteDataSource>(
    () => HomeRemoteDataSourceImpl(
      dioClient: sl(),
    ),
  );

  //! Core
  sl.registerLazySingleton(() => DioClient());
}
