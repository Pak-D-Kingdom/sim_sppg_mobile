import 'package:equatable/equatable.dart';

class AppNotification extends Equatable {
  final String id;
  final String category; // 'PERINGATAN OPERASIONAL', 'PENGAJUAN CUTI', 'PRESENSI HARIAN'
  final String type; // 'operasional', 'persetujuan'
  final String title;
  final String description;
  final String timestamp; // '20 Nov 2026 • 08:00 WIB'
  final bool isRead;
  final String section; // 'HARI INI'

  const AppNotification({
    required this.id,
    required this.category,
    required this.type,
    required this.title,
    required this.description,
    required this.timestamp,
    required this.isRead,
    this.section = 'HARI INI',
  });

  AppNotification copyWith({
    String? id,
    String? category,
    String? type,
    String? title,
    String? description,
    String? timestamp,
    bool? isRead,
    String? section,
  }) {
    return AppNotification(
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

  @override
  List<Object?> get props => [
        id,
        category,
        type,
        title,
        description,
        timestamp,
        isRead,
        section,
      ];
}
