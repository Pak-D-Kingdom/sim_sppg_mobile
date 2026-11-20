import 'package:equatable/equatable.dart';

abstract class JadwalEvent extends Equatable {
  const JadwalEvent();

  @override
  List<Object?> get props => [];
}

class LoadJadwalEvent extends JadwalEvent {
  final int? month;
  final int? year;

  const LoadJadwalEvent({this.month, this.year});

  @override
  List<Object?> get props => [month, year];
}

class SelectJadwalDateEvent extends JadwalEvent {
  final DateTime date;

  const SelectJadwalDateEvent(this.date);

  @override
  List<Object?> get props => [date];
}

class ChangeMonthEvent extends JadwalEvent {
  final int offset; // -1 for previous month, +1 for next month

  const ChangeMonthEvent(this.offset);

  @override
  List<Object?> get props => [offset];
}
