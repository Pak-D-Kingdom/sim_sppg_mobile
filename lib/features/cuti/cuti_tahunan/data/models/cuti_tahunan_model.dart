import '../../domain/entities/cuti_tahunan_entity.dart';

class CutiTahunanQuotaModel extends CutiTahunanQuota {
  const CutiTahunanQuotaModel({
    super.totalQuota = 12,
    super.usedQuota = 7,
    super.remainingQuota = 5,
  });

  factory CutiTahunanQuotaModel.fromJson(Map<String, dynamic> json) {
    return CutiTahunanQuotaModel(
      totalQuota: json['total_quota'] as int? ?? 12,
      usedQuota: json['used_quota'] as int? ?? 7,
      remainingQuota: json['remaining_quota'] as int? ?? 5,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'total_quota': totalQuota,
      'used_quota': usedQuota,
      'remaining_quota': remainingQuota,
    };
  }
}
