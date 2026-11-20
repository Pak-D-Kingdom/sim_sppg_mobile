import 'package:equatable/equatable.dart';
import 'cuti_type.dart';

class CutiFormData extends Equatable {
  final CutiType cutiType;
  final DateTime startDate;
  final DateTime endDate;
  final int durationDays;
  final int remainingAfterSubmission;
  final String reason;
  final String? attachmentName;
  final String destinationCoordinator;

  const CutiFormData({
    required this.cutiType,
    required this.startDate,
    required this.endDate,
    required this.durationDays,
    required this.remainingAfterSubmission,
    required this.reason,
    this.attachmentName,
    this.destinationCoordinator =
        'Koordinator Unit SPPG Rawamangun 01',
  });

  CutiFormData copyWith({
    CutiType? cutiType,
    DateTime? startDate,
    DateTime? endDate,
    int? durationDays,
    int? remainingAfterSubmission,
    String? reason,
    String? attachmentName,
    String? destinationCoordinator,
  }) {
    return CutiFormData(
      cutiType: cutiType ?? this.cutiType,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      durationDays: durationDays ?? this.durationDays,
      remainingAfterSubmission:
          remainingAfterSubmission ?? this.remainingAfterSubmission,
      reason: reason ?? this.reason,
      attachmentName: attachmentName ?? this.attachmentName,
      destinationCoordinator:
          destinationCoordinator ?? this.destinationCoordinator,
    );
  }

  @override
  List<Object?> get props => [
        cutiType,
        startDate,
        endDate,
        durationDays,
        remainingAfterSubmission,
        reason,
        attachmentName,
        destinationCoordinator,
      ];
}
