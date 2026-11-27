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
    super.employmentStatus,
    super.birthPlaceDate,
    super.domicile,
    super.operationalDivision,
    super.joinDate,
    super.bankName,
    super.accountNumber,
    super.accountHolderName,
    super.isPayrollVerified,
    super.bpjsStatus,
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
      employmentStatus:
          json['employment_status']?.toString() ?? 'Personel Aktif',
      birthPlaceDate:
          json['birth_place_date']?.toString() ?? 'Jakarta, 14 Agu 1998',
      domicile: json['domicile']?.toString() ?? 'Rawamangun, Jakarta Timur',
      operationalDivision:
          json['operational_division']?.toString() ?? 'Gizi & Pengawasan Mutu',
      joinDate: json['join_date']?.toString() ?? '01 Agustus 2025',
      bankName:
          json['bank_name']?.toString() ?? 'Bank Rakyat Indonesia (BRI)',
      accountNumber:
          json['account_number']?.toString() ?? '0341-01-048291-50-9',
      accountHolderName:
          json['account_holder_name']?.toString() ?? 'SITI RAHMAWATI',
      isPayrollVerified: json['is_payroll_verified'] as bool? ?? true,
      bpjsStatus:
          json['bpjs_status']?.toString() ?? 'Aktif • Ditanggung Lembaga',
    );
  }
}
