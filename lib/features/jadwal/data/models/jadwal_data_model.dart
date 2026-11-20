import '../../domain/entities/jadwal_data.dart';
import '../../domain/entities/jadwal_day.dart';
import 'jadwal_day_model.dart';
import 'jadwal_summary_model.dart';

class JadwalDataModel extends JadwalData {
  const JadwalDataModel({
    required super.title,
    required super.location,
    required super.currentMonthYear,
    required super.currentMonth,
    required super.currentYear,
    required super.summary,
    required super.days,
  });

  factory JadwalDataModel.fromJson(Map<String, dynamic> json) {
    final daysJson = json['days'] as List<dynamic>? ?? [];
    final List<JadwalDay> days = daysJson
        .map((d) => JadwalDayModel.fromJson(d as Map<String, dynamic>))
        .toList();

    return JadwalDataModel(
      title: json['title'] as String? ?? 'Jadwal & Libur',
      location: json['location'] as String? ?? 'SPPG Rawamangun 01',
      currentMonthYear: json['current_month_year'] as String? ?? 'November 2026',
      currentMonth: json['current_month'] as int? ?? 11,
      currentYear: json['current_year'] as int? ?? 2026,
      summary: json['summary'] != null
          ? JadwalSummaryModel.fromJson(json['summary'] as Map<String, dynamic>)
          : const JadwalSummaryModel(
              hariKerja: 22,
              liburOff: 6,
              kuotaCuti: '7/12 Hari',
              sisaCuti: 'Sisa 5 Hari',
            ),
      days: days,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'location': location,
      'current_month_year': currentMonthYear,
      'current_month': currentMonth,
      'current_year': currentYear,
      'summary': (summary is JadwalSummaryModel)
          ? (summary as JadwalSummaryModel).toJson()
          : {
              'hari_kerja': summary.hariKerja,
              'libur_off': summary.liburOff,
              'kuota_cuti': summary.kuotaCuti,
              'sisa_cuti': summary.sisaCuti,
            },
      'days': days.map((d) {
        if (d is JadwalDayModel) return d.toJson();
        return {
          'date': d.date.toIso8601String(),
          'day_number': d.dayNumber,
          'type': d.type.name,
          'date_formatted': d.dateFormatted,
          'shift_title': d.shiftTitle,
          'shift_code': d.shiftCode,
          'divisi_dapur': d.divisiDapur,
          'jam_shift': d.jamShift,
          'toleransi_telat': d.toleransiTelat,
          'status_jadwal': d.statusJadwal,
        };
      }).toList(),
    };
  }
}
