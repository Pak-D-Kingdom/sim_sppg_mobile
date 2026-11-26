import 'package:equatable/equatable.dart';

enum IzinDaruratJenis {
  tidakMasuk('Tidak Masuk (Full)'),
  terlambat('Izin Terlambat');

  final String label;
  const IzinDaruratJenis(this.label);
}

class IzinDaruratData extends Equatable {
  final IzinDaruratJenis jenis;
  final DateTime startDate;
  final DateTime endDate;
  final int durationDays;
  final String jamTiba; // e.g. '06:15 WIB'
  final String jadwalMasuk; // e.g. '05:00 WIB'
  final int menitTerlambat; // e.g. 75
  final int kuotaCuti; // e.g. 5
  final String kategori; // 'Keluarga Rawat Darurat', 'Kendaraan Mogok', dll.
  final String alasan;
  final String? attachmentName;
  final bool isSubmitting;
  final String? statusPengajuan; // 'Diteruskan ke Koordinator Unit SPPG Rawamangun 01'

  const IzinDaruratData({
    this.jenis = IzinDaruratJenis.tidakMasuk,
    required this.startDate,
    required this.endDate,
    this.durationDays = 1,
    this.jamTiba = '06:15 WIB',
    this.jadwalMasuk = '05:00 WIB',
    this.menitTerlambat = 75,
    this.kuotaCuti = 5,
    this.kategori = 'Keluarga Rawat Darurat',
    this.alasan = 'Anggota keluarga inti masuk IGD RSUD pagi ini.',
    this.attachmentName,
    this.isSubmitting = false,
    this.statusPengajuan,
  });

  IzinDaruratData copyWith({
    IzinDaruratJenis? jenis,
    DateTime? startDate,
    DateTime? endDate,
    int? durationDays,
    String? jamTiba,
    String? jadwalMasuk,
    int? menitTerlambat,
    int? kuotaCuti,
    String? kategori,
    String? alasan,
    String? attachmentName,
    bool? isSubmitting,
    String? statusPengajuan,
    bool clearAttachment = false,
  }) {
    return IzinDaruratData(
      jenis: jenis ?? this.jenis,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      durationDays: durationDays ?? this.durationDays,
      jamTiba: jamTiba ?? this.jamTiba,
      jadwalMasuk: jadwalMasuk ?? this.jadwalMasuk,
      menitTerlambat: menitTerlambat ?? this.menitTerlambat,
      kuotaCuti: kuotaCuti ?? this.kuotaCuti,
      kategori: kategori ?? this.kategori,
      alasan: alasan ?? this.alasan,
      attachmentName:
          clearAttachment ? null : (attachmentName ?? this.attachmentName),
      isSubmitting: isSubmitting ?? this.isSubmitting,
      statusPengajuan: statusPengajuan ?? this.statusPengajuan,
    );
  }

  @override
  List<Object?> get props => [
        jenis,
        startDate,
        endDate,
        durationDays,
        jamTiba,
        jadwalMasuk,
        menitTerlambat,
        kuotaCuti,
        kategori,
        alasan,
        attachmentName,
        isSubmitting,
        statusPengajuan,
      ];
}
