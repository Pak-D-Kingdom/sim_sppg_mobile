import 'package:equatable/equatable.dart';
import '../../domain/entities/presensi_data.dart';

abstract class PresensiEvent extends Equatable {
  const PresensiEvent();

  @override
  List<Object?> get props => [];
}

class LoadPresensiStatusEvent extends PresensiEvent {
  final PresensiType? requestedType;

  const LoadPresensiStatusEvent({this.requestedType});

  @override
  List<Object?> get props => [requestedType];
}

class TogglePresensiTypeEvent extends PresensiEvent {
  final PresensiType type;

  const TogglePresensiTypeEvent(this.type);

  @override
  List<Object?> get props => [type];
}

class CaptureFacePhotoEvent extends PresensiEvent {
  final String photoPath;

  const CaptureFacePhotoEvent(this.photoPath);

  @override
  List<Object?> get props => [photoPath];
}

class SubmitPresensiEvent extends PresensiEvent {
  const SubmitPresensiEvent();
}
