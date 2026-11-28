// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Indonesian (`id`).
class AppLocalizationsId extends AppLocalizations {
  AppLocalizationsId([String locale = 'id']) : super(locale);

  @override
  String get appTitle => 'SIM SPPG Mobile';

  @override
  String get language => 'Bahasa';

  @override
  String get selectLanguage => 'Pilih Bahasa';

  @override
  String get indonesian => 'Bahasa Indonesia';

  @override
  String get english => 'English';

  @override
  String get profile => 'Profil';

  @override
  String get profileSubtitle => 'Informasi kepegawaian & pengaturan akun';

  @override
  String get accountSettings => 'Pengaturan Akun';

  @override
  String get accountDetail => 'Detail Akun';

  @override
  String get accountDetailSubtitle => 'Data kepegawaian, penempatan & payroll';

  @override
  String get employmentAndPayrollData => 'Data Kepegawaian & Payroll';

  @override
  String get personalIdentityAndContact => 'IDENTITAS PRIBADI & KONTAK';

  @override
  String get nikKtp => 'NIK (KTP)';

  @override
  String get birthPlaceDate => 'Tempat, Tgl Lahir';

  @override
  String get officialEmail => 'Email Resmi';

  @override
  String get whatsappNumber => 'No. WhatsApp';

  @override
  String get domicile => 'Domisili';

  @override
  String get placementAndShift => 'PENEMPATAN & JADWAL SHIFT';

  @override
  String get kitchenUnit => 'Unit Dapur SPPG';

  @override
  String get operationalDivision => 'Divisi Operasional';

  @override
  String get joinDate => 'Tanggal Bergabung';

  @override
  String get mainShiftSchedule => 'Jadwal Shift Utama';

  @override
  String get payrollAccountAndInsurance => 'REKENING PAYROLL & JAMINAN';

  @override
  String get verified => 'Terverifikasi';

  @override
  String get disbursementBank => 'Bank Penyalur';

  @override
  String get accountNumber => 'Nomor Rekening';

  @override
  String get accountHolderName => 'Nama Pemilik';

  @override
  String get bpjsHealthAndEmployment => 'BPJS Kesehatan & TK';

  @override
  String get dataChangeNotice =>
      'Perubahan data NIK, nomor rekening gaji, atau jadwal shift utama hanya dapat dilakukan melalui Admin Unit SPPG / HR Pusat.';

  @override
  String get personnelIdLabel => 'ID PERSONEL';

  @override
  String get workTenureLabel => 'MASA KERJA';

  @override
  String get changePassword => 'Ubah Kata Sandi';

  @override
  String get changePasswordSubtitle => 'Perbarui keamanan akses akun';

  @override
  String get changePasswordHint =>
      'Gunakan minimal 8 karakter dengan kombinasi huruf dan angka untuk menjaga keamanan akun personel Anda.';

  @override
  String get currentPassword => 'Kata Sandi Saat Ini';

  @override
  String get newPassword => 'Kata Sandi Baru';

  @override
  String get confirmNewPassword => 'Konfirmasi Kata Sandi Baru';

  @override
  String get saveNewPassword => 'Simpan Kata Sandi Baru';

  @override
  String enterField(String label) {
    return 'Masukkan $label';
  }

  @override
  String get passwordFieldsRequired =>
      'Harap lengkapi seluruh kolom kata sandi.';

  @override
  String get passwordMinLength8 => 'Kata sandi baru minimal 8 karakter.';

  @override
  String get passwordConfirmationMismatch =>
      'Konfirmasi kata sandi baru tidak cocok.';

  @override
  String get passwordUpdatedSuccess => 'Kata sandi berhasil diperbarui.';

  @override
  String get helpCenter => 'Pusat Bantuan & SOP';

  @override
  String get helpCenterSubtitle => 'Panduan operasional & kontak admin';

  @override
  String get faqBiometricTitle => 'SOP Presensi Biometrik & Radius GPS';

  @override
  String get faqBiometricBody =>
      'Pastikan GPS aktif dan Anda berada dalam radius 50 meter dari titik dapur SPPG saat melakukan Clock-In maupun Clock-Out.';

  @override
  String get faqSickNoteTitle => 'Prosedur Unggah Surat Keterangan Dokter';

  @override
  String get faqSickNoteBody =>
      'Untuk pengajuan Izin Sakit, unggah bukti surat dokter maksimal 48 jam sejak tanggal ketidakhadiran melalui menu Cuti & Izin.';

  @override
  String get faqCorrectionTitle => 'Pengajuan Koreksi Absensi';

