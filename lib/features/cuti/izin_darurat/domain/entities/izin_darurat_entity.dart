import 'package:equatable/equatable.dart';

class IzinDaruratData extends Equatable {
  final DateTime startDate;
  final DateTime endDate;
  final int durationDays;
  final String kategori; // 'Duka Cita', 'Bencana Alam', 'Keluarga Sakit Kritis', 'Lainnya'
  final String alasan;
  final String? attachmentName;
  final bool isSubmitting;
  final String? statusPengajuan; // 'Diteruskan ke KSPPG'

  const IzinDaruratData({
    required this.startDate,
    required this.endDate,
    this.durationDays = 1,
    this.kategori = 'Keluarga Sakit Kritis',
    this.alasan = 'Keluarga inti masuk IGD mendadak.',
    this.attachmentName,
    this.isSubmitting = false,
    this.statusPengajuan,
  });

  IzinDaruratData copyWith({
    DateTime? startDate,
    DateTime? endDate,
    int? durationDays,
    String? kategori,
    String? alasan,
    String? attachmentName,
    bool? isSubmitting,
    String? statusPengajuan,
    bool clearAttachment = false,
  }) {
    return IzinDaruratData(
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      durationDays: durationDays ?? this.durationDays,
      kategori: kategori ?? this.kategori,
      alasan: alasan ?? this.alasan,
      attachmentName:
          clearAttachment ? null : (attachmentName ?? this.attachmentName),
      isSubmitting: isSubmitting ?? this.isSubmitting,
      statusPengajuan: statusPengajuan ?? this.statusPengajuan,
    );
  }

  @override
  List<Object?> get props => [
        startDate,
        endDate,
        durationDays,
        kategori,
        alasan,
        attachmentName,
        isSubmitting,
        statusPengajuan,
      ];
}
