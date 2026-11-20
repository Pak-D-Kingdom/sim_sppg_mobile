enum CutiType {
  cutiTahunan,
  izinSakit,
  izinDarurat;

  String get displayName {
    switch (this) {
      case CutiType.cutiTahunan:
        return 'Cuti Tahunan';
      case CutiType.izinSakit:
        return 'Izin Sakit';
      case CutiType.izinDarurat:
        return 'Izin Darurat';
    }
  }

  String get quotaTitle {
    switch (this) {
      case CutiType.cutiTahunan:
        return 'Kuota Cuti Tahunan 2026';
      case CutiType.izinSakit:
        return 'Status Izin Sakit & Kesehatan';
      case CutiType.izinDarurat:
        return 'Status Izin Darurat & Khusus';
    }
  }

  String get infoNote {
    switch (this) {
      case CutiType.cutiTahunan:
        return 'Cuti tahunan diajukan min. H-2. Izin sakit/darurat dapat diajukan hari-H tanpa memotong kuota.';
      case CutiType.izinSakit:
        return 'Izin sakit diajukan hari-H tanpa memotong kuota cuti. Wajib melampirkan Surat Keterangan Dokter (SKD) maks. 2x24 jam.';
      case CutiType.izinDarurat:
        return 'Izin darurat (duka cita, keluarga kritis, bencana) diajukan langsung hari-H dan tidak mengurangi saldo cuti tahunan.';
    }
  }

  String get attachmentHint {
    switch (this) {
      case CutiType.cutiTahunan:
        return 'Opsional untuk cuti • Wajib menyusul maks. 2x24 jam untuk Izin Sakit (JPG, PNG, PDF • Maks. 2MB)';
      case CutiType.izinSakit:
        return 'Surat Keterangan Dokter (SKD) • Wajib menyusul maks. 2x24 jam (JPG, PNG, PDF • Maks. 2MB)';
      case CutiType.izinDarurat:
        return 'Lampiran bukti/surat keterangan pendukung (Opsional / Menyusul) • (JPG, PNG, PDF • Maks. 2MB)';
    }
  }
}