  @override
  String get faqCorrectionBody =>
      'Jika terjadi kendala teknis saat presensi, ajukan koreksi pada halaman Riwayat Absen agar diverifikasi oleh KSPPG.';

  @override
  String get faqContactTitle => 'Kontak Admin Operasional SPPG';

  @override
  String get faqContactBody =>
      'WhatsApp Helpdesk: 0811-9000-2401 (Senin–Sabtu, 05:00 - 17:00 WIB) atau email support@sppg.go.id.';

  @override
  String get changeLanguage => 'Ganti Bahasa';

  @override
  String get changeLanguageSubtitle => 'Pilih bahasa tampilan aplikasi';

  @override
  String get logout => 'Keluar dari Akun';

  @override
  String get logoutConfirmationTitle => 'Keluar dari Akun?';

  @override
  String get logoutConfirmationMessage =>
      'Anda harus masuk kembali menggunakan kredensial personel SPPG untuk mengakses aplikasi.';

  @override
  String get cancel => 'Batal';

  @override
  String get confirm => 'Konfirmasi';

  @override
  String get tryAgain => 'Coba Lagi';

  @override
  String get login => 'Masuk';

  @override
  String get loginToAccount => 'Masuk ke Akun';

  @override
  String get loginSubtitle =>
      'Gunakan ID Personel atau email resmi yang terdaftar';

  @override
  String get appFullSubtitle =>
      'Sistem Informasi Manajemen Satuan Pelayanan\nPemenuhan Gizi';

  @override
  String get personnelIdOrEmail => 'ID Personel / Email';

  @override
  String get password => 'Kata Sandi';

  @override
  String get enterPassword => 'Masukkan kata sandi';

  @override
  String get rememberMe => 'Ingat sesi saya';

  @override
  String get forgotPassword => 'Lupa kata sandi?';

  @override
  String get forgotPasswordTitle => 'Lupa Kata Sandi';

  @override
  String get loginButtonArrow => 'Masuk  →';

  @override
  String get accountManagedNotice =>
      'Akun personel diterbitkan & dikelola oleh Admin Unit SPPG. Hubungi KSPPG jika belum memiliki akses.';

  @override
  String get personnelAccessRecovery => 'Pemulihan Akses Personel';

  @override
  String get forgotPasswordDescription =>
      'Masukkan ID Personel atau email resmi SPPG Anda. Tautan reset atau verifikasi admin akan dikirimkan ke kontak terdaftar.';

  @override
  String get identifierExampleHint =>
      'Contoh: SPPG-RMG-014 atau nama@sppg.go.id';

  @override
  String get sendResetRequest => 'Kirim Permintaan Reset';

  @override
  String get enterIdentifierError =>
      'Masukkan ID Personel atau email resmi Anda.';

  @override
  String get resetRequestSent =>
      'Permintaan reset kata sandi dikirim ke Admin Unit SPPG & email terdaftar.';

  @override
  String get home => 'Beranda';

  @override
  String get schedule => 'Jadwal';

  @override
  String get attendance => 'Presensi';

  @override
  String get payroll => 'Gaji';

  @override
  String get account => 'Akun';

  @override
  String get leaveBalance => 'Saldo Cuti';

  @override
  String get available => 'Tersedia';

  @override
  String get attendanceLabel => 'Kehadiran';

  @override
  String get target90 => '90% Target';

  @override
  String get latePenalty => 'Denda Telat';

  @override
  String get primeDiscipline => 'Disiplin Prima';

  @override
  String get clockIn => 'CLOCK-IN';

  @override
  String get clockOut => 'CLOCK-OUT';

  @override
  String get onTime => 'Tepat Waktu';

  @override
  String get completed => 'Selesai';

  @override
  String get waiting => 'Menunggu';

  @override
  String get attendanceCompleted => 'Presensi Selesai';

  @override
  String get clockOutNow => 'Clock-Out Sekarang (Pulang)';

  @override
  String get failedToLoadData => 'Gagal Memuat Data';

  @override
  String get personnelSelfService => 'Layanan Mandiri Personel';

  @override
  String mainModulesCount(int count) {
    return '$count Modul Utama';
  }

  @override
  String openingModule(String title) {
    return 'Membuka modul: $title';
  }

  @override
  String get monthlySummary => 'Ringkasan Bulan Ini';

  @override
  String get scheduleAndHolidays => 'Jadwal & Libur';

  @override
  String get daySun => 'Min';

  @override
  String get dayMon => 'Sen';

