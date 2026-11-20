import 'package:equatable/equatable.dart';

class CutiQuota extends Equatable {
  final int totalQuota;
  final int usedQuota;
  final int remainingQuota;
  final int year;

  const CutiQuota({
    this.totalQuota = 12,
    this.usedQuota = 7,
    this.remainingQuota = 5,
    this.year = 2026,
  });

  String get quotaUsageText => '$usedQuota/$totalQuota Terpakai';
  double get usagePercentage => totalQuota > 0 ? usedQuota / totalQuota : 0.0;

  @override
  List<Object?> get props => [totalQuota, usedQuota, remainingQuota, year];
}
