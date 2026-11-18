import '../../domain/entities/operational_alert.dart';

class OperationalAlertModel extends OperationalAlert {
  const OperationalAlertModel({
    required super.category,
    required super.badgeText,
    required super.title,
    required super.description,
  });

  factory OperationalAlertModel.fromJson(Map<String, dynamic> json) {
    return OperationalAlertModel(
      category: json['category'] ?? 'PERINGATAN\nOPERASIONAL',
      badgeText: json['badgeText'] ?? 'H-3\nPelaksanaan',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'category': category,
      'badgeText': badgeText,
      'title': title,
      'description': description,
    };
  }
}
