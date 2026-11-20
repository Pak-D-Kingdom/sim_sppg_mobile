import 'package:equatable/equatable.dart';
import '../../domain/entities/cuti_type.dart';

abstract class CutiEvent extends Equatable {
  const CutiEvent();

  @override
  List<Object?> get props => [];
}

class LoadCutiInitialEvent extends CutiEvent {
  const LoadCutiInitialEvent();
}

class ChangeCutiTypeEvent extends CutiEvent {
  final CutiType cutiType;

  const ChangeCutiTypeEvent(this.cutiType);

  @override
  List<Object?> get props => [cutiType];
}

class UpdateCutiDatesEvent extends CutiEvent {
  final DateTime? startDate;
  final DateTime? endDate;

  const UpdateCutiDatesEvent({this.startDate, this.endDate});

  @override
  List<Object?> get props => [startDate, endDate];
}

class UpdateCutiReasonEvent extends CutiEvent {
  final String reason;

  const UpdateCutiReasonEvent(this.reason);

  @override
  List<Object?> get props => [reason];
}

class UpdateCutiAttachmentEvent extends CutiEvent {
  final String? attachmentName;

  const UpdateCutiAttachmentEvent(this.attachmentName);

  @override
  List<Object?> get props => [attachmentName];
}

class SubmitCutiFormEvent extends CutiEvent {
  const SubmitCutiFormEvent();
}
