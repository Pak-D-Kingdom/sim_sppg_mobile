import '../../domain/entities/izin_darurat_entity.dart';

class IzinDaruratModel extends IzinDaruratData {
  const IzinDaruratModel({
    super.jenis = IzinDaruratJenis.tidakMasuk,
    required super.startDate,
    required super.endDate,
    super.durationDays = 1,
    super.jamTiba = '06:15 WIB',
    super.jadwalMasuk = '05:00 WIB',
    super.menitTerlambat = 75,
    super.kuotaCuti = 5,
    super.kategori = 'Keluarga Rawat Darurat',
    super.alasan = 'Anggota keluarga inti masuk IGD RSUD pagi ini.',
    super.attachmentName,
    super.isSubmitting = false,
    super.statusPengajuan,
  });

  factory IzinDaruratModel.fromJson(Map<String, dynamic> json) {
    return IzinDaruratModel(
      jenis: json['jenis'] == 'terlambat'
          ? IzinDaruratJenis.terlambat
          : IzinDaruratJenis.tidakMasuk,
      startDate: DateTime.parse(json['start_date']),
      endDate: DateTime.parse(json['end_date']),
      durationDays: json['duration_days'] ?? 1,
      jamTiba: json['jam_tiba'] ?? '06:15 WIB',
      jadwalMasuk: json['jadwal_masuk'] ?? '05:00 WIB',
      menitTerlambat: json['menit_terlambat'] ?? 75,
      kuotaCuti: json['kuota_cuti'] ?? 5,
      kategori: json['kategori'] ?? 'Keluarga Rawat Darurat',
      alasan: json['alasan'] ?? '',
      attachmentName: json['attachment_name'],
      statusPengajuan: json['status_pengajuan'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'jenis': jenis == IzinDaruratJenis.terlambat ? 'terlambat' : 'tidak_masuk',
      'start_date': startDate.toIso8601String(),
      'end_date': endDate.toIso8601String(),
      'duration_days': durationDays,
      'jam_tiba': jamTiba,
      'jadwal_masuk': jadwalMasuk,
      'menit_terlambat': menitTerlambat,
      'kuota_cuti': kuotaCuti,
      'kategori': kategori,
      'alasan': alasan,
      if (attachmentName != null) 'attachment_name': attachmentName,
      if (statusPengajuan != null) 'status_pengajuan': statusPengajuan,
    };
  }
}
