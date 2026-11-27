import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_id.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('id'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In id, this message translates to:
  /// **'SIM SPPG Mobile'**
  String get appTitle;

  /// No description provided for @language.
  ///
  /// In id, this message translates to:
  /// **'Bahasa'**
  String get language;

  /// No description provided for @selectLanguage.
  ///
  /// In id, this message translates to:
  /// **'Pilih Bahasa'**
  String get selectLanguage;

  /// No description provided for @indonesian.
  ///
  /// In id, this message translates to:
  /// **'Bahasa Indonesia'**
  String get indonesian;

  /// No description provided for @english.
  ///
  /// In id, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @profile.
  ///
  /// In id, this message translates to:
  /// **'Profil'**
  String get profile;

  /// No description provided for @profileSubtitle.
  ///
  /// In id, this message translates to:
  /// **'Informasi kepegawaian & pengaturan akun'**
  String get profileSubtitle;

  /// No description provided for @accountSettings.
  ///
  /// In id, this message translates to:
  /// **'Pengaturan Akun'**
  String get accountSettings;

  /// No description provided for @accountDetail.
  ///
  /// In id, this message translates to:
  /// **'Detail Akun'**
  String get accountDetail;

  /// No description provided for @accountDetailSubtitle.
  ///
  /// In id, this message translates to:
  /// **'Data kepegawaian, penempatan & payroll'**
  String get accountDetailSubtitle;

  /// No description provided for @employmentAndPayrollData.
  ///
  /// In id, this message translates to:
  /// **'Data Kepegawaian & Payroll'**
  String get employmentAndPayrollData;

  /// No description provided for @personalIdentityAndContact.
  ///
  /// In id, this message translates to:
  /// **'IDENTITAS PRIBADI & KONTAK'**
  String get personalIdentityAndContact;

  /// No description provided for @nikKtp.
  ///
  /// In id, this message translates to:
  /// **'NIK (KTP)'**
  String get nikKtp;

  /// No description provided for @birthPlaceDate.
  ///
  /// In id, this message translates to:
  /// **'Tempat, Tgl Lahir'**
  String get birthPlaceDate;

  /// No description provided for @officialEmail.
  ///
  /// In id, this message translates to:
  /// **'Email Resmi'**
  String get officialEmail;

  /// No description provided for @whatsappNumber.
  ///
  /// In id, this message translates to:
  /// **'No. WhatsApp'**
  String get whatsappNumber;

  /// No description provided for @domicile.
  ///
  /// In id, this message translates to:
  /// **'Domisili'**
  String get domicile;

  /// No description provided for @placementAndShift.
  ///
  /// In id, this message translates to:
  /// **'PENEMPATAN & JADWAL SHIFT'**
  String get placementAndShift;

  /// No description provided for @kitchenUnit.
  ///
  /// In id, this message translates to:
  /// **'Unit Dapur SPPG'**
  String get kitchenUnit;

  /// No description provided for @operationalDivision.
  ///
  /// In id, this message translates to:
  /// **'Divisi Operasional'**
  String get operationalDivision;

  /// No description provided for @joinDate.
  ///
  /// In id, this message translates to:
  /// **'Tanggal Bergabung'**
  String get joinDate;

  /// No description provided for @mainShiftSchedule.
  ///
  /// In id, this message translates to:
  /// **'Jadwal Shift Utama'**
  String get mainShiftSchedule;

  /// No description provided for @payrollAccountAndInsurance.
  ///
  /// In id, this message translates to:
  /// **'REKENING PAYROLL & JAMINAN'**
  String get payrollAccountAndInsurance;

  /// No description provided for @verified.
  ///
  /// In id, this message translates to:
  /// **'Terverifikasi'**
  String get verified;

  /// No description provided for @disbursementBank.
  ///
  /// In id, this message translates to:
  /// **'Bank Penyalur'**
  String get disbursementBank;

  /// No description provided for @accountNumber.
  ///
  /// In id, this message translates to:
  /// **'Nomor Rekening'**
  String get accountNumber;

  /// No description provided for @accountHolderName.
  ///
  /// In id, this message translates to:
  /// **'Nama Pemilik'**
  String get accountHolderName;

  /// No description provided for @bpjsHealthAndEmployment.
  ///
  /// In id, this message translates to:
  /// **'BPJS Kesehatan & TK'**
  String get bpjsHealthAndEmployment;

  /// No description provided for @dataChangeNotice.
  ///
  /// In id, this message translates to:
  /// **'Perubahan data NIK, nomor rekening gaji, atau jadwal shift utama hanya dapat dilakukan melalui Admin Unit SPPG / HR Pusat.'**
  String get dataChangeNotice;

  /// No description provided for @personnelIdLabel.
  ///
  /// In id, this message translates to:
  /// **'ID PERSONEL'**
  String get personnelIdLabel;

  /// No description provided for @workTenureLabel.
  ///
  /// In id, this message translates to:
  /// **'MASA KERJA'**
  String get workTenureLabel;

  /// No description provided for @changePassword.
  ///
  /// In id, this message translates to:
  /// **'Ubah Kata Sandi'**
  String get changePassword;

  /// No description provided for @changePasswordSubtitle.
  ///
  /// In id, this message translates to:
  /// **'Perbarui keamanan akses akun'**
  String get changePasswordSubtitle;

  /// No description provided for @changePasswordHint.
  ///
  /// In id, this message translates to:
  /// **'Gunakan minimal 8 karakter dengan kombinasi huruf dan angka untuk menjaga keamanan akun personel Anda.'**
  String get changePasswordHint;

  /// No description provided for @currentPassword.
  ///
  /// In id, this message translates to:
  /// **'Kata Sandi Saat Ini'**
  String get currentPassword;

  /// No description provided for @newPassword.
  ///
  /// In id, this message translates to:
  /// **'Kata Sandi Baru'**
  String get newPassword;

  /// No description provided for @confirmNewPassword.
  ///
  /// In id, this message translates to:
  /// **'Konfirmasi Kata Sandi Baru'**
  String get confirmNewPassword;

  /// No description provided for @saveNewPassword.
  ///
  /// In id, this message translates to:
  /// **'Simpan Kata Sandi Baru'**
  String get saveNewPassword;

  /// No description provided for @enterField.
  ///
  /// In id, this message translates to:
  /// **'Masukkan {label}'**
  String enterField(String label);

  /// No description provided for @passwordFieldsRequired.
  ///
  /// In id, this message translates to:
  /// **'Harap lengkapi seluruh kolom kata sandi.'**
  String get passwordFieldsRequired;

  /// No description provided for @passwordMinLength8.
  ///
  /// In id, this message translates to:
  /// **'Kata sandi baru minimal 8 karakter.'**
  String get passwordMinLength8;

  /// No description provided for @passwordConfirmationMismatch.
  ///
  /// In id, this message translates to:
  /// **'Konfirmasi kata sandi baru tidak cocok.'**
  String get passwordConfirmationMismatch;

  /// No description provided for @passwordUpdatedSuccess.
  ///
  /// In id, this message translates to:
  /// **'Kata sandi berhasil diperbarui.'**
  String get passwordUpdatedSuccess;

  /// No description provided for @helpCenter.
  ///
  /// In id, this message translates to:
  /// **'Pusat Bantuan & SOP'**
  String get helpCenter;

  /// No description provided for @helpCenterSubtitle.
  ///
  /// In id, this message translates to:
  /// **'Panduan operasional & kontak admin'**
  String get helpCenterSubtitle;

  /// No description provided for @faqBiometricTitle.
  ///
  /// In id, this message translates to:
  /// **'SOP Presensi Biometrik & Radius GPS'**
  String get faqBiometricTitle;

  /// No description provided for @faqBiometricBody.
  ///
  /// In id, this message translates to:
  /// **'Pastikan GPS aktif dan Anda berada dalam radius 50 meter dari titik dapur SPPG saat melakukan Clock-In maupun Clock-Out.'**
  String get faqBiometricBody;

  /// No description provided for @faqSickNoteTitle.
  ///
  /// In id, this message translates to:
  /// **'Prosedur Unggah Surat Keterangan Dokter'**
  String get faqSickNoteTitle;

  /// No description provided for @faqSickNoteBody.
  ///
  /// In id, this message translates to:
  /// **'Untuk pengajuan Izin Sakit, unggah bukti surat dokter maksimal 48 jam sejak tanggal ketidakhadiran melalui menu Cuti & Izin.'**
  String get faqSickNoteBody;

  /// No description provided for @faqCorrectionTitle.
  ///
  /// In id, this message translates to:
  /// **'Pengajuan Koreksi Absensi'**
  String get faqCorrectionTitle;

  /// No description provided for @faqCorrectionBody.
  ///
  /// In id, this message translates to:
  /// **'Jika terjadi kendala teknis saat presensi, ajukan koreksi pada halaman Riwayat Absen agar diverifikasi oleh KSPPG.'**
  String get faqCorrectionBody;

  /// No description provided for @faqContactTitle.
  ///
  /// In id, this message translates to:
  /// **'Kontak Admin Operasional SPPG'**
  String get faqContactTitle;

  /// No description provided for @faqContactBody.
  ///
  /// In id, this message translates to:
  /// **'WhatsApp Helpdesk: 0811-9000-2401 (Senin–Sabtu, 05:00 - 17:00 WIB) atau email support@sppg.go.id.'**
  String get faqContactBody;

  /// No description provided for @changeLanguage.
  ///
  /// In id, this message translates to:
  /// **'Ganti Bahasa'**
  String get changeLanguage;

  /// No description provided for @changeLanguageSubtitle.
  ///
  /// In id, this message translates to:
  /// **'Pilih bahasa tampilan aplikasi'**
  String get changeLanguageSubtitle;

  /// No description provided for @logout.
  ///
  /// In id, this message translates to:
  /// **'Keluar dari Akun'**
  String get logout;

  /// No description provided for @logoutConfirmationTitle.
  ///
  /// In id, this message translates to:
  /// **'Keluar dari Akun?'**
  String get logoutConfirmationTitle;

  /// No description provided for @logoutConfirmationMessage.
  ///
  /// In id, this message translates to:
  /// **'Anda harus masuk kembali menggunakan kredensial personel SPPG untuk mengakses aplikasi.'**
  String get logoutConfirmationMessage;

  /// No description provided for @cancel.
  ///
  /// In id, this message translates to:
  /// **'Batal'**
  String get cancel;

  /// No description provided for @confirm.
  ///
  /// In id, this message translates to:
  /// **'Konfirmasi'**
  String get confirm;

  /// No description provided for @tryAgain.
  ///
  /// In id, this message translates to:
  /// **'Coba Lagi'**
  String get tryAgain;

  /// No description provided for @login.
  ///
  /// In id, this message translates to:
  /// **'Masuk'**
  String get login;

  /// No description provided for @loginToAccount.
  ///
  /// In id, this message translates to:
  /// **'Masuk ke Akun'**
  String get loginToAccount;

  /// No description provided for @loginSubtitle.
  ///
  /// In id, this message translates to:
  /// **'Gunakan ID Personel atau email resmi yang terdaftar'**
  String get loginSubtitle;

  /// No description provided for @appFullSubtitle.
  ///
  /// In id, this message translates to:
  /// **'Sistem Informasi Manajemen Satuan Pelayanan\nPemenuhan Gizi'**
  String get appFullSubtitle;

  /// No description provided for @personnelIdOrEmail.
  ///
  /// In id, this message translates to:
  /// **'ID Personel / Email'**
  String get personnelIdOrEmail;

  /// No description provided for @password.
  ///
  /// In id, this message translates to:
  /// **'Kata Sandi'**
  String get password;

  /// No description provided for @enterPassword.
  ///
  /// In id, this message translates to:
  /// **'Masukkan kata sandi'**
  String get enterPassword;

  /// No description provided for @rememberMe.
  ///
  /// In id, this message translates to:
  /// **'Ingat sesi saya'**
  String get rememberMe;

  /// No description provided for @forgotPassword.
  ///
  /// In id, this message translates to:
  /// **'Lupa kata sandi?'**
  String get forgotPassword;

  /// No description provided for @forgotPasswordTitle.
  ///
  /// In id, this message translates to:
  /// **'Lupa Kata Sandi'**
  String get forgotPasswordTitle;

  /// No description provided for @loginButtonArrow.
  ///
  /// In id, this message translates to:
  /// **'Masuk  →'**
  String get loginButtonArrow;

  /// No description provided for @accountManagedNotice.
  ///
  /// In id, this message translates to:
  /// **'Akun personel diterbitkan & dikelola oleh Admin Unit SPPG. Hubungi KSPPG jika belum memiliki akses.'**
  String get accountManagedNotice;

  /// No description provided for @personnelAccessRecovery.
  ///
  /// In id, this message translates to:
  /// **'Pemulihan Akses Personel'**
  String get personnelAccessRecovery;

  /// No description provided for @forgotPasswordDescription.
  ///
  /// In id, this message translates to:
  /// **'Masukkan ID Personel atau email resmi SPPG Anda. Tautan reset atau verifikasi admin akan dikirimkan ke kontak terdaftar.'**
  String get forgotPasswordDescription;

  /// No description provided for @identifierExampleHint.
  ///
  /// In id, this message translates to:
  /// **'Contoh: SPPG-RMG-014 atau nama@sppg.go.id'**
  String get identifierExampleHint;

  /// No description provided for @sendResetRequest.
  ///
  /// In id, this message translates to:
  /// **'Kirim Permintaan Reset'**
  String get sendResetRequest;

  /// No description provided for @enterIdentifierError.
  ///
  /// In id, this message translates to:
  /// **'Masukkan ID Personel atau email resmi Anda.'**
  String get enterIdentifierError;

  /// No description provided for @resetRequestSent.
  ///
  /// In id, this message translates to:
  /// **'Permintaan reset kata sandi dikirim ke Admin Unit SPPG & email terdaftar.'**
  String get resetRequestSent;

  /// No description provided for @home.
  ///
  /// In id, this message translates to:
  /// **'Beranda'**
  String get home;

  /// No description provided for @schedule.
  ///
  /// In id, this message translates to:
  /// **'Jadwal'**
  String get schedule;

  /// No description provided for @attendance.
  ///
  /// In id, this message translates to:
  /// **'Presensi'**
  String get attendance;

  /// No description provided for @payroll.
  ///
  /// In id, this message translates to:
  /// **'Gaji'**
  String get payroll;

  /// No description provided for @account.
  ///
  /// In id, this message translates to:
  /// **'Akun'**
  String get account;

  /// No description provided for @leaveBalance.
  ///
  /// In id, this message translates to:
  /// **'Saldo Cuti'**
  String get leaveBalance;

  /// No description provided for @available.
  ///
  /// In id, this message translates to:
  /// **'Tersedia'**
  String get available;

  /// No description provided for @attendanceLabel.
  ///
  /// In id, this message translates to:
  /// **'Kehadiran'**
  String get attendanceLabel;

  /// No description provided for @target90.
  ///
  /// In id, this message translates to:
  /// **'90% Target'**
  String get target90;

  /// No description provided for @latePenalty.
  ///
  /// In id, this message translates to:
  /// **'Denda Telat'**
  String get latePenalty;

  /// No description provided for @primeDiscipline.
  ///
  /// In id, this message translates to:
  /// **'Disiplin Prima'**
  String get primeDiscipline;

  /// No description provided for @clockIn.
  ///
  /// In id, this message translates to:
  /// **'CLOCK-IN'**
  String get clockIn;

  /// No description provided for @clockOut.
  ///
  /// In id, this message translates to:
  /// **'CLOCK-OUT'**
  String get clockOut;

  /// No description provided for @onTime.
  ///
  /// In id, this message translates to:
  /// **'Tepat Waktu'**
  String get onTime;

  /// No description provided for @completed.
  ///
  /// In id, this message translates to:
  /// **'Selesai'**
  String get completed;

  /// No description provided for @waiting.
  ///
  /// In id, this message translates to:
  /// **'Menunggu'**
  String get waiting;

  /// No description provided for @attendanceCompleted.
  ///
  /// In id, this message translates to:
  /// **'Presensi Selesai'**
  String get attendanceCompleted;

  /// No description provided for @clockOutNow.
  ///
  /// In id, this message translates to:
  /// **'Clock-Out Sekarang (Pulang)'**
  String get clockOutNow;

  /// No description provided for @failedToLoadData.
  ///
  /// In id, this message translates to:
  /// **'Gagal Memuat Data'**
  String get failedToLoadData;

  /// No description provided for @personnelSelfService.
  ///
  /// In id, this message translates to:
  /// **'Layanan Mandiri Personel'**
  String get personnelSelfService;

  /// No description provided for @mainModulesCount.
  ///
  /// In id, this message translates to:
  /// **'{count} Modul Utama'**
  String mainModulesCount(int count);

  /// No description provided for @openingModule.
  ///
  /// In id, this message translates to:
  /// **'Membuka modul: {title}'**
  String openingModule(String title);

  /// No description provided for @monthlySummary.
  ///
  /// In id, this message translates to:
  /// **'Ringkasan Bulan Ini'**
  String get monthlySummary;

  /// No description provided for @scheduleAndHolidays.
  ///
  /// In id, this message translates to:
  /// **'Jadwal & Libur'**
  String get scheduleAndHolidays;

  /// No description provided for @daySun.
  ///
  /// In id, this message translates to:
  /// **'Min'**
  String get daySun;

  /// No description provided for @dayMon.
  ///
  /// In id, this message translates to:
  /// **'Sen'**
  String get dayMon;

  /// No description provided for @dayTue.
  ///
  /// In id, this message translates to:
  /// **'Sel'**
  String get dayTue;

  /// No description provided for @dayWed.
  ///
  /// In id, this message translates to:
  /// **'Rab'**
  String get dayWed;

  /// No description provided for @dayThu.
  ///
  /// In id, this message translates to:
  /// **'Kam'**
  String get dayThu;

  /// No description provided for @dayFri.
  ///
  /// In id, this message translates to:
  /// **'Jum'**
  String get dayFri;

  /// No description provided for @daySat.
  ///
  /// In id, this message translates to:
  /// **'Sab'**
  String get daySat;

  /// No description provided for @workDay.
  ///
  /// In id, this message translates to:
  /// **'Hari Kerja'**
  String get workDay;

  /// No description provided for @dayOff.
  ///
  /// In id, this message translates to:
  /// **'Libur'**
  String get dayOff;

  /// No description provided for @sppgHoliday.
  ///
  /// In id, this message translates to:
  /// **'Libur SPPG'**
  String get sppgHoliday;

  /// No description provided for @leave.
  ///
  /// In id, this message translates to:
  /// **'Cuti'**
  String get leave;

  /// No description provided for @kitchenDivision.
  ///
  /// In id, this message translates to:
  /// **'Divisi Dapur'**
  String get kitchenDivision;

  /// No description provided for @shiftHours.
  ///
  /// In id, this message translates to:
  /// **'Jam Shift'**
  String get shiftHours;

  /// No description provided for @lateTolerance.
  ///
  /// In id, this message translates to:
  /// **'Toleransi Telat'**
  String get lateTolerance;

  /// No description provided for @scheduleStatus.
  ///
  /// In id, this message translates to:
  /// **'Status Jadwal'**
  String get scheduleStatus;

  /// No description provided for @workDayUpper.
  ///
  /// In id, this message translates to:
  /// **'HARI KERJA'**
  String get workDayUpper;

  /// No description provided for @dayOffUpper.
  ///
  /// In id, this message translates to:
  /// **'LIBUR'**
  String get dayOffUpper;

  /// No description provided for @sppgHolidayUpper.
  ///
  /// In id, this message translates to:
  /// **'LIBUR SPPG'**
  String get sppgHolidayUpper;

  /// No description provided for @annualLeaveUpper.
  ///
  /// In id, this message translates to:
  /// **'CUTI TAHUNAN'**
  String get annualLeaveUpper;

  /// No description provided for @dayOffSlashUpper.
  ///
  /// In id, this message translates to:
  /// **'LIBUR / OFF'**
  String get dayOffSlashUpper;

  /// No description provided for @leaveQuotaUpper.
  ///
  /// In id, this message translates to:
  /// **'KUOTA CUTI'**
  String get leaveQuotaUpper;

  /// No description provided for @daysCount.
  ///
  /// In id, this message translates to:
  /// **'{count} Hari'**
  String daysCount(int count);

  /// No description provided for @attendanceCheckInTitle.
  ///
  /// In id, this message translates to:
  /// **'Presensi Kehadiran'**
  String get attendanceCheckInTitle;

  /// No description provided for @attendanceCheckOutTitle.
  ///
  /// In id, this message translates to:
  /// **'Presensi Pulang'**
  String get attendanceCheckOutTitle;

  /// No description provided for @confirmClockIn.
  ///
  /// In id, this message translates to:
  /// **'Konfirmasi Clock-In (Masuk)'**
  String get confirmClockIn;

  /// No description provided for @confirmClockOut.
  ///
  /// In id, this message translates to:
  /// **'Konfirmasi Clock-Out (Pulang)'**
  String get confirmClockOut;

  /// No description provided for @singleCameraNotice.
  ///
  /// In id, this message translates to:
  /// **'Hanya 1 kamera tersedia atau menggunakan simulasi.'**
  String get singleCameraNotice;

  /// No description provided for @faceFrameInstruction.
  ///
  /// In id, this message translates to:
  /// **'Pastikan wajah terlihat jelas di dalam bingkai tanpa masker'**
  String get faceFrameInstruction;

  /// No description provided for @clockInEntryUpper.
  ///
  /// In id, this message translates to:
  /// **'CLOCK-IN MASUK'**
  String get clockInEntryUpper;

  /// No description provided for @totalWorkDurationUpper.
  ///
  /// In id, this message translates to:
  /// **'TOTAL DURASI KERJA'**
  String get totalWorkDurationUpper;

  /// No description provided for @kitchenLocationVerified.
  ///
  /// In id, this message translates to:
  /// **'Lokasi Dapur Terverifikasi'**
  String get kitchenLocationVerified;

  /// No description provided for @withinRadius.
  ///
  /// In id, this message translates to:
  /// **'Dalam Radius'**
  String get withinRadius;

  /// No description provided for @outsideRadius.
  ///
  /// In id, this message translates to:
  /// **'Luar Radius'**
  String get outsideRadius;

  /// No description provided for @attendanceHistory.
  ///
  /// In id, this message translates to:
  /// **'Riwayat Absen'**
  String get attendanceHistory;

  /// No description provided for @noDataForFilter.
  ///
  /// In id, this message translates to:
  /// **'Belum ada data untuk filter ini'**
  String get noDataForFilter;

  /// No description provided for @showLess.
  ///
  /// In id, this message translates to:
  /// **'Tampilkan Lebih Sedikit  ↑'**
  String get showLess;

  /// No description provided for @showAllThisMonth.
  ///
  /// In id, this message translates to:
  /// **'Tampilkan Semua di Bulan Ini ({count})  ↓'**
  String showAllThisMonth(int count);

  /// No description provided for @filterAll.
  ///
  /// In id, this message translates to:
  /// **'Semua'**
  String get filterAll;

  /// No description provided for @filterPresent.
  ///
  /// In id, this message translates to:
  /// **'Hadir'**
  String get filterPresent;

  /// No description provided for @filterLate.
  ///
  /// In id, this message translates to:
  /// **'Telat'**
  String get filterLate;

  /// No description provided for @filterLeave.
  ///
  /// In id, this message translates to:
  /// **'Cuti & Izin'**
  String get filterLeave;

  /// No description provided for @presentUpper.
  ///
  /// In id, this message translates to:
  /// **'HADIR'**
  String get presentUpper;

  /// No description provided for @lateUpper.
  ///
  /// In id, this message translates to:
  /// **'TELAT'**
  String get lateUpper;

  /// No description provided for @leaveUpper.
  ///
  /// In id, this message translates to:
  /// **'CUTI/IZIN'**
  String get leaveUpper;

  /// No description provided for @waitingUpper.
  ///
  /// In id, this message translates to:
  /// **'MENUNGGU'**
  String get waitingUpper;

  /// No description provided for @correctionSubmitted.
  ///
  /// In id, this message translates to:
  /// **'Koreksi Diajukan'**
  String get correctionSubmitted;

  /// No description provided for @durationPrefix.
  ///
  /// In id, this message translates to:
  /// **'Durasi: {duration}'**
  String durationPrefix(String duration);

  /// No description provided for @requestCorrection.
  ///
  /// In id, this message translates to:
  /// **'Ajukan Koreksi'**
  String get requestCorrection;

  /// No description provided for @requestAttendanceCorrection.
  ///
  /// In id, this message translates to:
  /// **'Ajukan Koreksi Absensi'**
  String get requestAttendanceCorrection;

  /// No description provided for @correctionReasonHint.
  ///
  /// In id, this message translates to:
  /// **'Tuliskan alasan koreksi (misal: kendala GPS atau tugas distribusi bahan)...'**
  String get correctionReasonHint;

  /// No description provided for @attendanceTimeCorrection.
  ///
  /// In id, this message translates to:
  /// **'Koreksi jam kehadiran'**
  String get attendanceTimeCorrection;

  /// No description provided for @submitCorrectionRequest.
  ///
  /// In id, this message translates to:
  /// **'Kirim Pengajuan Koreksi'**
  String get submitCorrectionRequest;

  /// No description provided for @payrollTitle.
  ///
  /// In id, this message translates to:
  /// **'Payroll'**
  String get payrollTitle;

  /// No description provided for @payrollHeaderSubtitle.
  ///
  /// In id, this message translates to:
  /// **'SPPG Rawamangun 01 • Closing Tgl 25'**
  String get payrollHeaderSubtitle;

  /// No description provided for @payslipList.
  ///
  /// In id, this message translates to:
  /// **'Daftar Slip Gaji'**
  String get payslipList;

  /// No description provided for @yearLabel.
  ///
  /// In id, this message translates to:
  /// **'Tahun {year}'**
  String yearLabel(int year);

  /// No description provided for @latestBadge.
  ///
  /// In id, this message translates to:
  /// **'Terbaru'**
  String get latestBadge;

  /// No description provided for @attendanceUpper.
  ///
  /// In id, this message translates to:
  /// **'KEHADIRAN'**
  String get attendanceUpper;

  /// No description provided for @leaveSlashUpper.
  ///
  /// In id, this message translates to:
  /// **'CUTI / IZIN'**
  String get leaveSlashUpper;

  /// No description provided for @latePenaltyUpper.
  ///
  /// In id, this message translates to:
  /// **'DENDA TELAT'**
  String get latePenaltyUpper;

  /// No description provided for @viewSlipDetails.
  ///
  /// In id, this message translates to:
  /// **'Lihat Rincian Slip'**
  String get viewSlipDetails;

  /// No description provided for @penaltiesAndAllowances.
  ///
  /// In id, this message translates to:
  /// **'Rincian Denda & Tunjangan'**
  String get penaltiesAndAllowances;

  /// No description provided for @payslipDetailTitle.
  ///
  /// In id, this message translates to:
  /// **'Detail Slip Gaji'**
  String get payslipDetailTitle;

  /// No description provided for @paidStatus.
  ///
  /// In id, this message translates to:
  /// **'Terbayar'**
  String get paidStatus;

  /// No description provided for @kitchenUnitUpper.
  ///
  /// In id, this message translates to:
  /// **'UNIT DAPUR'**
  String get kitchenUnitUpper;

  /// No description provided for @approved.
  ///
  /// In id, this message translates to:
  /// **'Disetujui'**
  String get approved;

  /// No description provided for @earningsUpper.
  ///
  /// In id, this message translates to:
  /// **'PENDAPATAN (+)'**
  String get earningsUpper;

  /// No description provided for @basePositionSalary.
  ///
  /// In id, this message translates to:
  /// **'Gaji Pokok Posisi'**
  String get basePositionSalary;

  /// No description provided for @attendanceAndPositionAllowance.
  ///
  /// In id, this message translates to:
  /// **'Tunjangan Hadir & Jabatan'**
  String get attendanceAndPositionAllowance;

  /// No description provided for @totalGrossEarnings.
  ///
  /// In id, this message translates to:
  /// **'Total Pendapatan Kotor'**
  String get totalGrossEarnings;

  /// No description provided for @deductionsUpper.
  ///
  /// In id, this message translates to:
  /// **'POTONGAN (-)'**
  String get deductionsUpper;

  /// No description provided for @totalNetReceived.
  ///
  /// In id, this message translates to:
  /// **'Total Diterima (Bersih)'**
  String get totalNetReceived;

  /// No description provided for @afterPenaltiesAndTax.
  ///
  /// In id, this message translates to:
  /// **'Sudah dipotong denda & pajak'**
  String get afterPenaltiesAndTax;

  /// No description provided for @destinationAccount.
  ///
  /// In id, this message translates to:
  /// **'Rekening Tujuan'**
  String get destinationAccount;

  /// No description provided for @disbursementDate.
  ///
  /// In id, this message translates to:
  /// **'Tanggal Pencairan'**
  String get disbursementDate;

  /// No description provided for @officialPayslipFooter.
  ///
  /// In id, this message translates to:
  /// **'Dokumen resmi terverifikasi sistem payroll SIM-SPPG'**
  String get officialPayslipFooter;

  /// No description provided for @payslipDownloaded.
  ///
  /// In id, this message translates to:
  /// **'Slip Gaji (PDF) berhasil diunduh ke perangkat Anda.'**
  String get payslipDownloaded;

  /// No description provided for @downloadPayslipPdf.
  ///
  /// In id, this message translates to:
  /// **'Unduh Slip Gaji (PDF)'**
  String get downloadPayslipPdf;

  /// No description provided for @totalAllowanceUpper.
  ///
  /// In id, this message translates to:
  /// **'TOTAL TUNJANGAN'**
  String get totalAllowanceUpper;

  /// No description provided for @attendanceAndRole.
  ///
  /// In id, this message translates to:
  /// **'Hadir & Jabatan'**
  String get attendanceAndRole;

  /// No description provided for @totalLatePenaltyUpper.
  ///
  /// In id, this message translates to:
  /// **'TOTAL DENDA TELAT'**
  String get totalLatePenaltyUpper;

  /// No description provided for @lateLogThisPeriod.
  ///
  /// In id, this message translates to:
  /// **'Log Keterlambatan Periode Ini'**
  String get lateLogThisPeriod;

  /// No description provided for @viewInHistory.
  ///
  /// In id, this message translates to:
  /// **'Lihat di Riwayat'**
  String get viewInHistory;

  /// No description provided for @activeAllowanceBreakdown.
  ///
  /// In id, this message translates to:
  /// **'Rincian Tunjangan Aktif'**
  String get activeAllowanceBreakdown;

  /// No description provided for @attendanceAllowance.
  ///
  /// In id, this message translates to:
  /// **'Tunjangan Kehadiran'**
  String get attendanceAllowance;

  /// No description provided for @positionAllowance.
  ///
  /// In id, this message translates to:
  /// **'Tunjangan Posisi (Ahli Gizi)'**
  String get positionAllowance;

  /// No description provided for @totalAllowanceThisPeriod.
  ///
  /// In id, this message translates to:
  /// **'Total Tunjangan Periode Ini'**
  String get totalAllowanceThisPeriod;

  /// No description provided for @payrollPolicyTitle.
  ///
  /// In id, this message translates to:
  /// **'Ketentuan Payroll SPPG'**
  String get payrollPolicyTitle;

  /// No description provided for @notificationsTitle.
  ///
  /// In id, this message translates to:
  /// **'Notifikasi'**
  String get notificationsTitle;

  /// No description provided for @allNotificationsMarkedRead.
  ///
  /// In id, this message translates to:
  /// **'Semua notifikasi ditandai sudah dibaca'**
  String get allNotificationsMarkedRead;

  /// No description provided for @markAsRead.
  ///
  /// In id, this message translates to:
  /// **'Tandai dibaca'**
  String get markAsRead;

  /// No description provided for @todayUpper.
  ///
  /// In id, this message translates to:
  /// **'HARI INI'**
  String get todayUpper;

  /// No description provided for @messagesCount.
  ///
  /// In id, this message translates to:
  /// **'{count} Pesan'**
  String messagesCount(int count);

  /// No description provided for @noNotifications.
  ///
  /// In id, this message translates to:
  /// **'Tidak ada notifikasi'**
  String get noNotifications;

  /// No description provided for @filterAllUnread.
  ///
  /// In id, this message translates to:
  /// **'Semua ({count})'**
  String filterAllUnread(int count);

  /// No description provided for @filterOperational.
  ///
  /// In id, this message translates to:
  /// **'Operasional'**
  String get filterOperational;

  /// No description provided for @filterApproval.
  ///
  /// In id, this message translates to:
  /// **'Persetujuan'**
  String get filterApproval;

  /// No description provided for @unread.
  ///
  /// In id, this message translates to:
  /// **'Belum dibaca'**
  String get unread;

  /// No description provided for @read.
  ///
  /// In id, this message translates to:
  /// **'Sudah dibaca'**
  String get read;

  /// No description provided for @leaveRequestTitle.
  ///
  /// In id, this message translates to:
  /// **'Pengajuan Cuti & Izin'**
  String get leaveRequestTitle;

  /// No description provided for @annualLeave.
  ///
  /// In id, this message translates to:
  /// **'Cuti Tahunan'**
  String get annualLeave;

  /// No description provided for @sickLeave.
  ///
  /// In id, this message translates to:
  /// **'Izin Sakit'**
  String get sickLeave;

  /// No description provided for @emergencyLeave.
  ///
  /// In id, this message translates to:
  /// **'Izin Darurat'**
  String get emergencyLeave;

  /// No description provided for @annualLeaveQuotaTitle.
  ///
  /// In id, this message translates to:
  /// **'Kuota Cuti Tahunan 2026'**
  String get annualLeaveQuotaTitle;

  /// No description provided for @annualLeavePolicyDesc.
  ///
  /// In id, this message translates to:
  /// **'Cuti tahunan diajukan min. H-2. Izin sakit/darurat dapat diajukan hari-H tanpa memotong kuota.'**
  String get annualLeavePolicyDesc;

  /// No description provided for @selectSubmissionDate.
  ///
  /// In id, this message translates to:
  /// **'Pilih Tanggal Pengajuan'**
  String get selectSubmissionDate;

  /// No description provided for @startDate.
  ///
  /// In id, this message translates to:
  /// **'Tanggal Mulai'**
  String get startDate;

  /// No description provided for @endDate.
  ///
  /// In id, this message translates to:
  /// **'Tanggal Selesai'**
  String get endDate;

  /// No description provided for @durationWorkDays.
  ///
  /// In id, this message translates to:
  /// **'• Durasi: {days} Hari Kerja'**
  String durationWorkDays(int days);

  /// No description provided for @remainingBalancePrefix.
  ///
  /// In id, this message translates to:
  /// **'Sisa Saldo: '**
  String get remainingBalancePrefix;

  /// No description provided for @fixedBalancePrefix.
  ///
  /// In id, this message translates to:
  /// **'Saldo Tetap: '**
  String get fixedBalancePrefix;

  /// No description provided for @reasonOrNotes.
  ///
  /// In id, this message translates to:
  /// **'Alasan / Keterangan'**
  String get reasonOrNotes;

  /// No description provided for @reasonHint.
  ///
  /// In id, this message translates to:
  /// **'Tuliskan alasan pengajuan cuti secara singkat...'**
  String get reasonHint;

  /// No description provided for @attachEvidence.
  ///
  /// In id, this message translates to:
  /// **'Lampirkan Bukti'**
  String get attachEvidence;

  /// No description provided for @savedFileMeta.
  ///
  /// In id, this message translates to:
  /// **'Tersimpan • 1.2 MB'**
  String get savedFileMeta;

  /// No description provided for @evidenceOptionalHint.
  ///
  /// In id, this message translates to:
  /// **'Opsional untuk cuti • Wajib menyusul maks. 2x24 jam untuk Izin Sakit (JPG, PNG, PDF • Maks. 2MB)'**
  String get evidenceOptionalHint;

  /// No description provided for @forwardedToCoordinator.
  ///
  /// In id, this message translates to:
  /// **'Akan diteruskan ke Koordinator Unit SPPG Rawamangun 01.'**
  String get forwardedToCoordinator;

  /// No description provided for @submitRequest.
  ///
  /// In id, this message translates to:
  /// **'Kirim Pengajuan'**
  String get submitRequest;

  /// No description provided for @fileAttachedSuccess.
  ///
  /// In id, this message translates to:
  /// **'File \"{fileName}\" berhasil dilampirkan.'**
  String fileAttachedSuccess(String fileName);

  /// No description provided for @quotaFree.
  ///
  /// In id, this message translates to:
  /// **'Bebas Kuota'**
  String get quotaFree;

  /// No description provided for @noQuotaDeduction.
  ///
  /// In id, this message translates to:
  /// **'Tidak Potong Kuota'**
  String get noQuotaDeduction;

  /// No description provided for @sickLeaveTerms.
  ///
  /// In id, this message translates to:
  /// **'Ketentuan Izin Sakit'**
  String get sickLeaveTerms;

  /// No description provided for @selectSickDate.
  ///
  /// In id, this message translates to:
  /// **'Pilih Tanggal Sakit'**
  String get selectSickDate;

  /// No description provided for @sickReasonLabel.
  ///
  /// In id, this message translates to:
  /// **'Alasan / Keluhan Sakit'**
  String get sickReasonLabel;

  /// No description provided for @sickReasonHint.
  ///
  /// In id, this message translates to:
  /// **'Tuliskan keluhan atau gejala sakit...'**
  String get sickReasonHint;

  /// No description provided for @sendReportToKsppg.
  ///
  /// In id, this message translates to:
  /// **'Kirim Laporan ke KSPPG'**
  String get sendReportToKsppg;

  /// No description provided for @waitingSickEvidence.
  ///
  /// In id, this message translates to:
  /// **'Menunggu Bukti Sakit'**
  String get waitingSickEvidence;

  /// No description provided for @uploadDeadline2x24.
  ///
  /// In id, this message translates to:
  /// **'Batas Akhir Unggah (2x24 Jam)'**
  String get uploadDeadline2x24;

  /// No description provided for @sickReportReceivedNotice.
  ///
  /// In id, this message translates to:
  /// **'Laporan awal sudah diterima KSPPG. Wajib unggah surat dokter/bukti sebelum batas waktu berakhir.'**
  String get sickReportReceivedNotice;

  /// No description provided for @submittedReportSummary.
  ///
  /// In id, this message translates to:
  /// **'Ringkasan Laporan Terkirim'**
  String get submittedReportSummary;

  /// No description provided for @receivedByKsppg.
  ///
  /// In id, this message translates to:
  /// **'✓ Diterima KSPPG'**
  String get receivedByKsppg;

  /// No description provided for @sickDate.
  ///
  /// In id, this message translates to:
  /// **'Tanggal Sakit'**
  String get sickDate;

  /// No description provided for @symptoms.
  ///
  /// In id, this message translates to:
  /// **'Keluhan'**
  String get symptoms;

  /// No description provided for @attachSickEvidence.
  ///
  /// In id, this message translates to:
  /// **'Lampirkan Bukti Sakit'**
  String get attachSickEvidence;

  /// No description provided for @uploadRequired.
  ///
  /// In id, this message translates to:
  /// **'Wajib Diunggah'**
  String get uploadRequired;

  /// No description provided for @fileSelectedReady.
  ///
  /// In id, this message translates to:
  /// **'File terpilih • Siap dikirim'**
  String get fileSelectedReady;

  /// No description provided for @takePhotoOrPickDoc.
  ///
  /// In id, this message translates to:
  /// **'Ambil Foto atau Pilih Dokumen'**
  String get takePhotoOrPickDoc;

  /// No description provided for @sickDocHint.
  ///
  /// In id, this message translates to:
  /// **'Surat keterangan dokter, resep obat, atau bukti klinik (JPG, PNG, PDF • Maks. 2MB)'**
  String get sickDocHint;

  /// No description provided for @submitSickEvidence.
  ///
  /// In id, this message translates to:
  /// **'Kirim Bukti Sakit'**
  String get submitSickEvidence;

  /// No description provided for @emergencyLeaveTerms.
  ///
  /// In id, this message translates to:
  /// **'Ketentuan Izin Darurat'**
  String get emergencyLeaveTerms;

  /// No description provided for @emergencyLeavePolicyDesc.
  ///
  /// In id, this message translates to:
  /// **'Khusus kondisi mendesak hari-H (musibah keluarga, kendala perjalanan, atau bencana) tanpa memotong jatah cuti tahunan.'**
  String get emergencyLeavePolicyDesc;

  /// No description provided for @emergencyTypeAndTime.
  ///
  /// In id, this message translates to:
  /// **'Jenis & Waktu Darurat'**
  String get emergencyTypeAndTime;

  /// No description provided for @absentFullDay.
  ///
  /// In id, this message translates to:
  /// **'Tidak Masuk (Full)'**
  String get absentFullDay;

  /// No description provided for @latePermission.
  ///
  /// In id, this message translates to:
  /// **'Izin Terlambat'**
  String get latePermission;

  /// No description provided for @shiftDate.
  ///
  /// In id, this message translates to:
  /// **'Tanggal Shift'**
  String get shiftDate;

  /// No description provided for @estimatedArrivalTime.
  ///
  /// In id, this message translates to:
  /// **'Estimasi Jam Tiba'**
  String get estimatedArrivalTime;

  /// No description provided for @emergencyCategory.
  ///
  /// In id, this message translates to:
  /// **'Kategori Kondisi Darurat'**
  String get emergencyCategory;

  /// No description provided for @selectEmergencyCategory.
  ///
  /// In id, this message translates to:
  /// **'Pilih Kategori Kondisi Darurat'**
  String get selectEmergencyCategory;

  /// No description provided for @emergencyCategoryExample.
  ///
  /// In id, this message translates to:
  /// **'Contoh: Keluarga rawat darurat, kendaraan mogok, banjir/bencana, dll.'**
  String get emergencyCategoryExample;

  /// No description provided for @shortDescription.
  ///
  /// In id, this message translates to:
  /// **'Keterangan Singkat'**
  String get shortDescription;

  /// No description provided for @emergencyReasonHint.
  ///
  /// In id, this message translates to:
  /// **'Jelaskan kondisi darurat secara singkat...'**
  String get emergencyReasonHint;

  /// No description provided for @emergencyEvidenceHint.
  ///
  /// In id, this message translates to:
  /// **'Unggah foto kondisi di tempat, surat IGD, atau\ntangkapan layar (JPG, PNG, PDF • Maks. 2MB)'**
  String get emergencyEvidenceHint;

  /// No description provided for @forwardedAsPriority.
  ///
  /// In id, this message translates to:
  /// **'Akan diteruskan sebagai prioritas ke Koordinator Unit SPPG\nRawamangun 01.'**
  String get forwardedAsPriority;

  /// No description provided for @submitLatePermission.
  ///
  /// In id, this message translates to:
  /// **'Kirim Izin Terlambat'**
  String get submitLatePermission;

  /// No description provided for @submitEmergencyLeave.
  ///
  /// In id, this message translates to:
  /// **'Kirim Izin Darurat'**
  String get submitEmergencyLeave;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'id'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'id':
      return AppLocalizationsId();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
