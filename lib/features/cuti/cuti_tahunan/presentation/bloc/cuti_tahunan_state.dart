import 'package:equatable/equatable.dart';
import '../../domain/entities/cuti_tahunan_entity.dart';

abstract class CutiTahunanState extends Equatable {
  const CutiTahunanState();

  @override
  List<Object?> get props => [];
}

class CutiTahunanInitial extends CutiTahunanState {
  const CutiTahunanInitial();
}

class CutiTahunanLoading extends CutiTahunanState {
  const CutiTahunanLoading();
}

class CutiTahunanLoaded extends CutiTahunanState {
  final CutiTahunanQuota quota;
  final CutiTahunanFormData formData;
  final bool isSubmitting;
  final String? successMessage;
  final String? errorMessage;

  const CutiTahunanLoaded({
    required this.quota,
    required this.formData,
    this.isSubmitting = false,
    this.successMessage,
    this.errorMessage,
  });

  CutiTahunanLoaded copyWith({
    CutiTahunanQuota? quota,
    CutiTahunanFormData? formData,
    bool? isSubmitting,
    String? successMessage,
    String? errorMessage,
    bool clearMessages = false,
  }) {
    return CutiTahunanLoaded(
      quota: quota ?? this.quota,
      formData: formData ?? this.formData,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      successMessage: clearMessages ? null : successMessage,
      errorMessage: clearMessages ? null : errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        quota,
        formData,
        isSubmitting,
        successMessage,
        errorMessage,
      ];
}

class CutiTahunanError extends CutiTahunanState {
  final String message;

  const CutiTahunanError(this.message);

  @override
  List<Object?> get props => [message];
}
