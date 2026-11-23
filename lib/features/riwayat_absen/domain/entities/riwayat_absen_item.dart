import 'package:equatable/equatable.dart';

enum RiwayatStatusType {
  tepatWaktu,
  telat,
  cutiDisetujui,
  menungguAcc,
}

enum RiwayatFilterType {
  semua,
  hadir,
  telat,
  cutiIzin;

  String get label {
    switch (this) {
      case RiwayatFilterType.semua:
        return 'Semua';
      case RiwayatFilterType.hadir:
        return 'Hadir';
      case RiwayatFilterType.telat:
        return 'Telat';
      case RiwayatFilterType.cutiIzin:
        return 'Cuti & Izin';
    }
  }
}

class RiwayatAbsenItem extends Equatable {
  final String id;
  final String dateLabel;
  final RiwayatStatusType statusType;
  final String statusBadge;
  final String? clockInTime;
  final String? clockOutTime;
  final String? durationText;
  final String? description;
  final String? actionBannerText;
  final String? actionBannerCta;
  final bool canRequestCorrection;
  final bool correctionSubmitted;

  const RiwayatAbsenItem({
    required this.id,
    required this.dateLabel,
    required this.statusType,
    required this.statusBadge,
    this.clockInTime,
    this.clockOutTime,
    this.durationText,
    this.description,
    this.actionBannerText,
    this.actionBannerCta,
    this.canRequestCorrection = false,
    this.correctionSubmitted = false,
  });

  RiwayatAbsenItem copyWith({
    String? id,
    String? dateLabel,
    RiwayatStatusType? statusType,
    String? statusBadge,
    String? clockInTime,
    String? clockOutTime,
    String? durationText,
    String? description,
    String? actionBannerText,
    String? actionBannerCta,
    bool? canRequestCorrection,
    bool? correctionSubmitted,
  }) {
    return RiwayatAbsenItem(
      id: id ?? this.id,
      dateLabel: dateLabel ?? this.dateLabel,
      statusType: statusType ?? this.statusType,
      statusBadge: statusBadge ?? this.statusBadge,
      clockInTime: clockInTime ?? this.clockInTime,
      clockOutTime: clockOutTime ?? this.clockOutTime,
      durationText: durationText ?? this.durationText,
      description: description ?? this.description,
      actionBannerText: actionBannerText ?? this.actionBannerText,
      actionBannerCta: actionBannerCta ?? this.actionBannerCta,
      canRequestCorrection: canRequestCorrection ?? this.canRequestCorrection,
      correctionSubmitted: correctionSubmitted ?? this.correctionSubmitted,
    );
  }

  bool matchesFilter(RiwayatFilterType filter) {
    switch (filter) {
      case RiwayatFilterType.semua:
        return true;
      case RiwayatFilterType.hadir:
        return statusType == RiwayatStatusType.tepatWaktu;
      case RiwayatFilterType.telat:
        return statusType == RiwayatStatusType.telat;
      case RiwayatFilterType.cutiIzin:
        return statusType == RiwayatStatusType.cutiDisetujui ||
            statusType == RiwayatStatusType.menungguAcc;
    }
  }

  @override
  List<Object?> get props => [
        id,
        dateLabel,
        statusType,
        statusBadge,
        clockInTime,
        clockOutTime,
        durationText,
        description,
        actionBannerText,
        actionBannerCta,
        canRequestCorrection,
        correctionSubmitted,
      ];
}
