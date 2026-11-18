import 'package:get_it/get_it.dart';
import 'core/network/dio_client.dart';
import 'features/home/data/datasources/home_remote_data_source.dart';
import 'features/home/data/datasources/home_remote_data_source_impl.dart';
import 'features/home/data/repositories/home_repository_impl.dart';
import 'features/home/domain/repositories/home_repository.dart';
import 'features/home/domain/usecases/get_home_dashboard.dart';
import 'features/home/presentation/bloc/home_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
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
