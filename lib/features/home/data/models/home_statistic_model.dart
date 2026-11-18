import '../../domain/entities/home_statistic.dart';

class HomeStatisticModel extends HomeStatistic {
  const HomeStatisticModel({
    required super.id,
    required super.title,
    required super.value,
    super.unit,
    super.footer,
    required super.code,
  });

  factory HomeStatisticModel.fromJson(Map<String, dynamic> json) {
    return HomeStatisticModel(
      id: json['id']?.toString() ?? '',
      title: json['title'] ?? '',
      value: json['value']?.toString() ?? '0',
      unit: json['unit']?.toString(),
      footer: json['footer']?.toString() ?? '',
      code: json['code'] ?? 'leave_balance',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'value': value,
      'unit': unit,
      'footer': footer,
      'code': code,
    };
  }
}
