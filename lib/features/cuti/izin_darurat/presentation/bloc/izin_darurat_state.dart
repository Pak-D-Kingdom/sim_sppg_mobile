import 'package:equatable/equatable.dart';
import '../../domain/entities/izin_darurat_entity.dart';

abstract class IzinDaruratState extends Equatable {
  const IzinDaruratState();

  @override
  List<Object?> get props => [];
}

class IzinDaruratInitial extends IzinDaruratState {
  const IzinDaruratInitial();
}

class IzinDaruratLoading extends IzinDaruratState {
  const IzinDaruratLoading();
}

class IzinDaruratLoaded extends IzinDaruratState {
  final IzinDaruratData data;
  final String? successMessage;
  final String? errorMessage;

  const IzinDaruratLoaded({
    required this.data,
    this.successMessage,
    this.errorMessage,
  });

  IzinDaruratLoaded copyWith({
    IzinDaruratData? data,
    String? successMessage,
    String? errorMessage,
    bool clearMessages = false,
  }) {
    return IzinDaruratLoaded(
      data: data ?? this.data,
      successMessage: clearMessages ? null : (successMessage ?? this.successMessage),
      errorMessage: clearMessages ? null : (errorMessage ?? this.errorMessage),
    );
  }

  @override
  List<Object?> get props => [data, successMessage, errorMessage];
}

class IzinDaruratError extends IzinDaruratState {
  final String message;

  const IzinDaruratError(this.message);

  @override
  List<Object?> get props => [message];
}
