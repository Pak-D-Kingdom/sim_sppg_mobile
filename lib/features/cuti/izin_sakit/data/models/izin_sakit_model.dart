import '../../domain/entities/izin_sakit_entity.dart';

class IzinSakitModel extends IzinSakitData {
  const IzinSakitModel({
    super.tahap = IzinSakitTahap.tahap1Form,
    required super.startDate,
    required super.endDate,
    super.durationDays = 1,
    super.keluhan = 'Demam tinggi dan pusing sejak subuh.',
    super.statusLaporan = 'Diterima KSPPG',
    super.deadlineUnggah,
    super.remainingTimeText = 'Sisa 47j 58m',
    super.attachmentName,
    super.isSubmitting = false,
  });

  factory IzinSakitModel.fromJson(Map<String, dynamic> json) {
    IzinSakitTahap tahap;
    switch (json['tahap'] as String?) {
      case 'tahap2':
        tahap = IzinSakitTahap.tahap2Unggah;
        break;
      case 'selesai':
        tahap = IzinSakitTahap.selesai;
        break;
      case 'tahap1':
      default:
        tahap = IzinSakitTahap.tahap1Form;
    }

    final start = json['start_date'] != null
        ? DateTime.parse(json['start_date'] as String)
        : DateTime(2026, 11, 20);
    final end = json['end_date'] != null
        ? DateTime.parse(json['end_date'] as String)
        : DateTime(2026, 11, 20);

    return IzinSakitModel(
      tahap: tahap,
      startDate: start,
      endDate: end,
      durationDays: json['duration_days'] as int? ?? 1,
      keluhan: json['keluhan'] as String? ?? 'Demam tinggi dan pusing sejak subuh.',
      statusLaporan: json['status_laporan'] as String? ?? 'Diterima KSPPG',
      deadlineUnggah: json['deadline_unggah'] != null
          ? DateTime.parse(json['deadline_unggah'] as String)
          : DateTime(2026, 11, 22, 4, 52),
      remainingTimeText: json['remaining_time_text'] as String? ?? 'Sisa 47j 58m',
      attachmentName: json['attachment_name'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'tahap': tahap.name,
      'start_date': startDate.toIso8601String(),
      'end_date': endDate.toIso8601String(),
      'duration_days': durationDays,
      'keluhan': keluhan,
      'status_laporan': statusLaporan,
      'deadline_unggah': deadlineUnggah?.toIso8601String(),
      'remaining_time_text': remainingTimeText,
      'attachment_name': attachmentName,
    };
  }
}
