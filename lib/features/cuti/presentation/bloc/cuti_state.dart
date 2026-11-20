import 'package:equatable/equatable.dart';
import '../../domain/entities/cuti_quota.dart';
import '../../domain/entities/cuti_type.dart';

abstract class CutiState extends Equatable {
  const CutiState();

  @override
  List<Object?> get props => [];
}

class CutiInitial extends CutiState {
  const CutiInitial();
}

class CutiLoading extends CutiState {
  const CutiLoading();
}

class CutiLoaded extends CutiState {
  final CutiQuota quota;
  final CutiType selectedType;
  final DateTime startDate;
  final DateTime endDate;
  final int durationDays;
  final int remainingAfter;
  final String reason;
  final String? attachmentName;
  final bool isSubmitting;
  final String? successMessage;
  final String? errorMessage;

  const CutiLoaded({
    required this.quota,
    required this.selectedType,
    required this.startDate,
    required this.endDate,
    required this.durationDays,
    required this.remainingAfter,
    required this.reason,
    this.attachmentName,
    this.isSubmitting = false,
    this.successMessage,
    this.errorMessage,
  });

  CutiLoaded copyWith({
    CutiQuota? quota,
    CutiType? selectedType,
    DateTime? startDate,
    DateTime? endDate,
    int? durationDays,
    int? remainingAfter,
    String? reason,
    String? attachmentName,
    bool? isSubmitting,
    String? successMessage,
    String? errorMessage,
    bool clearAttachment = false,
    bool clearMessages = false,
  }) {
    return CutiLoaded(
      quota: quota ?? this.quota,
      selectedType: selectedType ?? this.selectedType,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      durationDays: durationDays ?? this.durationDays,
      remainingAfter: remainingAfter ?? this.remainingAfter,
      reason: reason ?? this.reason,
      attachmentName:
          clearAttachment ? null : (attachmentName ?? this.attachmentName),
      isSubmitting: isSubmitting ?? this.isSubmitting,
      successMessage: clearMessages ? null : successMessage,
      errorMessage: clearMessages ? null : errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        quota,
        selectedType,
        startDate,
        endDate,
        durationDays,
        remainingAfter,
        reason,
        attachmentName,
        isSubmitting,
        successMessage,
        errorMessage,
      ];
}

class CutiError extends CutiState {
  final String message;

  const CutiError({required this.message});

  @override
  List<Object?> get props => [message];
}