  @override
  String get dayTue => 'Sel';

  @override
  String get dayWed => 'Rab';

  @override
  String get dayThu => 'Kam';

  @override
  String get dayFri => 'Jum';

  @override
  String get daySat => 'Sab';

  @override
  String get workDay => 'Hari Kerja';

  @override
  String get dayOff => 'Libur';

  @override
  String get sppgHoliday => 'Libur SPPG';

  @override
  String get leave => 'Cuti';

  @override
  String get kitchenDivision => 'Divisi Dapur';

  @override
  String get shiftHours => 'Jam Shift';

  @override
  String get lateTolerance => 'Toleransi Telat';

  @override
  String get scheduleStatus => 'Status Jadwal';

  @override
  String get workDayUpper => 'HARI KERJA';

  @override
  String get dayOffUpper => 'LIBUR';

  @override
  String get sppgHolidayUpper => 'LIBUR SPPG';

  @override
  String get annualLeaveUpper => 'CUTI TAHUNAN';

  @override
  String get dayOffSlashUpper => 'LIBUR / OFF';

  @override
  String get leaveQuotaUpper => 'KUOTA CUTI';

  @override
  String daysCount(int count) {
    return '$count Hari';
  }

  @override
  String get attendanceCheckInTitle => 'Presensi Kehadiran';

  @override
  String get attendanceCheckOutTitle => 'Presensi Pulang';

  @override
  String get confirmClockIn => 'Konfirmasi Clock-In (Masuk)';

  @override
  String get confirmClockOut => 'Konfirmasi Clock-Out (Pulang)';

  @override
  String get singleCameraNotice =>
      'Hanya 1 kamera tersedia atau menggunakan simulasi.';

  @override
  String get faceFrameInstruction =>
      'Pastikan wajah terlihat jelas di dalam bingkai tanpa masker';

  @override
  String get turnOnCamera => 'Hidupkan Kamera';

  @override
  String get capturePhoto => 'Capture';

  @override
  String get retakePhoto => 'Foto Ulang';

  @override
  String get cameraOffInstruction =>
      'Tekan tombol Hidupkan Kamera untuk mengambil foto presensi';

  @override
  String get photoCapturedInstruction =>
      'Foto berhasil diambil. Silakan konfirmasi presensi.';

  @override
  String get cameraPermissionDenied =>
      'Izin kamera ditolak. Aktifkan izin kamera untuk mengambil foto presensi.';

  @override
  String get cameraUnavailable => 'Kamera tidak tersedia pada perangkat ini.';

  @override
  String get clockInEntryUpper => 'CLOCK-IN MASUK';

  @override
  String get totalWorkDurationUpper => 'TOTAL DURASI KERJA';

  @override
  String get kitchenLocationVerified => 'Lokasi Dapur Terverifikasi';

  @override
  String get withinRadius => 'Dalam Radius';

  @override
  String get outsideRadius => 'Luar Radius';

  @override
  String get attendanceHistory => 'Riwayat Absen';

  @override
  String get noDataForFilter => 'Belum ada data untuk filter ini';

  @override
  String get showLess => 'Tampilkan Lebih Sedikit  ↑';

  @override
  String showAllThisMonth(int count) {
    return 'Tampilkan Semua di Bulan Ini ($count)  ↓';
  }

  @override
  String get filterAll => 'Semua';

  @override
  String get filterPresent => 'Hadir';

  @override
  String get filterLate => 'Telat';

  @override
  String get filterLeave => 'Cuti & Izin';

  @override
  String get presentUpper => 'HADIR';

  @override
  String get lateUpper => 'TELAT';

  @override
  String get leaveUpper => 'CUTI/IZIN';

  @override
  String get waitingUpper => 'MENUNGGU';

  @override
  String get correctionSubmitted => 'Koreksi Diajukan';

  @override
  String durationPrefix(String duration) {
    return 'Durasi: $duration';
  }

  @override
  String get requestCorrection => 'Ajukan Koreksi';

  @override
  String get requestAttendanceCorrection => 'Ajukan Koreksi Absensi';

  @override
  String get correctionReasonHint =>
      'Tuliskan alasan koreksi (misal: kendala GPS atau tugas distribusi bahan)...';

  @override
  String get attendanceTimeCorrection => 'Koreksi jam kehadiran';

  @override
  String get submitCorrectionRequest => 'Kirim Pengajuan Koreksi';

  @override
  String get payrollTitle => 'Payroll';

  @override
  String get payrollHeaderSubtitle => 'SPPG Rawamangun 01 • Closing Tgl 25';

