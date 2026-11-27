import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/localization/locale_cubit.dart';
import 'core/network/dio_client.dart';
import 'features/akun/data/datasources/akun_remote_data_source.dart';
import 'features/akun/data/datasources/akun_remote_data_source_impl.dart';
import 'features/akun/data/repositories/akun_repository_impl.dart';
import 'features/akun/domain/repositories/akun_repository.dart';
import 'features/akun/domain/usecases/get_akun_profile.dart';
import 'features/akun/presentation/bloc/akun_bloc.dart';
import 'features/auth/data/datasources/auth_local_data_source.dart';
import 'features/auth/data/datasources/auth_local_data_source_impl.dart';
import 'features/auth/data/datasources/auth_remote_data_source.dart';
import 'features/auth/data/datasources/auth_remote_data_source_impl.dart';
import 'features/auth/data/repositories/auth_repository_impl.dart';
import 'features/auth/domain/repositories/auth_repository.dart';
import 'features/auth/domain/usecases/get_cached_session.dart';
import 'features/auth/domain/usecases/login_user.dart';
import 'features/auth/domain/usecases/logout_user.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/cuti/cuti_tahunan/data/datasources/cuti_tahunan_remote_data_source.dart';
import 'features/cuti/cuti_tahunan/data/datasources/cuti_tahunan_remote_data_source_impl.dart';
import 'features/cuti/cuti_tahunan/data/repositories/cuti_tahunan_repository_impl.dart';
import 'features/cuti/cuti_tahunan/domain/repositories/cuti_tahunan_repository.dart';
import 'features/cuti/cuti_tahunan/domain/usecases/cuti_tahunan_usecases.dart';
import 'features/cuti/cuti_tahunan/presentation/bloc/cuti_tahunan_bloc.dart';
import 'features/cuti/data/datasources/cuti_remote_data_source.dart';
import 'features/cuti/data/datasources/cuti_remote_data_source_impl.dart';
import 'features/cuti/data/repositories/cuti_repository_impl.dart';
import 'features/cuti/domain/repositories/cuti_repository.dart';
import 'features/cuti/domain/usecases/get_cuti_quota.dart';
import 'features/cuti/domain/usecases/submit_cuti.dart';
import 'features/cuti/izin_darurat/data/datasources/izin_darurat_remote_data_source.dart';
import 'features/cuti/izin_darurat/data/datasources/izin_darurat_remote_data_source_impl.dart';
import 'features/cuti/izin_darurat/data/repositories/izin_darurat_repository_impl.dart';
import 'features/cuti/izin_darurat/domain/repositories/izin_darurat_repository.dart';
import 'features/cuti/izin_darurat/domain/usecases/submit_izin_darurat.dart';
import 'features/cuti/izin_darurat/presentation/bloc/izin_darurat_bloc.dart';
import 'features/cuti/izin_sakit/data/datasources/izin_sakit_remote_data_source.dart';
import 'features/cuti/izin_sakit/data/datasources/izin_sakit_remote_data_source_impl.dart';
import 'features/cuti/izin_sakit/data/repositories/izin_sakit_repository_impl.dart';
import 'features/cuti/izin_sakit/domain/repositories/izin_sakit_repository.dart';
import 'features/cuti/izin_sakit/domain/usecases/submit_bukti_sakit.dart';
import 'features/cuti/izin_sakit/domain/usecases/submit_laporan_sakit.dart';
import 'features/cuti/izin_sakit/presentation/bloc/izin_sakit_bloc.dart';
import 'features/cuti/presentation/bloc/cuti_bloc.dart';
import 'features/home/data/datasources/home_remote_data_source.dart';
import 'features/home/data/datasources/home_remote_data_source_impl.dart';
import 'features/home/data/repositories/home_repository_impl.dart';
import 'features/home/domain/repositories/home_repository.dart';
import 'features/home/domain/usecases/get_home_dashboard.dart';
import 'features/home/presentation/bloc/home_bloc.dart';
import 'features/jadwal/data/datasources/jadwal_remote_data_source.dart';
import 'features/jadwal/data/datasources/jadwal_remote_data_source_impl.dart';
import 'features/jadwal/data/repositories/jadwal_repository_impl.dart';
import 'features/jadwal/domain/repositories/jadwal_repository.dart';
import 'features/jadwal/domain/usecases/get_jadwal.dart';
import 'features/jadwal/presentation/bloc/jadwal_bloc.dart';
import 'features/notification/data/datasources/notification_remote_data_source.dart';
import 'features/notification/data/datasources/notification_remote_data_source_impl.dart';
import 'features/notification/data/repositories/notification_repository_impl.dart';
import 'features/notification/domain/repositories/notification_repository.dart';
import 'features/notification/domain/usecases/get_notifications.dart';
import 'features/notification/domain/usecases/mark_all_notifications_as_read.dart';
import 'features/notification/domain/usecases/mark_notification_as_read.dart';
import 'features/notification/presentation/bloc/notification_bloc.dart';
import 'features/payroll/data/datasources/payroll_remote_data_source.dart';
import 'features/payroll/data/datasources/payroll_remote_data_source_impl.dart';
import 'features/payroll/data/repositories/payroll_repository_impl.dart';
import 'features/payroll/domain/repositories/payroll_repository.dart';
import 'features/payroll/domain/usecases/get_payroll_data.dart';
import 'features/payroll/presentation/bloc/payroll_bloc.dart';
import 'features/presensi/data/datasources/presensi_remote_data_source.dart';
import 'features/presensi/data/datasources/presensi_remote_data_source_impl.dart';
import 'features/presensi/data/repositories/presensi_repository_impl.dart';
import 'features/presensi/domain/repositories/presensi_repository.dart';
import 'features/presensi/domain/usecases/submit_presensi.dart';
import 'features/presensi/presentation/bloc/presensi_bloc.dart';
import 'features/riwayat_absen/data/datasources/riwayat_absen_remote_data_source.dart';
import 'features/riwayat_absen/data/datasources/riwayat_absen_remote_data_source_impl.dart';
import 'features/riwayat_absen/data/repositories/riwayat_absen_repository_impl.dart';
import 'features/riwayat_absen/domain/repositories/riwayat_absen_repository.dart';
import 'features/riwayat_absen/domain/usecases/get_riwayat_absen.dart';
import 'features/riwayat_absen/presentation/bloc/riwayat_absen_bloc.dart';

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

  //! Features - Jadwal
  // Bloc
  sl.registerFactory(
    () => JadwalBloc(
      getJadwal: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => GetJadwal(sl()));

  // Repository
  sl.registerLazySingleton<JadwalRepository>(
    () => JadwalRepositoryImpl(
      remoteDataSource: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<JadwalRemoteDataSource>(
    () => JadwalRemoteDataSourceImpl(
      dioClient: sl(),
    ),
  );

  //! Features - Cuti Tahunan
  // Bloc
  sl.registerFactory(
    () => CutiTahunanBloc(
      getQuota: sl(),
      submitCuti: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => GetCutiTahunanQuota(sl()));
  sl.registerLazySingleton(() => SubmitCutiTahunan(sl()));

  // Repository
  sl.registerLazySingleton<CutiTahunanRepository>(
    () => CutiTahunanRepositoryImpl(
      remoteDataSource: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<CutiTahunanRemoteDataSource>(
    () => CutiTahunanRemoteDataSourceImpl(
      dioClient: sl(),
    ),
  );

  //! Features - Izin Sakit
  // Bloc
  sl.registerFactory(
    () => IzinSakitBloc(
      submitLaporanSakit: sl(),
      submitBuktiSakit: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => SubmitLaporanSakit(sl()));
  sl.registerLazySingleton(() => SubmitBuktiSakit(sl()));

  // Repository
  sl.registerLazySingleton<IzinSakitRepository>(
    () => IzinSakitRepositoryImpl(
      remoteDataSource: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<IzinSakitRemoteDataSource>(
    () => IzinSakitRemoteDataSourceImpl(
      dioClient: sl(),
    ),
  );

  //! Features - Izin Darurat
  // Bloc
  sl.registerFactory(
    () => IzinDaruratBloc(
      getInitialIzinDarurat: sl(),
      submitIzinDarurat: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => GetInitialIzinDarurat(sl()));
  sl.registerLazySingleton(() => SubmitIzinDarurat(sl()));

  // Repository
  sl.registerLazySingleton<IzinDaruratRepository>(
    () => IzinDaruratRepositoryImpl(
      remoteDataSource: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<IzinDaruratRemoteDataSource>(
    () => IzinDaruratRemoteDataSourceImpl(
      dioClient: sl(),
    ),
  );

  //! Features - Cuti (Legacy / General)
  // Bloc
  sl.registerFactory(
    () => CutiBloc(
      getCutiQuota: sl(),
      submitCuti: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => GetCutiQuota(sl()));
  sl.registerLazySingleton(() => SubmitCuti(sl()));

  // Repository
  sl.registerLazySingleton<CutiRepository>(
    () => CutiRepositoryImpl(
      remoteDataSource: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<CutiRemoteDataSource>(
    () => CutiRemoteDataSourceImpl(
      dioClient: sl(),
    ),
  );

  //! Features - Payroll
  // Bloc
  sl.registerFactory(
    () => PayrollBloc(
      getPayrollData: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => GetPayrollData(sl()));

  // Repository
  sl.registerLazySingleton<PayrollRepository>(
    () => PayrollRepositoryImpl(
      remoteDataSource: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<PayrollRemoteDataSource>(
    () => PayrollRemoteDataSourceImpl(
      dioClient: sl(),
    ),
  );

  //! Features - Presensi
  // Bloc
  sl.registerFactory(
    () => PresensiBloc(
      getPresensiStatus: sl(),
      submitClockIn: sl(),
      submitClockOut: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => GetPresensiStatus(sl()));
  sl.registerLazySingleton(() => SubmitClockIn(sl()));
  sl.registerLazySingleton(() => SubmitClockOut(sl()));

  // Repository
  sl.registerLazySingleton<PresensiRepository>(
    () => PresensiRepositoryImpl(
      remoteDataSource: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<PresensiRemoteDataSource>(
    () => PresensiRemoteDataSourceImpl(
      dioClient: sl(),
    ),
  );

  //! Features - Riwayat Absen
  // Bloc
  sl.registerFactory(
    () => RiwayatAbsenBloc(
      getRiwayatAbsen: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => GetRiwayatAbsen(sl()));

  // Repository
  sl.registerLazySingleton<RiwayatAbsenRepository>(
    () => RiwayatAbsenRepositoryImpl(
      remoteDataSource: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<RiwayatAbsenRemoteDataSource>(
    () => RiwayatAbsenRemoteDataSourceImpl(
      dioClient: sl(),
    ),
  );

  //! Features - Akun
  // Bloc
  sl.registerFactory(
    () => AkunBloc(
      getAkunProfile: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => GetAkunProfile(sl()));

  // Repository
  sl.registerLazySingleton<AkunRepository>(
    () => AkunRepositoryImpl(
      remoteDataSource: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<AkunRemoteDataSource>(
    () => AkunRemoteDataSourceImpl(
      dioClient: sl(),
    ),
  );

  //! Features - Auth
  // Bloc
  sl.registerFactory(
    () => AuthBloc(
      loginUser: sl(),
      getCachedSession: sl(),
      logoutUser: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => LoginUser(sl()));
  sl.registerLazySingleton(() => GetCachedSession(sl()));
  sl.registerLazySingleton(() => LogoutUser(sl()));

  // Repository
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(
      dioClient: sl(),
    ),
  );
  sl.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSourceImpl(
      sharedPreferences: sl(),
    ),
  );

  //! Core
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => DioClient());
  sl.registerLazySingleton(() => LocaleCubit());
}
