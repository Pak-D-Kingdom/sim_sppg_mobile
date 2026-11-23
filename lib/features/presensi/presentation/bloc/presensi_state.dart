import 'package:equatable/equatable.dart';
import '../../domain/entities/presensi_data.dart';

abstract class PresensiState extends Equatable {
  const PresensiState();

  @override
  List<Object?> get props => [];
}

class PresensiInitial extends PresensiState {
  const PresensiInitial();
}

class PresensiLoading extends PresensiState {
  const PresensiLoading();
}

class PresensiLoaded extends PresensiState {
  final PresensiData data;
  final bool isSubmitting;
  final String? successMessage;
  final String? errorMessage;

  const PresensiLoaded({
    required this.data,
    this.isSubmitting = false,
    this.successMessage,
    this.errorMessage,
  });

  PresensiLoaded copyWith({
    PresensiData? data,
    bool? isSubmitting,
    String? successMessage,
    String? errorMessage,
    bool clearMessages = false,
  }) {
    return PresensiLoaded(
      data: data ?? this.data,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      successMessage: clearMessages ? null : (successMessage ?? this.successMessage),
      errorMessage: clearMessages ? null : (errorMessage ?? this.errorMessage),
    );
  }

  @override
  List<Object?> get props => [
        data,
        isSubmitting,
        successMessage,
        errorMessage,
      ];
}

class PresensiError extends PresensiState {
  final String message;

  const PresensiError(this.message);

  @override
  List<Object?> get props => [message];
}