  @override
  String get payslipList => 'Daftar Slip Gaji';

  @override
  String yearLabel(int year) {
    return 'Tahun $year';
  }

  @override
  String get latestBadge => 'Terbaru';

  @override
  String get attendanceUpper => 'KEHADIRAN';

  @override
  String get leaveSlashUpper => 'CUTI / IZIN';

  @override
  String get latePenaltyUpper => 'DENDA TELAT';

  @override
  String get viewSlipDetails => 'Lihat Rincian Slip';

  @override
  String get penaltiesAndAllowances => 'Rincian Denda & Tunjangan';

  @override
  String get payslipDetailTitle => 'Detail Slip Gaji';

  @override
  String get paidStatus => 'Terbayar';

  @override
  String get kitchenUnitUpper => 'UNIT DAPUR';

  @override
  String get approved => 'Disetujui';

  @override
  String get earningsUpper => 'PENDAPATAN (+)';

  @override
  String get basePositionSalary => 'Gaji Pokok Posisi';

  @override
  String get attendanceAndPositionAllowance => 'Tunjangan Hadir & Jabatan';

  @override
  String get totalGrossEarnings => 'Total Pendapatan Kotor';

  @override
  String get deductionsUpper => 'POTONGAN (-)';

  @override
  String get totalNetReceived => 'Total Diterima (Bersih)';

  @override
  String get afterPenaltiesAndTax => 'Sudah dipotong denda & pajak';

  @override
  String get destinationAccount => 'Rekening Tujuan';

  @override
  String get disbursementDate => 'Tanggal Pencairan';

  @override
  String get officialPayslipFooter =>
      'Dokumen resmi terverifikasi sistem payroll SIM-SPPG';

  @override
  String get payslipDownloaded =>
      'Slip Gaji (PDF) berhasil diunduh ke perangkat Anda.';

  @override
  String get downloadPayslipPdf => 'Unduh Slip Gaji (PDF)';

  @override
  String get totalAllowanceUpper => 'TOTAL TUNJANGAN';

  @override
  String get attendanceAndRole => 'Hadir & Jabatan';

  @override
  String get totalLatePenaltyUpper => 'TOTAL DENDA TELAT';

  @override
  String get lateLogThisPeriod => 'Log Keterlambatan Periode Ini';

  @override
  String get viewInHistory => 'Lihat di Riwayat';

  @override
  String get activeAllowanceBreakdown => 'Rincian Tunjangan Aktif';

  @override
  String get attendanceAllowance => 'Tunjangan Kehadiran';

  @override
  String get positionAllowance => 'Tunjangan Posisi (Ahli Gizi)';

  @override
  String get totalAllowanceThisPeriod => 'Total Tunjangan Periode Ini';

  @override
  String get payrollPolicyTitle => 'Ketentuan Payroll SPPG';

  @override
  String get notificationsTitle => 'Notifikasi';

  @override
  String get allNotificationsMarkedRead =>
      'Semua notifikasi ditandai sudah dibaca';

  @override
  String get markAsRead => 'Tandai dibaca';

  @override
  String get todayUpper => 'HARI INI';

  @override
  String messagesCount(int count) {
    return '$count Pesan';
  }

  @override
  String get noNotifications => 'Tidak ada notifikasi';

  @override
  String filterAllUnread(int count) {
    return 'Semua ($count)';
  }

  @override
  String get filterOperational => 'Operasional';

  @override
  String get filterApproval => 'Persetujuan';

  @override
  String get unread => 'Belum dibaca';

  @override
  String get read => 'Sudah dibaca';

  @override
  String get leaveRequestTitle => 'Pengajuan Cuti & Izin';

  @override
  String get annualLeave => 'Cuti Tahunan';

  @override
  String get sickLeave => 'Izin Sakit';

  @override
  String get emergencyLeave => 'Izin Darurat';

  @override
  String get annualLeaveQuotaTitle => 'Kuota Cuti Tahunan 2026';

  @override
  String get annualLeavePolicyDesc =>
      'Cuti tahunan diajukan min. H-2. Izin sakit/darurat dapat diajukan hari-H tanpa memotong kuota.';

  @override
  String get selectSubmissionDate => 'Pilih Tanggal Pengajuan';

  @override
  String get startDate => 'Tanggal Mulai';

  @override
  String get endDate => 'Tanggal Selesai';

  @override
  String durationWorkDays(int days) {
    return '• Durasi: $days Hari Kerja';
  }

  @override
  String get remainingBalancePrefix => 'Sisa Saldo: ';

