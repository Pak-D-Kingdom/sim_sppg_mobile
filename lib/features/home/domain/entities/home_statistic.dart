import 'package:equatable/equatable.dart';

class HomeStatistic extends Equatable {
  final String id;
  final String title;
  final String value;
  final String? unit;
  final String footer;
  final String code; // 'leave_balance', 'attendance', 'penalty'

  const HomeStatistic({
    required this.id,
    required this.title,
    required this.value,
    this.unit,
    this.footer = '',
    required this.code,
  });

  @override
  List<Object?> get props => [id, title, value, unit, footer, code];
}
