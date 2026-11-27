import 'package:equatable/equatable.dart';

class AkunProfile extends Equatable {
  final String fullName;
  final String roleLabel;
  final String locationBadge;
  final String personnelId;
  final String workTenure;
  final String nik;
  final String email;
  final String whatsappNumber;
  final String payrollAccount;
  final String mainShiftSchedule;
  final String appVersionText;
  final String? avatarUrl;
  final bool isOnline;
  final String employmentStatus;
  final String birthPlaceDate;
  final String domicile;
  final String operationalDivision;
  final String joinDate;
  final String bankName;
  final String accountNumber;
  final String accountHolderName;
  final bool isPayrollVerified;
  final String bpjsStatus;

  const AkunProfile({
    required this.fullName,
    required this.roleLabel,
    required this.locationBadge,
    required this.personnelId,
    required this.workTenure,
    required this.nik,
    required this.email,
    required this.whatsappNumber,
    required this.payrollAccount,
    required this.mainShiftSchedule,
    required this.appVersionText,
    this.avatarUrl,
    this.isOnline = true,
    this.employmentStatus = 'Personel Aktif',
    this.birthPlaceDate = 'Jakarta, 14 Agu 1998',
    this.domicile = 'Rawamangun, Jakarta Timur',
    this.operationalDivision = 'Gizi & Pengawasan Mutu',
    this.joinDate = '01 Agustus 2025',
    this.bankName = 'Bank Rakyat Indonesia (BRI)',
    this.accountNumber = '0341-01-048291-50-9',
    this.accountHolderName = 'SITI RAHMAWATI',
    this.isPayrollVerified = true,
    this.bpjsStatus = 'Aktif • Ditanggung Lembaga',
  });

  @override
  List<Object?> get props => [
        fullName,
        roleLabel,
        locationBadge,
        personnelId,
        workTenure,
        nik,
        email,
        whatsappNumber,
        payrollAccount,
        mainShiftSchedule,
        appVersionText,
        avatarUrl,
        isOnline,
        employmentStatus,
        birthPlaceDate,
        domicile,
        operationalDivision,
        joinDate,
        bankName,
        accountNumber,
        accountHolderName,
        isPayrollVerified,
        bpjsStatus,
      ];
}
