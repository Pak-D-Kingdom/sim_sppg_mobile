import 'package:equatable/equatable.dart';
import '../../domain/entities/izin_sakit_entity.dart';

abstract class IzinSakitState extends Equatable {
  const IzinSakitState();

  @override
  List<Object?> get props => [];
}

class IzinSakitInitial extends IzinSakitState {
  const IzinSakitInitial();
}

class IzinSakitLoading extends IzinSakitState {
  const IzinSakitLoading();
}

class IzinSakitLoaded extends IzinSakitState {
  final IzinSakitData data;
  final String? successMessage;
  final String? errorMessage;

  const IzinSakitLoaded({
    required this.data,
    this.successMessage,
    this.errorMessage,
  });

  IzinSakitLoaded copyWith({
    IzinSakitData? data,
    String? successMessage,
    String? errorMessage,
    bool clearMessages = false,
  }) {
    return IzinSakitLoaded(
      data: data ?? this.data,
      successMessage: clearMessages ? null : successMessage,
      errorMessage: clearMessages ? null : errorMessage,
    );
  }

  @override
  List<Object?> get props => [data, successMessage, errorMessage];
}

class IzinSakitError extends IzinSakitState {
  final String message;

  const IzinSakitError(this.message);

  @override
  List<Object?> get props => [message];
}
