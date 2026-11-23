import '../../domain/entities/payroll_item.dart';

class PayrollDetailModel extends PayrollDetail {
  const PayrollDetailModel({
    required super.kehadiranValue,
    required super.kehadiranSubtitle,
    required super.cutiValue,
    required super.cutiSubtitle,
    required super.dendaValue,
    required super.dendaSubtitle,
    required super.rincianBannerSubtitle,
  });

  factory PayrollDetailModel.fromJson(Map<String, dynamic> json) {
    return PayrollDetailModel(
      kehadiranValue: json['kehadiran_value'] ?? '20/20 Hari',
      kehadiranSubtitle: json['kehadiran_subtitle'] ?? 'Tepat Waktu',
      cutiValue: json['cuti_value'] ?? '0 Hari',
      cutiSubtitle: json['cuti_subtitle'] ?? '–',
      dendaValue: json['denda_value'] ?? 'Rp 0',
      dendaSubtitle: json['denda_subtitle'] ?? 'Tanpa Denda',
      rincianBannerSubtitle:
          json['rincian_banner_subtitle'] ?? 'Log telat & Insentif',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'kehadiran_value': kehadiranValue,
      'kehadiran_subtitle': kehadiranSubtitle,
      'cuti_value': cutiValue,
      'cuti_subtitle': cutiSubtitle,
      'denda_value': dendaValue,
      'denda_subtitle': dendaSubtitle,
      'rincian_banner_subtitle': rincianBannerSubtitle,
    };
  }
}

class PayrollItemModel extends PayrollItem {
  const PayrollItemModel({
    required super.id,
    required super.monthYear,
    super.isLatest = false,
    required super.summaryText,
    required super.amount,
    super.status = 'Terbayar',
    required super.detail,
  });

  factory PayrollItemModel.fromJson(Map<String, dynamic> json) {
    return PayrollItemModel(
      id: json['id'] ?? '',
      monthYear: json['month_year'] ?? '',
      isLatest: json['is_latest'] ?? false,
      summaryText: json['summary_text'] ?? '',
      amount: json['amount'] ?? '',
      status: json['status'] ?? 'Terbayar',
      detail: PayrollDetailModel.fromJson(
        json['detail'] as Map<String, dynamic>? ?? {},
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'month_year': monthYear,
      'is_latest': isLatest,
      'summary_text': summaryText,
      'amount': amount,
      'status': status,
      'detail': (detail as PayrollDetailModel).toJson(),
    };
  }
}
