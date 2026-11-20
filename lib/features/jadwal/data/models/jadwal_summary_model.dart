import '../../domain/entities/jadwal_summary.dart';

class JadwalSummaryModel extends JadwalSummary {
  const JadwalSummaryModel({
    required super.hariKerja,
    required super.liburOff,
    required super.kuotaCuti,
    required super.sisaCuti,
  });

  factory JadwalSummaryModel.fromJson(Map<String, dynamic> json) {
    return JadwalSummaryModel(
      hariKerja: json['hari_kerja'] as int? ?? 22,
      liburOff: json['libur_off'] as int? ?? 6,
      kuotaCuti: json['kuota_cuti'] as String? ?? '7/12 Hari',
      sisaCuti: json['sisa_cuti'] as String? ?? 'Sisa 5 Hari',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'hari_kerja': hariKerja,
      'libur_off': liburOff,
      'kuota_cuti': kuotaCuti,
      'sisa_cuti': sisaCuti,
    };
  }
}
