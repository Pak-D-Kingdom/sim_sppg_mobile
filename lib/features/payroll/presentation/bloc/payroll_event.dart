import 'package:equatable/equatable.dart';

abstract class PayrollEvent extends Equatable {
  const PayrollEvent();

  @override
  List<Object?> get props => [];
}

class LoadPayrollEvent extends PayrollEvent {
  final int? year;

  const LoadPayrollEvent({this.year});

  @override
  List<Object?> get props => [year];
}

class ChangePayrollYearEvent extends PayrollEvent {
  final int year;

  const ChangePayrollYearEvent(this.year);

  @override
  List<Object?> get props => [year];
}

class TogglePayrollItemExpandEvent extends PayrollEvent {
  final String itemId;

  const TogglePayrollItemExpandEvent(this.itemId);

  @override
  List<Object?> get props => [itemId];
}
