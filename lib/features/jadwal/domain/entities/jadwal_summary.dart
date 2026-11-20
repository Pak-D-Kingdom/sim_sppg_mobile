import 'package:equatable/equatable.dart';

class JadwalSummary extends Equatable {
  final int hariKerja;
  final int liburOff;
  final String kuotaCuti;
  final String sisaCuti;

  const JadwalSummary({
    required this.hariKerja,
    required this.liburOff,
    required this.kuotaCuti,
    required this.sisaCuti,
  });

  @override
  List<Object?> get props => [hariKerja, liburOff, kuotaCuti, sisaCuti];
}
