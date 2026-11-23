import 'package:equatable/equatable.dart';
import 'riwayat_absen_item.dart';

class RiwayatAbsenData extends Equatable {
  final int month;
  final int year;
  final String monthLabel;
  final int hadirCount;
  final int telatCount;
  final int cutiIzinCount;
  final int menungguCount;
  final List<RiwayatAbsenItem> items;

  const RiwayatAbsenData({
    required this.month,
    required this.year,
    required this.monthLabel,
    required this.hadirCount,
    required this.telatCount,
    required this.cutiIzinCount,
    required this.menungguCount,
    required this.items,
  });

  RiwayatAbsenData copyWith({
    int? month,
    int? year,
    String? monthLabel,
    int? hadirCount,
    int? telatCount,
    int? cutiIzinCount,
    int? menungguCount,
    List<RiwayatAbsenItem>? items,
  }) {
    return RiwayatAbsenData(
      month: month ?? this.month,
      year: year ?? this.year,
      monthLabel: monthLabel ?? this.monthLabel,
      hadirCount: hadirCount ?? this.hadirCount,
      telatCount: telatCount ?? this.telatCount,
      cutiIzinCount: cutiIzinCount ?? this.cutiIzinCount,
      menungguCount: menungguCount ?? this.menungguCount,
      items: items ?? this.items,
    );
  }

  @override
  List<Object?> get props => [
        month,
        year,
        monthLabel,
        hadirCount,
        telatCount,
        cutiIzinCount,
        menungguCount,
        items,
      ];
}
