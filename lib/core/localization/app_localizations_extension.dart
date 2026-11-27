import 'package:material_ui/material_ui.dart';
import 'generated/app_localizations.dart';

export 'generated/app_localizations.dart';

extension AppLocalizationsX on BuildContext {
  AppLocalizations get l10n =>
      AppLocalizations.of(this) ?? lookupAppLocalizations(const Locale('id'));

  bool get isEnglish => l10n.localeName == 'en';

  /// Translates dynamic/mock Indonesian strings to English when active locale is 'en'.
  String localizeDynamic(String text) {
    if (!isEnglish || text.isEmpty) return text;
    return _translateDynamicIdToEn(text);
  }
}

String _translateDynamicIdToEn(String input) {
  // Exact phrase matches first (menus, badges, statuses)
  const exactMap = <String, String>{
    'Riwayat Absen': 'Attendance History',
    'Log kehadiran & koreksi': 'Attendance log & corrections',
    'Cuti & Izin': 'Leave & Permit',
    'Tahunan, sakit & darurat': 'Annual, sick & emergency',
    'Jadwal & Libur': 'Schedule & Holidays',
    'Rotasi shift tim dapur': 'Kitchen team shift rotation',
    'Slip Payroll': 'Payroll Slip',
    'Gaji & rincian denda': 'Salary & penalty details',
    'Terbayar': 'Paid',
    'Tepat Waktu': 'On Time',
    'Tanpa Denda': 'No Penalty',
    'Disetujui': 'Approved',
    'Menunggu ACC': 'Pending Approval',
    'Cuti Disetujui': 'Leave Approved',
    'Unggah Bukti': 'Upload Proof',
    'Terjadwal': 'Scheduled',
    'Libur Rutin': 'Regular Off',
    'Personel Aktif': 'Active Personnel',
    'Aktif • Ditanggung Lembaga': 'Active • Covered by Agency',
  };

  final exact = exactMap[input];
  if (exact != null) return exact;

  var result = input;

  // Pattern-based translations for dynamic counts & phrases
  result = result.replaceAllMapped(
    RegExp(r'\bSisa (\d+) menit\b'),
    (m) => '${m[1]} mins left',
  );
  result = result.replaceAllMapped(
    RegExp(r'\bSisa (\d+) jam\b'),
    (m) => '${m[1]} hrs left',
  );
  result = result.replaceAllMapped(
    RegExp(r'\bSisa (\d+)\b'),
    (m) => '${m[1]} Left',
  );
  result = result.replaceAllMapped(
    RegExp(r'\b(\d+)m dari titik (.+)$'),
    (m) => '${m[1]}m from ${m[2]}',
  );

  const phraseReplacements = <String, String>{
    'Wajib absen sebelum': 'Must clock in before',
    'Jadwal pulang shift pagi': 'Morning shift clock-out',
    'Jadwal pulang': 'Clock-out schedule',
    'Log telat & Insentif': 'Late log & Incentives',
    'Tanpa Denda': 'No Penalty',
    'Tepat Waktu': 'On Time',
    'Shift Pagi': 'Morning Shift',
    'Shift Siang': 'Afternoon Shift',
    'Shift Malam': 'Night Shift',
    'Hari Kerja': 'Work Days',
    'Hari': 'Days',
    'Jam': 'Hrs',
    'Menit': 'Mins',
    'Telat': 'Late',
    'Terbayar': 'Paid',
    'Disetujui': 'Approved',
    'Bukti dokter belum diunggah': 'Doctor note not uploaded yet',
    'Unggah Bukti': 'Upload Proof',
    'Sisa ': 'Left ',
    'dari titik ': 'from ',
    'Januari': 'January',
    'Februari': 'February',
    'Maret': 'March',
    'Mei': 'May',
    'Juni': 'June',
    'Juli': 'July',
    'Agustus': 'August',
    'Oktober': 'October',
    'Desember': 'December',
    'Ags': 'Aug',
    'Okt': 'Oct',
    'Des': 'Dec',
    'Senin': 'Monday',
    'Selasa': 'Tuesday',
    'Rabu': 'Wednesday',
    'Kamis': 'Thursday',
    'Jumat': 'Friday',
    'Sabtu': 'Saturday',
    'Minggu': 'Sunday',
    'Sen,': 'Mon,',
    'Sel,': 'Tue,',
    'Rab,': 'Wed,',
    'Kam,': 'Thu,',
    'Jum,': 'Fri,',
    'Sab,': 'Sat,',
    'Min,': 'Sun,',
  };

  for (final entry in phraseReplacements.entries) {
    if (result.contains(entry.key)) {
      result = result.replaceAll(entry.key, entry.value);
    }
  }

  return result;
}

class AppLocalizationsConfig {
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = [
    AppLocalizations.delegate,
    ...GlobalMaterialLocalizations.delegates,
  ];

  static const List<Locale> supportedLocales =
      AppLocalizations.supportedLocales;
}