  @override
  String get fixedBalancePrefix => 'Saldo Tetap: ';

  @override
  String get reasonOrNotes => 'Alasan / Keterangan';

  @override
  String get reasonHint => 'Tuliskan alasan pengajuan cuti secara singkat...';

  @override
  String get attachEvidence => 'Lampirkan Bukti';

  @override
  String get savedFileMeta => 'Tersimpan • 1.2 MB';

  @override
  String get evidenceOptionalHint =>
      'Opsional untuk cuti • Wajib menyusul maks. 2x24 jam untuk Izin Sakit (JPG, PNG, PDF • Maks. 2MB)';

  @override
  String get forwardedToCoordinator =>
      'Akan diteruskan ke Koordinator Unit SPPG Rawamangun 01.';

  @override
  String get submitRequest => 'Kirim Pengajuan';

  @override
  String fileAttachedSuccess(String fileName) {
    return 'File \"$fileName\" berhasil dilampirkan.';
  }

  @override
  String get quotaFree => 'Bebas Kuota';

  @override
  String get noQuotaDeduction => 'Tidak Potong Kuota';

  @override
  String get sickLeaveTerms => 'Ketentuan Izin Sakit';

  @override
  String get selectSickDate => 'Pilih Tanggal Sakit';

  @override
  String get sickReasonLabel => 'Alasan / Keluhan Sakit';

  @override
  String get sickReasonHint => 'Tuliskan keluhan atau gejala sakit...';

  @override
  String get sendReportToKsppg => 'Kirim Laporan ke KSPPG';

  @override
  String get waitingSickEvidence => 'Menunggu Bukti Sakit';

  @override
  String get uploadDeadline2x24 => 'Batas Akhir Unggah (2x24 Jam)';

  @override
  String get sickReportReceivedNotice =>
      'Laporan awal sudah diterima KSPPG. Wajib unggah surat dokter/bukti sebelum batas waktu berakhir.';

  @override
  String get submittedReportSummary => 'Ringkasan Laporan Terkirim';

  @override
  String get receivedByKsppg => '✓ Diterima KSPPG';

  @override
  String get sickDate => 'Tanggal Sakit';

  @override
  String get symptoms => 'Keluhan';

  @override
  String get attachSickEvidence => 'Lampirkan Bukti Sakit';

  @override
  String get uploadRequired => 'Wajib Diunggah';

  @override
  String get fileSelectedReady => 'File terpilih • Siap dikirim';

  @override
  String get takePhotoOrPickDoc => 'Ambil Foto atau Pilih Dokumen';

  @override
  String get sickDocHint =>
      'Surat keterangan dokter, resep obat, atau bukti klinik (JPG, PNG, PDF • Maks. 2MB)';

  @override
  String get submitSickEvidence => 'Kirim Bukti Sakit';

  @override
  String get emergencyLeaveTerms => 'Ketentuan Izin Darurat';

  @override
  String get emergencyLeavePolicyDesc =>
      'Khusus kondisi mendesak hari-H (musibah keluarga, kendala perjalanan, atau bencana) tanpa memotong jatah cuti tahunan.';

  @override
  String get emergencyTypeAndTime => 'Jenis & Waktu Darurat';

  @override
  String get absentFullDay => 'Tidak Masuk (Full)';

  @override
  String get latePermission => 'Izin Terlambat';

  @override
  String get shiftDate => 'Tanggal Shift';

  @override
  String get estimatedArrivalTime => 'Estimasi Jam Tiba';

  @override
  String get emergencyCategory => 'Kategori Kondisi Darurat';

  @override
  String get selectEmergencyCategory => 'Pilih Kategori Kondisi Darurat';

  @override
  String get emergencyCategoryExample =>
      'Contoh: Keluarga rawat darurat, kendaraan mogok, banjir/bencana, dll.';

  @override
  String get shortDescription => 'Keterangan Singkat';

  @override
  String get emergencyReasonHint =>
      'Jelaskan kondisi darurat secara singkat...';

  @override
  String get emergencyEvidenceHint =>
      'Unggah foto kondisi di tempat, surat IGD, atau\ntangkapan layar (JPG, PNG, PDF • Maks. 2MB)';

  @override
  String get forwardedAsPriority =>
      'Akan diteruskan sebagai prioritas ke Koordinator Unit SPPG\nRawamangun 01.';

  @override
  String get submitLatePermission => 'Kirim Izin Terlambat';

  @override
  String get submitEmergencyLeave => 'Kirim Izin Darurat';
}
