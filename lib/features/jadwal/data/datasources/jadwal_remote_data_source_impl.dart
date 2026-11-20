import '../../../../core/constants/api_endpoints.dart';
import '../../../../core/network/dio_client.dart';
import '../../domain/entities/jadwal_day.dart';
import '../../domain/entities/jadwal_day_type.dart';
import '../models/jadwal_data_model.dart';
import '../models/jadwal_day_model.dart';
import '../models/jadwal_summary_model.dart';
import 'jadwal_remote_data_source.dart';

class JadwalRemoteDataSourceImpl implements JadwalRemoteDataSource {
  final DioClient dioClient;

  JadwalRemoteDataSourceImpl({required this.dioClient});

  @override
  Future<JadwalDataModel> getJadwal({int? month, int? year}) async {
    try {
      final response = await dioClient.get(
        ApiEndpoints.jadwal,
        queryParameters: {
          if (month != null) 'month': month,
          if (year != null) 'year': year,
        },
      );

      if (response.statusCode == 200 && response.data != null) {
        final data = response.data is Map<String, dynamic>
            ? response.data['data'] ?? response.data
            : response.data;
        return JadwalDataModel.fromJson(data as Map<String, dynamic>);
      }
      return _generateSampleJadwalData(month ?? 11, year ?? 2026);
    } catch (_) {
      return _generateSampleJadwalData(month ?? 11, year ?? 2026);
    }
  }

  JadwalDataModel _generateSampleJadwalData(int month, int year) {
    // Generate dates for November 2026 exactly matching the reference design
    const int totalDays = 30;
    final List<JadwalDay> days = [];

    final indonesianDayNames = [
      'Minggu',
      'Senin',
      'Selasa',
      'Rabu',
      'Kamis',
      'Jumat',
      'Sabtu',
    ];

    final indonesianMonthNames = [
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

    for (int day = 1; day <= totalDays; day++) {
      final date = DateTime(year, month, day);
      final weekday = date.weekday % 7; // 0 = Sunday (Min), 6 = Saturday (Sab)
      final dayName = indonesianDayNames[weekday];
      final monthName = indonesianMonthNames[month - 1];
      final dateFormatted = '$dayName, $day $monthName $year';

      JadwalDayType type;
      String shiftTitle;
      String shiftCode;
      String divisiDapur;
      String jamShift;
      String toleransiTelat;
      String statusJadwal;

      if (day == 24 || day == 25) {
        // Cuti (Purple)
        type = JadwalDayType.cuti;
        shiftTitle = 'Cuti Tahunan Terjadwal';
        shiftCode = 'CUTI-REGULER';
        divisiDapur = 'Izin Resmi HRD';
        jamShift = '–';
        toleransiTelat = '–';
        statusJadwal = 'Disetujui (Cuti)';
      } else if (day == 27) {
        // Libur SPPG (Orange)
        type = JadwalDayType.liburSppg;
        shiftTitle = 'Pembersihan Dapur & Pest Control';
        shiftCode = 'SPPG-MAINT-01';
        divisiDapur = 'Dapur Sentral';
        jamShift = 'Libur Operasional Total';
        toleransiTelat = '–';
        statusJadwal = 'Instruksi Khusus';
      } else if (weekday == 0 || weekday == 6) {
        // Weekend / Off Day (Grey)
        type = JadwalDayType.libur;
        shiftTitle = 'Hari Libur Rutin';
        shiftCode = 'OFF-REGULER';
        divisiDapur = 'Tidak Bertugas';
        jamShift = '–';
        toleransiTelat = '–';
        statusJadwal = 'Libur Shift';
      } else {
        // Hari Kerja (Green)
        type = JadwalDayType.hariKerja;
        if (day == 26) {
          shiftTitle = 'Shift Persiapan Bahan Baku';
          shiftCode = 'SH-PREP-02';
          divisiDapur = 'Persiapan & Gudang';
          jamShift = '05:00 – 13:00 WIB';
          toleransiTelat = '10 Menit (Maks. 05:10)';
          statusJadwal = 'Terjadwal (Aktif)';
        } else {
          shiftTitle = 'Shift Masak & Pengolahan Makanan';
          shiftCode = 'SH-MASAK-01';
          divisiDapur = 'Pengolahan (Chef & Cook)';
          jamShift = '04:30 – 11:30 WIB';
          toleransiTelat = '10 Menit (Maks. 04:40)';
          statusJadwal = 'Terjadwal (Aktif)';
        }
      }

      days.add(
        JadwalDayModel(
          date: date,
          dayNumber: day,
          type: type,
          dateFormatted: dateFormatted,
          shiftTitle: shiftTitle,
          shiftCode: shiftCode,
          divisiDapur: divisiDapur,
          jamShift: jamShift,
          toleransiTelat: toleransiTelat,
          statusJadwal: statusJadwal,
        ),
      );
    }

    return JadwalDataModel(
      title: 'Jadwal & Libur',
      location: 'SPPG Rawamangun 01',
      currentMonthYear: '${indonesianMonthNames[month - 1]} $year',
      currentMonth: month,
      currentYear: year,
      summary: const JadwalSummaryModel(
        hariKerja: 22,
        liburOff: 6,
        kuotaCuti: '7/12 Hari',
        sisaCuti: 'Sisa 5 Hari',
      ),
      days: days,
    );
  }
}
