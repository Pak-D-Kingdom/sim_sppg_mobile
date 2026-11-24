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
      ];
}
