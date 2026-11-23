import 'package:equatable/equatable.dart';
import 'payroll_item.dart';

class PayrollData extends Equatable {
  final String title;
  final String subtitle;
  final int selectedYear;
  final List<int> availableYears;
  final List<PayrollItem> items;

  const PayrollData({
    this.title = 'Payroll',
    this.subtitle = 'SPPG Rawamangun 01 • Closing Tgl 25',
    required this.selectedYear,
    this.availableYears = const [2026, 2025, 2024],
    required this.items,
  });

  @override
  List<Object?> get props => [
        title,
        subtitle,
        selectedYear,
        availableYears,
        items,
      ];
}
