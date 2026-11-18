import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => [];
}

class LoadHomeDashboardEvent extends HomeEvent {
  const LoadHomeDashboardEvent();
}

class RefreshHomeDashboardEvent extends HomeEvent {
  const RefreshHomeDashboardEvent();
}

class ClockOutAttendanceEvent extends HomeEvent {
  final String clockOutTime;

  const ClockOutAttendanceEvent({required this.clockOutTime});

  @override
  List<Object?> get props => [clockOutTime];
}
