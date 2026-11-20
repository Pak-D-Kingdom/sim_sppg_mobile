import 'package:equatable/equatable.dart';
import 'jadwal_day.dart';
import 'jadwal_summary.dart';

class JadwalData extends Equatable {
  final String title;
  final String location;
  final String currentMonthYear;
  final int currentMonth;
  final int currentYear;
  final JadwalSummary summary;
  final List<JadwalDay> days;

  const JadwalData({
    required this.title,
    required this.location,
    required this.currentMonthYear,
    required this.currentMonth,
    required this.currentYear,
    required this.summary,
    required this.days,
  });

  @override
  List<Object?> get props => [
        title,
        location,
        currentMonthYear,
        currentMonth,
        currentYear,
        summary,
        days,
      ];
}
