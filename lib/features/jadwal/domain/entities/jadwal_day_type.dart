enum JadwalDayType {
  hariKerja,
  libur,
  liburSppg,
  cuti;

  String get displayName {
    switch (this) {
      case JadwalDayType.hariKerja:
        return 'Hari Kerja';
      case JadwalDayType.libur:
        return 'Libur';
      case JadwalDayType.liburSppg:
        return 'Libur SPPG';
      case JadwalDayType.cuti:
        return 'Cuti';
    }
  }

  String get badgeLabel {
    switch (this) {
      case JadwalDayType.hariKerja:
        return 'HARI KERJA';
      case JadwalDayType.libur:
        return 'LIBUR';
      case JadwalDayType.liburSppg:
        return 'LIBUR SPPG';
      case JadwalDayType.cuti:
        return 'CUTI TAHUNAN';
    }
  }
}
