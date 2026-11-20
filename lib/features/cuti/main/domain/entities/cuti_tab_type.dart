enum CutiTabType {
  cutiTahunan,
  izinSakit,
  izinDarurat;

  String get label {
    switch (this) {
      case CutiTabType.cutiTahunan:
        return 'Cuti Tahunan';
      case CutiTabType.izinSakit:
        return 'Izin Sakit';
      case CutiTabType.izinDarurat:
        return 'Izin Darurat';
    }
  }
}
