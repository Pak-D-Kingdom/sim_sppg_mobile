import '../../../../core/constants/api_endpoints.dart';
import '../../../../core/network/dio_client.dart';
import '../models/home_dashboard_model.dart';
import '../models/home_menu_model.dart';
import '../models/home_statistic_model.dart';
import '../models/operational_alert_model.dart';
import '../models/quality_banner_model.dart';
import '../models/today_attendance_model.dart';
import 'home_remote_data_source.dart';

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final DioClient dioClient;

  HomeRemoteDataSourceImpl({required this.dioClient});

  @override
  Future<HomeDashboardModel> getHomeDashboard() async {
    try {
      final response = await dioClient.get(ApiEndpoints.homeDashboard);
      if (response.statusCode == 200 && response.data != null) {
        final data = response.data is Map<String, dynamic>
            ? response.data['data'] ?? response.data
            : response.data;
        return HomeDashboardModel.fromJson(data as Map<String, dynamic>);
      } else {
        return _getSampleDashboardData();
      }
    } catch (_) {
      return _getSampleDashboardData();
    }
  }

  HomeDashboardModel _getSampleDashboardData() {
    return const HomeDashboardModel(
      appTitle: 'SIM-SPPG',
      appVersion: 'V2.0',
      agencyName: 'SPPG Rawamangun Sentral 01',
      userName: 'Siti Rahmawati, A.Md.Gz',
      userNik: '3175022010920003',
      userRole: 'Ahli Gizi & Pengawas Mutu Masak',
      employmentBadge: 'Struktural',
      locationBadge: 'Rawamangun 01',
      unreadNotifications: 1,
      operationalAlert: OperationalAlertModel(
        category: 'PERINGATAN\nOPERASIONAL',
        badgeText: 'H-3\nPelaksanaan',
        title: '28 Nov 2026 — Pembersihan Menyeluruh & Pest Control Dapur',
        description:
            'Dapur Sentral LIBUR TOTAL OPERASIONAL. Pastikan seluruh bahan baku tertutup rapat & bersertifikat food-grade.',
      ),
      todayAttendance: TodayAttendanceModel(
        dateFormatted: 'Rabu, 20 November\n2026',
        statusText: 'Sedang\nBertugas',
        shiftLabel: 'Jadwal Shift',
        shiftSchedule: 'Shift Pagi (05:00 - 13:00 WIB)',
        clockInTime: '04:52',
        clockInStatus: 'Tepat Waktu',
        clockOutTime: '-- : --',
        clockOutStatus: 'Menunggu Jam\nPulang',
        isClockedOut: false,
      ),
      menus: [
        HomeMenuModel(
          id: 'm1',
          title: 'Presensi GPS',
          subtitle: 'Radius dapur & selfie',
          icon: 'gps',
          route: '/presensi/gps',
          theme: 'green',
        ),
        HomeMenuModel(
          id: 'm2',
          title: 'Koreksi Absen',
          subtitle: 'Revisi log clock-in/out',
          icon: 'koreksi',
          route: '/presensi/koreksi',
          badgeText: 'H+3',
          theme: 'blue',
        ),
        HomeMenuModel(
          id: 'm3',
          title: 'Ajukan Cuti',
          subtitle: 'Izin sakit & tahunan',
          icon: 'cuti',
          route: '/cuti/ajukan',
          badgeText: 'Sisa 5',
          theme: 'green',
        ),
        HomeMenuModel(
          id: 'm4',
          title: 'Jadwal & Libur',
          subtitle: 'Rotasi shift tim dapur',
          icon: 'jadwal',
          route: '/jadwal',
          theme: 'blue',
        ),
        HomeMenuModel(
          id: 'm5',
          title: 'Slip Payroll',
          subtitle: 'Gaji & rincian denda',
          icon: 'payroll',
          route: '/payroll',
          theme: 'amber',
        ),
        HomeMenuModel(
          id: 'm6',
          title: 'Approval Tim',
          subtitle: 'Verifikasi staf dapur',
          icon: 'approval',
          route: '/approval',
          badgeText: '3 Pending',
          theme: 'red',
        ),
      ],
      summaryPeriod: 'November 2026',
      statistics: [
        HomeStatisticModel(
          id: '1',
          title: 'Saldo Cuti',
          value: '5',
          unit: 'Hari',
          footer: 'Berlaku s/d Des',
          code: 'leave_balance',
        ),
        HomeStatisticModel(
          id: '2',
          title: 'Kehadiran',
          value: '18',
          unit: '/20',
          footer: '90% Target',
          code: 'attendance',
        ),
        HomeStatisticModel(
          id: '3',
          title: 'Denda Telat',
          value: 'Rp 0',
          footer: 'Disiplin Prima',
          code: 'penalty',
        ),
      ],
      qualityBanner: QualityBannerModel(
        tag: 'STANDAR MUTU SPPG',
        title: 'Kualitas Gizi Anak Indonesia Dimulai dari Kedisiplinan Kita',
        description:
            'Pastikan sampel makanan batch siang sudah diuji organoleptik sebelum didistribusikan.',
      ),
    );
  }
}
