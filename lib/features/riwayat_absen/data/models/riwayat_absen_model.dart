import '../../domain/entities/riwayat_absen_data.dart';
import '../../domain/entities/riwayat_absen_item.dart';

class RiwayatAbsenItemModel extends RiwayatAbsenItem {
  const RiwayatAbsenItemModel({
    required super.id,
    required super.dateLabel,
    required super.statusType,
    required super.statusBadge,
    super.clockInTime,
    super.clockOutTime,
    super.durationText,
    super.description,
    super.actionBannerText,
    super.actionBannerCta,
    super.canRequestCorrection,
    super.correctionSubmitted,
  });

  factory RiwayatAbsenItemModel.fromJson(Map<String, dynamic> json) {
    return RiwayatAbsenItemModel(
      id: json['id']?.toString() ?? '',
      dateLabel: json['date_label']?.toString() ?? '',
      statusType: _parseStatusType(json['status_type']?.toString()),
      statusBadge: json['status_badge']?.toString() ?? '',
      clockInTime: json['clock_in_time']?.toString(),
      clockOutTime: json['clock_out_time']?.toString(),
      durationText: json['duration_text']?.toString(),
      description: json['description']?.toString(),
      actionBannerText: json['action_banner_text']?.toString(),
      actionBannerCta: json['action_banner_cta']?.toString(),
      canRequestCorrection: json['can_request_correction'] == true,
      correctionSubmitted: json['correction_submitted'] == true,
    );
  }

  static RiwayatStatusType _parseStatusType(String? raw) {
    switch (raw) {
      case 'telat':
        return RiwayatStatusType.telat;
      case 'cuti_disetujui':
        return RiwayatStatusType.cutiDisetujui;
      case 'menunggu_acc':
        return RiwayatStatusType.menungguAcc;
      case 'tepat_waktu':
      default:
        return RiwayatStatusType.tepatWaktu;
    }
  }
}

class RiwayatAbsenDataModel extends RiwayatAbsenData {
  const RiwayatAbsenDataModel({
    required super.month,
    required super.year,
    required super.monthLabel,
    required super.hadirCount,
    required super.telatCount,
    required super.cutiIzinCount,
    required super.menungguCount,
    required super.items,
  });

  factory RiwayatAbsenDataModel.fromJson(Map<String, dynamic> json) {
    final rawItems = json['items'] as List<dynamic>? ?? [];
    return RiwayatAbsenDataModel(
      month: json['month'] as int? ?? 11,
      year: json['year'] as int? ?? 2026,
      monthLabel: json['month_label']?.toString() ?? 'November 2026',
      hadirCount: json['hadir_count'] as int? ?? 0,
      telatCount: json['telat_count'] as int? ?? 0,
      cutiIzinCount: json['cuti_izin_count'] as int? ?? 0,
      menungguCount: json['menunggu_count'] as int? ?? 0,
      items: rawItems
          .map(
            (item) =>
                RiwayatAbsenItemModel.fromJson(item as Map<String, dynamic>),
          )
          .toList(),
    );
  }
}
