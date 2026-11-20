import '../../domain/entities/cuti_quota.dart';

class CutiQuotaModel extends CutiQuota {
  const CutiQuotaModel({
    super.totalQuota = 12,
    super.usedQuota = 7,
    super.remainingQuota = 5,
    super.year = 2026,
  });

  factory CutiQuotaModel.fromJson(Map<String, dynamic> json) {
    return CutiQuotaModel(
      totalQuota: json['total_quota'] as int? ?? 12,
      usedQuota: json['used_quota'] as int? ?? 7,
      remainingQuota: json['remaining_quota'] as int? ?? 5,
      year: json['year'] as int? ?? 2026,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'total_quota': totalQuota,
      'used_quota': usedQuota,
      'remaining_quota': remainingQuota,
      'year': year,
    };
  }
}
