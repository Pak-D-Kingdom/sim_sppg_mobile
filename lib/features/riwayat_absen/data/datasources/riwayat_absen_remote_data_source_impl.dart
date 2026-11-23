import '../../../../core/network/dio_client.dart';
import '../../domain/entities/riwayat_absen_item.dart';
import '../models/riwayat_absen_model.dart';
import 'riwayat_absen_remote_data_source.dart';

class RiwayatAbsenRemoteDataSourceImpl implements RiwayatAbsenRemoteDataSource {
  final DioClient dioClient;

  RiwayatAbsenRemoteDataSourceImpl({required this.dioClient});

  static const List<String> _monthNames = [
    'Januari',
    'Februari',
    'Maret',
    'April',
    'Mei',
    'Juni',
    'Juli',
    'Agustus',
    'September',
    'Oktober',
    'November',
    'Desember',
  ];

  static const List<String> _shortMonthNames = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'Mei',
    'Jun',
    'Jul',
    'Agu',
    'Sep',
    'Okt',
    'Nov',
    'Des',
  ];

  static const List<String> _shortDayNames = [
    'Sen',
    'Sel',
    'Rab',
    'Kam',
    'Jum',
    'Sab',
    'Min',
  ];

  @override
  Future<RiwayatAbsenDataModel> getRiwayatAbsen({
    required int month,
    required int year,
  }) async {
    return _getSampleData(month: month, year: year);
  }

  RiwayatAbsenDataModel _getSampleData({
    required int month,
    required int year,
  }) {
    final monthLabel = '${_monthNames[month - 1]} $year';

    if (month == 11 && year == 2026) {
      return RiwayatAbsenDataModel(
        month: 11,
        year: 2026,
        monthLabel: monthLabel,
        hadirCount: 15,
        telatCount: 2,
        cutiIzinCount: 3,
        menungguCount: 1,
        items: const [
          RiwayatAbsenItemModel(
            id: 'nov-20',
            dateLabel: 'Jum, 20 Nov 2026',
            statusType: RiwayatStatusType.menungguAcc,
            statusBadge: 'Menunggu ACC',
            description: 'Izin Sakit • Shift Pagi (05:00 - 13:00)',
            actionBannerText: 'Bukti dokter belum diunggah (Sisa 47j)',
            actionBannerCta: 'Unggah',
          ),
          RiwayatAbsenItemModel(
            id: 'nov-19',
            dateLabel: 'Kam, 19 Nov 2026',
            statusType: RiwayatStatusType.tepatWaktu,
            statusBadge: 'Tepat Waktu',
            clockInTime: '04:52 WIB',
            clockOutTime: '13:02 WIB',
            durationText: '8j 10m',
          ),
          RiwayatAbsenItemModel(
            id: 'nov-18',
            dateLabel: 'Rab, 18 Nov 2026',
            statusType: RiwayatStatusType.telat,
            statusBadge: 'Telat 12 Menit',
            clockInTime: '05:12 WIB',
            clockOutTime: '13:05 WIB',
            canRequestCorrection: true,
          ),
          RiwayatAbsenItemModel(
            id: 'nov-17',
            dateLabel: 'Sel, 17 Nov 2026',
            statusType: RiwayatStatusType.cutiDisetujui,
            statusBadge: 'Cuti Disetujui',
            description: 'Cuti Tahunan • Sudah diverifikasi KSPPG',
          ),
          RiwayatAbsenItemModel(
            id: 'nov-16',
            dateLabel: 'Sen, 16 Nov 2026',
            statusType: RiwayatStatusType.tepatWaktu,
            statusBadge: 'Tepat Waktu',
            clockInTime: '04:55 WIB',
            clockOutTime: '13:01 WIB',
            durationText: '8j 06m',
          ),
          RiwayatAbsenItemModel(
            id: 'nov-14',
            dateLabel: 'Sab, 14 Nov 2026',
            statusType: RiwayatStatusType.tepatWaktu,
            statusBadge: 'Tepat Waktu',
            clockInTime: '04:50 WIB',
            clockOutTime: '13:00 WIB',
            durationText: '8j 10m',
          ),
          RiwayatAbsenItemModel(
            id: 'nov-13',
            dateLabel: 'Jum, 13 Nov 2026',
            statusType: RiwayatStatusType.tepatWaktu,
            statusBadge: 'Tepat Waktu',
            clockInTime: '04:54 WIB',
            clockOutTime: '13:04 WIB',
            durationText: '8j 10m',
          ),
          RiwayatAbsenItemModel(
            id: 'nov-12',
            dateLabel: 'Kam, 12 Nov 2026',
            statusType: RiwayatStatusType.telat,
            statusBadge: 'Telat 8 Menit',
            clockInTime: '05:08 WIB',
            clockOutTime: '13:02 WIB',
            canRequestCorrection: true,
          ),
          RiwayatAbsenItemModel(
            id: 'nov-11',
            dateLabel: 'Rab, 11 Nov 2026',
            statusType: RiwayatStatusType.tepatWaktu,
            statusBadge: 'Tepat Waktu',
            clockInTime: '04:49 WIB',
            clockOutTime: '13:01 WIB',
            durationText: '8j 12m',
          ),
          RiwayatAbsenItemModel(
            id: 'nov-10',
            dateLabel: 'Sel, 10 Nov 2026',
            statusType: RiwayatStatusType.tepatWaktu,
            statusBadge: 'Tepat Waktu',
            clockInTime: '04:56 WIB',
            clockOutTime: '13:00 WIB',
            durationText: '8j 04m',
          ),
          RiwayatAbsenItemModel(
            id: 'nov-09',
            dateLabel: 'Sen, 09 Nov 2026',
            statusType: RiwayatStatusType.cutiDisetujui,
            statusBadge: 'Cuti Disetujui',
            description: 'Izin Darurat • Sudah diverifikasi KSPPG',
          ),
          RiwayatAbsenItemModel(
            id: 'nov-07',
            dateLabel: 'Sab, 07 Nov 2026',
            statusType: RiwayatStatusType.tepatWaktu,
            statusBadge: 'Tepat Waktu',
            clockInTime: '04:53 WIB',
            clockOutTime: '13:05 WIB',
            durationText: '8j 12m',
          ),
          RiwayatAbsenItemModel(
            id: 'nov-06',
            dateLabel: 'Jum, 06 Nov 2026',
            statusType: RiwayatStatusType.tepatWaktu,
            statusBadge: 'Tepat Waktu',
            clockInTime: '04:51 WIB',
            clockOutTime: '13:00 WIB',
            durationText: '8j 09m',
          ),
          RiwayatAbsenItemModel(
            id: 'nov-05',
            dateLabel: 'Kam, 05 Nov 2026',
            statusType: RiwayatStatusType.tepatWaktu,
            statusBadge: 'Tepat Waktu',
            clockInTime: '04:55 WIB',
            clockOutTime: '13:03 WIB',
            durationText: '8j 08m',
          ),
          RiwayatAbsenItemModel(
            id: 'nov-04',
            dateLabel: 'Rab, 04 Nov 2026',
            statusType: RiwayatStatusType.tepatWaktu,
            statusBadge: 'Tepat Waktu',
            clockInTime: '04:57 WIB',
            clockOutTime: '13:02 WIB',
            durationText: '8j 05m',
          ),
          RiwayatAbsenItemModel(
            id: 'nov-03',
            dateLabel: 'Sel, 03 Nov 2026',
            statusType: RiwayatStatusType.tepatWaktu,
            statusBadge: 'Tepat Waktu',
            clockInTime: '04:48 WIB',
            clockOutTime: '13:01 WIB',
            durationText: '8j 13m',
          ),
          RiwayatAbsenItemModel(
            id: 'nov-02',
            dateLabel: 'Sen, 02 Nov 2026',
            statusType: RiwayatStatusType.tepatWaktu,
            statusBadge: 'Tepat Waktu',
            clockInTime: '04:54 WIB',
            clockOutTime: '13:00 WIB',
            durationText: '8j 06m',
          ),
          RiwayatAbsenItemModel(
            id: 'nov-01',
            dateLabel: 'Min, 01 Nov 2026',
            statusType: RiwayatStatusType.tepatWaktu,
            statusBadge: 'Tepat Waktu',
            clockInTime: '04:50 WIB',
            clockOutTime: '13:02 WIB',
            durationText: '8j 12m',
          ),
          RiwayatAbsenItemModel(
            id: 'nov-15',
            dateLabel: 'Min, 15 Nov 2026',
            statusType: RiwayatStatusType.tepatWaktu,
            statusBadge: 'Tepat Waktu',
            clockInTime: '04:52 WIB',
            clockOutTime: '13:00 WIB',
            durationText: '8j 08m',
          ),
          RiwayatAbsenItemModel(
            id: 'nov-08',
            dateLabel: 'Min, 08 Nov 2026',
            statusType: RiwayatStatusType.tepatWaktu,
            statusBadge: 'Tepat Waktu',
            clockInTime: '04:56 WIB',
            clockOutTime: '13:04 WIB',
            durationText: '8j 08m',
          ),
        ],
      );
    }

    // Generate consistent sample entries for other months
    final shortMonth = _shortMonthNames[month - 1];
    final daysInMonth = DateTime(year, month + 1, 0).day;
    final items = <RiwayatAbsenItemModel>[];

    int hadirCount = 0;
    int telatCount = 0;
    int cutiIzinCount = 0;

    for (int day = daysInMonth; day >= 1 && items.length < 18; day--) {
      final date = DateTime(year, month, day);
      if (date.weekday == DateTime.sunday) continue;

      final dayName = _shortDayNames[date.weekday - 1];
      final dd = day.toString().padLeft(2, '0');
      final dateLabel = '$dayName, $dd $shortMonth $year';

      if (day == 18) {
        telatCount++;
        items.add(
          RiwayatAbsenItemModel(
            id: '$year-$month-$day',
            dateLabel: dateLabel,
            statusType: RiwayatStatusType.telat,
            statusBadge: 'Telat 10 Menit',
            clockInTime: '05:10 WIB',
            clockOutTime: '13:03 WIB',
            canRequestCorrection: true,
          ),
        );
      } else if (day == 12) {
        cutiIzinCount++;
        items.add(
          RiwayatAbsenItemModel(
            id: '$year-$month-$day',
            dateLabel: dateLabel,
            statusType: RiwayatStatusType.cutiDisetujui,
            statusBadge: 'Cuti Disetujui',
            description: 'Cuti Tahunan • Sudah diverifikasi KSPPG',
          ),
        );
      } else {
        hadirCount++;
        final minute = (48 + (day % 10)).toString().padLeft(2, '0');
        items.add(
          RiwayatAbsenItemModel(
            id: '$year-$month-$day',
            dateLabel: dateLabel,
            statusType: RiwayatStatusType.tepatWaktu,
            statusBadge: 'Tepat Waktu',
            clockInTime: '04:$minute WIB',
            clockOutTime: '13:02 WIB',
            durationText: '8j ${(62 - int.parse(minute)).toString().padLeft(2, '0')}m',
          ),
        );
      }
    }

    return RiwayatAbsenDataModel(
      month: month,
      year: year,
      monthLabel: monthLabel,
      hadirCount: hadirCount,
      telatCount: telatCount,
      cutiIzinCount: cutiIzinCount,
      menungguCount: 0,
      items: items,
    );
  }
}
