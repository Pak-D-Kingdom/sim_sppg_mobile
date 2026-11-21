import 'package:equatable/equatable.dart';
import '../../domain/entities/jadwal_data.dart';
import '../../domain/entities/jadwal_day.dart';

abstract class JadwalState extends Equatable {
  const JadwalState();

  @override
  List<Object?> get props => [];
}

class JadwalInitial extends JadwalState {
  const JadwalInitial();
}

class JadwalLoading extends JadwalState {
  const JadwalLoading();
}

class JadwalLoaded extends JadwalState {
  final JadwalData data;
  final DateTime selectedDate;
  final JadwalDay selectedDay;
  final bool isCalendarLoading;

  const JadwalLoaded({
    required this.data,
    required this.selectedDate,
    required this.selectedDay,
    this.isCalendarLoading = false,
  });

  JadwalLoaded copyWith({
    JadwalData? data,
    DateTime? selectedDate,
    JadwalDay? selectedDay,
    bool? isCalendarLoading,
  }) {
    return JadwalLoaded(
      data: data ?? this.data,
      selectedDate: selectedDate ?? this.selectedDate,
      selectedDay: selectedDay ?? this.selectedDay,
      isCalendarLoading: isCalendarLoading ?? this.isCalendarLoading,
    );
  }

  @override
  List<Object?> get props => [data, selectedDate, selectedDay, isCalendarLoading];
}

class JadwalError extends JadwalState {
  final String message;

  const JadwalError({required this.message});

  @override
  List<Object?> get props => [message];
}
