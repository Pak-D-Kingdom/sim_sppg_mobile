import '../../domain/entities/akun_profile.dart';

class AkunProfileModel extends AkunProfile {
  const AkunProfileModel({
    required super.fullName,
    required super.roleLabel,
    required super.locationBadge,
    required super.personnelId,
    required super.workTenure,
    required super.nik,
    required super.email,
    required super.whatsappNumber,
    required super.payrollAccount,
    required super.mainShiftSchedule,
    required super.appVersionText,
    super.avatarUrl,
    super.isOnline,
  });

  factory AkunProfileModel.fromJson(Map<String, dynamic> json) {
    return AkunProfileModel(
      fullName: json['full_name']?.toString() ?? 'Siti Rahmawati, A.Md.Gz',
      roleLabel: json['role_label']?.toString() ?? 'Ahli Gizi • Pelaksana Gizi',
      locationBadge:
          json['location_badge']?.toString() ?? 'SPPG Rawamangun 01',
      personnelId: json['personnel_id']?.toString() ?? 'SPPG-RMG-014',
      workTenure: json['work_tenure']?.toString() ?? '1 Thn 4 Bln',
      nik: json['nik']?.toString() ?? '3175025408980004',
      email: json['email']?.toString() ?? 'siti.rahmawati@sppg.go.id',
      whatsappNumber: json['whatsapp_number']?.toString() ?? '0812-8490-3321',
      payrollAccount:
          json['payroll_account']?.toString() ?? 'BRI •••• 4829 (Terverifikasi)',
      mainShiftSchedule:
          json['main_shift_schedule']?.toString() ?? 'Shift Pagi (05:00 - 13:00)',
      appVersionText: json['app_version_text']?.toString() ??
          'SIM-SPPG Mobile v2.4.0 • Badan Gizi Nasional',
      avatarUrl: json['avatar_url']?.toString(),
      isOnline: json['is_online'] as bool? ?? true,
    );
  }
}
