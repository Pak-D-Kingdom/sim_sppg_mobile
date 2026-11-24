import 'package:equatable/equatable.dart';
import '../../domain/entities/akun_profile.dart';

abstract class AkunState extends Equatable {
  const AkunState();

  @override
  List<Object?> get props => [];
}

class AkunInitial extends AkunState {
  const AkunInitial();
}

class AkunLoading extends AkunState {
  const AkunLoading();
}

class AkunLoaded extends AkunState {
  final AkunProfile profile;

  const AkunLoaded({required this.profile});

  @override
  List<Object?> get props => [profile];
}

class AkunError extends AkunState {
  final String message;

  const AkunError(this.message);

  @override
  List<Object?> get props => [message];
}
