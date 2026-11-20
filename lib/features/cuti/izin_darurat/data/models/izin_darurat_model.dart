import '../../domain/entities/izin_darurat_entity.dart';

class IzinDaruratModel extends IzinDaruratData {
  const IzinDaruratModel({
    required super.startDate,
    required super.endDate,
    super.durationDays = 1,
    super.kategori = 'Keluarga Sakit Kritis',
    super.alasan = 'Keluarga inti masuk IGD mendadak.',
    super.attachmentName,
    super.isSubmitting = false,
    super.statusPengajuan,
  });

  factory IzinDaruratModel.fromJson(Map<String, dynamic> json) {
    return IzinDaruratModel(
      startDate: DateTime.parse(json['start_date']),
      endDate: DateTime.parse(json['end_date']),
      durationDays: json['duration_days'] ?? 1,
      kategori: json['kategori'] ?? 'Keluarga Sakit Kritis',
      alasan: json['alasan'] ?? '',
      attachmentName: json['attachment_name'],
      statusPengajuan: json['status_pengajuan'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'start_date': startDate.toIso8601String(),
      'end_date': endDate.toIso8601String(),
      'duration_days': durationDays,
      'kategori': kategori,
      'alasan': alasan,
      if (attachmentName != null) 'attachment_name': attachmentName,
      if (statusPengajuan != null) 'status_pengajuan': statusPengajuan,
    };
  }
}
