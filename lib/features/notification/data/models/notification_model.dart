import '../../domain/entities/app_notification.dart';

class NotificationModel extends AppNotification {
  const NotificationModel({
    required super.id,
    required super.category,
    required super.type,
    required super.title,
    required super.description,
    required super.timestamp,
    required super.isRead,
    super.section = 'HARI INI',
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'] as String? ?? '',
      category: json['category'] as String? ?? 'INFORMASI',
      type: json['type'] as String? ?? 'operasional',
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      timestamp: json['timestamp'] as String? ?? '',
      isRead: json['is_read'] as bool? ?? false,
      section: json['section'] as String? ?? 'HARI INI',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'category': category,
      'type': type,
      'title': title,
      'description': description,
      'timestamp': timestamp,
      'is_read': isRead,
      'section': section,
    };
  }

  @override
  NotificationModel copyWith({
    String? id,
    String? category,
    String? type,
    String? title,
    String? description,
    String? timestamp,
    bool? isRead,
    String? section,
  }) {
    return NotificationModel(
      id: id ?? this.id,
      category: category ?? this.category,
      type: type ?? this.type,
      title: title ?? this.title,
      description: description ?? this.description,
      timestamp: timestamp ?? this.timestamp,
      isRead: isRead ?? this.isRead,
      section: section ?? this.section,
    );
  }
}
