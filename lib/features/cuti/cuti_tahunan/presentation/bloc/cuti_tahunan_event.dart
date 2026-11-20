import 'package:equatable/equatable.dart';

abstract class CutiTahunanEvent extends Equatable {
  const CutiTahunanEvent();

  @override
  List<Object?> get props => [];
}

class LoadCutiTahunanInitialEvent extends CutiTahunanEvent {
  const LoadCutiTahunanInitialEvent();
}

class UpdateCutiTahunanDatesEvent extends CutiTahunanEvent {
  final DateTime? startDate;
  final DateTime? endDate;

  const UpdateCutiTahunanDatesEvent({this.startDate, this.endDate});

  @override
  List<Object?> get props => [startDate, endDate];
}

class UpdateCutiTahunanReasonEvent extends CutiTahunanEvent {
  final String reason;

  const UpdateCutiTahunanReasonEvent(this.reason);

  @override
  List<Object?> get props => [reason];
}

class UpdateCutiTahunanAttachmentEvent extends CutiTahunanEvent {
  final String? attachmentName;

  const UpdateCutiTahunanAttachmentEvent(this.attachmentName);

  @override
  List<Object?> get props => [attachmentName];
}

class SubmitCutiTahunanFormEvent extends CutiTahunanEvent {
  const SubmitCutiTahunanFormEvent();
}
