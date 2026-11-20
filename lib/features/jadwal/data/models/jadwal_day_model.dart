import '../../domain/entities/jadwal_day.dart';
import '../../domain/entities/jadwal_day_type.dart';

class JadwalDayModel extends JadwalDay {
  const JadwalDayModel({
    required super.date,
    required super.dayNumber,
    required super.type,
    required super.dateFormatted,
    required super.shiftTitle,
    required super.shiftCode,
    required super.divisiDapur,
    required super.jamShift,
    required super.toleransiTelat,
    required super.statusJadwal,
  });

  factory JadwalDayModel.fromJson(Map<String, dynamic> json) {
    JadwalDayType type;
    final typeStr = json['type'] as String? ?? 'hariKerja';
    switch (typeStr) {
      case 'libur':
        type = JadwalDayType.libur;
        break;
      case 'liburSppg':
        type = JadwalDayType.liburSppg;
        break;
      case 'cuti':
        type = JadwalDayType.cuti;
        break;
      case 'hariKerja':
      default:
        type = JadwalDayType.hariKerja;
    }

    final dateStr = json['date'] as String?;
    final date = dateStr != null ? DateTime.parse(dateStr) : DateTime.now();

    return JadwalDayModel(
      date: date,
      dayNumber: json['day_number'] as int? ?? date.day,
      type: type,
      dateFormatted: json['date_formatted'] as String? ?? '',
      shiftTitle: json['shift_title'] as String? ?? '',
      shiftCode: json['shift_code'] as String? ?? '',
      divisiDapur: json['divisi_dapur'] as String? ?? '',
      jamShift: json['jam_shift'] as String? ?? '',
      toleransiTelat: json['toleransi_telat'] as String? ?? '',
      statusJadwal: json['status_jadwal'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date.toIso8601String(),
      'day_number': dayNumber,
      'type': type.name,
      'date_formatted': dateFormatted,
      'shift_title': shiftTitle,
      'shift_code': shiftCode,
      'divisi_dapur': divisiDapur,
      'jam_shift': jamShift,
      'toleransi_telat': toleransiTelat,
      'status_jadwal': statusJadwal,
    };
  }
}
