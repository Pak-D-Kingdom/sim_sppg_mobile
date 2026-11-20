import 'package:equatable/equatable.dart';
import 'jadwal_day_type.dart';

class JadwalDay extends Equatable {
  final DateTime date;
  final int dayNumber;
  final JadwalDayType type;
  final String dateFormatted;
  final String shiftTitle;
  final String shiftCode;
  final String divisiDapur;
  final String jamShift;
  final String toleransiTelat;
  final String statusJadwal;

  const JadwalDay({
    required this.date,
    required this.dayNumber,
    required this.type,
    required this.dateFormatted,
    required this.shiftTitle,
    required this.shiftCode,
    required this.divisiDapur,
    required this.jamShift,
    required this.toleransiTelat,
    required this.statusJadwal,
  });

  String get formattedDisplayDate {
    if (dateFormatted.isNotEmpty) return dateFormatted;
    const dayNames = [
      'Minggu',
      'Senin',
      'Selasa',
      'Rabu',
      'Kamis',
      'Jumat',
      'Sabtu',
    ];
    const monthNames = [
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
    final w = date.weekday % 7;
    final m = (date.month >= 1 && date.month <= 12) ? date.month - 1 : 0;
    return '${dayNames[w]}, ${date.day} ${monthNames[m]} ${date.year}';
  }

  @override
  List<Object?> get props => [
        date,
        dayNumber,
        type,
        dateFormatted,
        shiftTitle,
        shiftCode,
        divisiDapur,
        jamShift,
        toleransiTelat,
        statusJadwal,
      ];
}
