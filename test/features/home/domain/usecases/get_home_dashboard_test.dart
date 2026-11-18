import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sim_sppg_mobile/core/error/failures.dart';
import 'package:sim_sppg_mobile/core/usecase/usecase.dart';
import 'package:sim_sppg_mobile/features/home/domain/entities/home_dashboard.dart';
import 'package:sim_sppg_mobile/features/home/domain/entities/operational_alert.dart';
import 'package:sim_sppg_mobile/features/home/domain/entities/quality_banner.dart';
import 'package:sim_sppg_mobile/features/home/domain/entities/today_attendance.dart';
import 'package:sim_sppg_mobile/features/home/domain/repositories/home_repository.dart';
import 'package:sim_sppg_mobile/features/home/domain/usecases/get_home_dashboard.dart';

class MockHomeRepository implements HomeRepository {
  Either<Failure, HomeDashboard>? result;

  @override
  Future<Either<Failure, HomeDashboard>> getHomeDashboard() async {
    if (result != null) {
      return result!;
    }
    throw UnimplementedError();
  }
}

void main() {
  late GetHomeDashboard useCase;
  late MockHomeRepository mockRepository;

  setUp(() {
    mockRepository = MockHomeRepository();
    useCase = GetHomeDashboard(mockRepository);
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

  test('should get home dashboard data from repository', () async {
    // arrange
    mockRepository.result = const Right(testDashboard);

    // act
    final result = await useCase(const NoParams());

    // assert
    expect(result, const Right(testDashboard));
  });

  test('should return ServerFailure when repository fails', () async {
    // arrange
    const failure = ServerFailure(message: 'Server error');
    mockRepository.result = const Left(failure);

    // act
    final result = await useCase(const NoParams());

    // assert
    expect(result, const Left(failure));
  });
}
