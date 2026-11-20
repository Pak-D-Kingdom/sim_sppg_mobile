import 'package:equatable/equatable.dart';

enum IzinSakitTahap {
  tahap1Form,     // Gambar 1: Input laporan sakit awal
  tahap2Unggah,   // Gambar 2: Menunggu & unggah bukti sakit
  selesai,        // Selesai diunggah & disetujui
}

class IzinSakitData extends Equatable {
  final IzinSakitTahap tahap;
  final DateTime startDate;
  final DateTime endDate;
  final int durationDays;
  final String keluhan;
  final String statusLaporan; // e.g. 'Diterima KSPPG'
  final DateTime? deadlineUnggah;
  final String remainingTimeText; // e.g. 'Sisa 47j 58m'
  final String? attachmentName;
  final bool isSubmitting;

  const IzinSakitData({
    this.tahap = IzinSakitTahap.tahap1Form,
    required this.startDate,
    required this.endDate,
    this.durationDays = 1,
    this.keluhan = 'Demam tinggi dan pusing sejak subuh.',
    this.statusLaporan = 'Diterima KSPPG',
    this.deadlineUnggah,
    this.remainingTimeText = 'Sisa 47j 58m',
    this.attachmentName,
    this.isSubmitting = false,
  });

  IzinSakitData copyWith({
    IzinSakitTahap? tahap,
    DateTime? startDate,
    DateTime? endDate,
    int? durationDays,
    String? keluhan,
    String? statusLaporan,
    DateTime? deadlineUnggah,
    String? remainingTimeText,
    String? attachmentName,
    bool? isSubmitting,
    bool clearAttachment = false,
  }) {
    return IzinSakitData(
      tahap: tahap ?? this.tahap,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      durationDays: durationDays ?? this.durationDays,
      keluhan: keluhan ?? this.keluhan,
      statusLaporan: statusLaporan ?? this.statusLaporan,
      deadlineUnggah: deadlineUnggah ?? this.deadlineUnggah,
      remainingTimeText: remainingTimeText ?? this.remainingTimeText,
      attachmentName:
          clearAttachment ? null : (attachmentName ?? this.attachmentName),
      isSubmitting: isSubmitting ?? this.isSubmitting,
    );
  }

  @override
  List<Object?> get props => [
        tahap,
        startDate,
        endDate,
        durationDays,
        keluhan,
        statusLaporan,
        deadlineUnggah,
        remainingTimeText,
        attachmentName,
        isSubmitting,
      ];
}
