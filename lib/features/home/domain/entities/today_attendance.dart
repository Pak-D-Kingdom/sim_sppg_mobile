import 'package:equatable/equatable.dart';

class TodayAttendance extends Equatable {
  final String dateFormatted;
  final String statusText;
  final String shiftLabel;
  final String shiftSchedule;
  final String clockInTime;
  final String clockInStatus;
  final String clockOutTime;
  final String clockOutStatus;
  final bool isClockedOut;

  const TodayAttendance({
    required this.dateFormatted,
    required this.statusText,
    required this.shiftLabel,
    required this.shiftSchedule,
    required this.clockInTime,
    required this.clockInStatus,
    required this.clockOutTime,
    required this.clockOutStatus,
    this.isClockedOut = false,
  });

  TodayAttendance copyWith({
    String? dateFormatted,
    String? statusText,
    String? shiftLabel,
    String? shiftSchedule,
    String? clockInTime,
    String? clockInStatus,
    String? clockOutTime,
    String? clockOutStatus,
    bool? isClockedOut,
  }) {
    return TodayAttendance(
      dateFormatted: dateFormatted ?? this.dateFormatted,
      statusText: statusText ?? this.statusText,
      shiftLabel: shiftLabel ?? this.shiftLabel,
      shiftSchedule: shiftSchedule ?? this.shiftSchedule,
      clockInTime: clockInTime ?? this.clockInTime,
      clockInStatus: clockInStatus ?? this.clockInStatus,
      clockOutTime: clockOutTime ?? this.clockOutTime,
      clockOutStatus: clockOutStatus ?? this.clockOutStatus,
      isClockedOut: isClockedOut ?? this.isClockedOut,
    );
  }

  @override
  List<Object?> get props => [
        dateFormatted,
        statusText,
        shiftLabel,
        shiftSchedule,
        clockInTime,
        clockInStatus,
        clockOutTime,
        clockOutStatus,
        isClockedOut,
      ];
}
