import 'package:equatable/equatable.dart';

class CutiTahunanQuota extends Equatable {
  final int totalQuota;
  final int usedQuota;
  final int remainingQuota;

  const CutiTahunanQuota({
    this.totalQuota = 12,
    this.usedQuota = 7,
    this.remainingQuota = 5,
  });

  String get quotaUsageText => '$usedQuota/$totalQuota Terpakai';
  double get usagePercentage => totalQuota > 0 ? usedQuota / totalQuota : 0.0;

  @override
  List<Object?> get props => [totalQuota, usedQuota, remainingQuota];
}

class CutiTahunanFormData extends Equatable {
  final DateTime startDate;
  final DateTime endDate;
  final int durationDays;
  final int remainingAfter;
  final String reason;
  final String? attachmentName;

  const CutiTahunanFormData({
    required this.startDate,
    required this.endDate,
    this.durationDays = 2,
    this.remainingAfter = 3,
    this.reason = 'Menghadiri acara keluarga di luar kota.',
    this.attachmentName,
  });

  CutiTahunanFormData copyWith({
    DateTime? startDate,
    DateTime? endDate,
    int? durationDays,
    int? remainingAfter,
    String? reason,
    String? attachmentName,
    bool clearAttachment = false,
  }) {
    return CutiTahunanFormData(
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      durationDays: durationDays ?? this.durationDays,
      remainingAfter: remainingAfter ?? this.remainingAfter,
      reason: reason ?? this.reason,
      attachmentName:
          clearAttachment ? null : (attachmentName ?? this.attachmentName),
    );
  }

  @override
  List<Object?> get props => [
        startDate,
        endDate,
        durationDays,
        remainingAfter,
        reason,
        attachmentName,
      ];
}
