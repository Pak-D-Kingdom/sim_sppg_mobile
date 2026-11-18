import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sim_sppg_mobile/core/error/failures.dart';
import 'package:sim_sppg_mobile/features/home/domain/entities/home_dashboard.dart';
import 'package:sim_sppg_mobile/features/home/domain/entities/operational_alert.dart';
import 'package:sim_sppg_mobile/features/home/domain/entities/quality_banner.dart';
import 'package:sim_sppg_mobile/features/home/domain/entities/today_attendance.dart';
import 'package:sim_sppg_mobile/features/home/domain/repositories/home_repository.dart';
import 'package:sim_sppg_mobile/features/home/domain/usecases/get_home_dashboard.dart';
import 'package:sim_sppg_mobile/features/home/presentation/bloc/home_bloc.dart';
import 'package:sim_sppg_mobile/features/home/presentation/bloc/home_event.dart';
import 'package:sim_sppg_mobile/features/home/presentation/bloc/home_state.dart';

class MockHomeRepository implements HomeRepository {
  Either<Failure, HomeDashboard>? result;

  @override
  Future<Either<Failure, HomeDashboard>> getHomeDashboard() async {
    return result!;
  }
}

void main() {
  late HomeBloc bloc;
  late MockHomeRepository mockRepository;
  late GetHomeDashboard getHomeDashboard;

  setUp(() {
    mockRepository = MockHomeRepository();
    getHomeDashboard = GetHomeDashboard(mockRepository);
    bloc = HomeBloc(getHomeDashboard: getHomeDashboard);
  });

  tearDown(() {
    bloc.close();
  });

  const testDashboard = HomeDashboard(
    userName: 'Siti Rahmawati, A.Md.Gz',
    userRole: 'Ahli Gizi & Pengawas Mutu Masak',
    agencyName: 'SPPG Rawamangun Sentral 01',
    unreadNotifications: 1,
    operationalAlert: OperationalAlert(
      category: 'PERINGATAN\nOPERASIONAL',
      badgeText: 'H-3\nPelaksanaan',
      title: '28 Nov 2026 — Pembersihan Menyeluruh & Pest Control Dapur',
      description: 'Dapur Sentral LIBUR TOTAL OPERASIONAL.',
    ),
    todayAttendance: TodayAttendance(
      dateFormatted: 'Rabu, 20 November\n2026',
      statusText: 'Sedang\nBertugas',
      shiftLabel: 'Jadwal Shift',
      shiftSchedule: 'Shift Pagi (05:00 - 13:00 WIB)',
      clockInTime: '04:52',
      clockInStatus: 'Tepat Waktu',
      clockOutTime: '-- : --',
      clockOutStatus: 'Menunggu Jam\nPulang',
    ),
    menus: [],
    statistics: [],
    qualityBanner: QualityBanner(
      tag: 'STANDAR MUTU SPPG',
      title: 'Kualitas Gizi Anak Indonesia Dimulai dari Kedisiplinan Kita',
      description: 'Pastikan sampel makanan batch siang sudah diuji organoleptik.',
    ),
  );

  test('initial state should be HomeInitial', () {
    expect(bloc.state, const HomeInitial());
  });

  test(
      'should emit [HomeLoading, HomeLoaded] when LoadHomeDashboardEvent succeeds',
      () async {
    // arrange
    mockRepository.result = const Right(testDashboard);

    // assert later
    final expected = [
      const HomeLoading(),
      const HomeLoaded(dashboard: testDashboard),
    ];
    expectLater(bloc.stream, emitsInOrder(expected));

    // act
    bloc.add(const LoadHomeDashboardEvent());
  });

  test(
      'should emit [HomeLoading, HomeError] when LoadHomeDashboardEvent fails',
      () async {
    // arrange
    mockRepository.result = const Left(ServerFailure(message: 'Error server'));

    // assert later
    final expected = [
      const HomeLoading(),
      const HomeError(message: 'Error server'),
    ];
    expectLater(bloc.stream, emitsInOrder(expected));

    // act
    bloc.add(const LoadHomeDashboardEvent());
  });
}
