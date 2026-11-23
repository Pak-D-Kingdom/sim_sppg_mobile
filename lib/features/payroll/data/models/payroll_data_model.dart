import '../../domain/entities/payroll_data.dart';
import 'payroll_item_model.dart';

class PayrollDataModel extends PayrollData {
  const PayrollDataModel({
    super.title = 'Payroll',
    super.subtitle = 'SPPG Rawamangun 01 • Closing Tgl 25',
    required super.selectedYear,
    super.availableYears = const [2026, 2025, 2024],
    required super.items,
  });

  factory PayrollDataModel.fromJson(Map<String, dynamic> json) {
    final List<PayrollItemModel> items = [];
    if (json['items'] is List) {
      for (final item in json['items']) {
        items.add(PayrollItemModel.fromJson(item as Map<String, dynamic>));
      }
    }

    return PayrollDataModel(
      title: json['title'] ?? 'Payroll',
      subtitle: json['subtitle'] ?? 'SPPG Rawamangun 01 • Closing Tgl 25',
      selectedYear: json['selected_year'] ?? 2026,
      availableYears: (json['available_years'] as List<dynamic>?)
              ?.map((e) => e as int)
              .toList() ??
          const [2026, 2025, 2024],
      items: items,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'subtitle': subtitle,
      'selected_year': selectedYear,
      'available_years': availableYears,
      'items': items.map((e) => (e as PayrollItemModel).toJson()).toList(),
    };
  }
}
