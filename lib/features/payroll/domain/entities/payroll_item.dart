import 'package:equatable/equatable.dart';

class PayrollDetail extends Equatable {
  final String kehadiranValue;
  final String kehadiranSubtitle;
  final String cutiValue;
  final String cutiSubtitle;
  final String dendaValue;
  final String dendaSubtitle;
  final String rincianBannerSubtitle;

  const PayrollDetail({
    required this.kehadiranValue,
    required this.kehadiranSubtitle,
    required this.cutiValue,
    required this.cutiSubtitle,
    required this.dendaValue,
    required this.dendaSubtitle,
    required this.rincianBannerSubtitle,
  });

  @override
  List<Object?> get props => [
        kehadiranValue,
        kehadiranSubtitle,
        cutiValue,
        cutiSubtitle,
        dendaValue,
        dendaSubtitle,
        rincianBannerSubtitle,
      ];
}

class PayrollItem extends Equatable {
  final String id;
  final String monthYear;
  final bool isLatest;
  final String summaryText;
  final String amount;
  final String status;
  final PayrollDetail detail;

  const PayrollItem({
    required this.id,
    required this.monthYear,
    this.isLatest = false,
    required this.summaryText,
    required this.amount,
    this.status = 'Terbayar',
    required this.detail,
  });

  @override
  List<Object?> get props => [
        id,
        monthYear,
        isLatest,
        summaryText,
        amount,
        status,
        detail,
      ];
}
