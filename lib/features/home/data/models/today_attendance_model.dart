import '../../domain/entities/today_attendance.dart';

class TodayAttendanceModel extends TodayAttendance {
  const TodayAttendanceModel({
    required super.dateFormatted,
    required super.statusText,
    required super.shiftLabel,
    required super.shiftSchedule,
    required super.clockInTime,
    required super.clockInStatus,
    required super.clockOutTime,
    required super.clockOutStatus,
    super.isClockedOut,
  });

  factory TodayAttendanceModel.fromJson(Map<String, dynamic> json) {
    return TodayAttendanceModel(
      dateFormatted: json['dateFormatted'] ?? '',
      statusText: json['statusText'] ?? 'Sedang\nBertugas',
      shiftLabel: json['shiftLabel'] ?? 'Jadwal Shift',
      shiftSchedule: json['shiftSchedule'] ?? '',
      clockInTime: json['clockInTime'] ?? '-- : --',
      clockInStatus: json['clockInStatus'] ?? '',
      clockOutTime: json['clockOutTime'] ?? '-- : --',
      clockOutStatus: json['clockOutStatus'] ?? '',
      isClockedOut: json['isClockedOut'] == true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'dateFormatted': dateFormatted,
      'statusText': statusText,
      'shiftLabel': shiftLabel,
      'shiftSchedule': shiftSchedule,
      'clockInTime': clockInTime,
      'clockInStatus': clockInStatus,
      'clockOutTime': clockOutTime,
      'clockOutStatus': clockOutStatus,
      'isClockedOut': isClockedOut,
    };
  }
}
