import 'package:equatable/equatable.dart';

abstract class IzinSakitEvent extends Equatable {
  const IzinSakitEvent();

  @override
  List<Object?> get props => [];
}

class LoadIzinSakitInitialEvent extends IzinSakitEvent {
  const LoadIzinSakitInitialEvent();
}

class UpdateIzinSakitDatesEvent extends IzinSakitEvent {
  final DateTime? startDate;
  final DateTime? endDate;

  const UpdateIzinSakitDatesEvent({this.startDate, this.endDate});

  @override
  List<Object?> get props => [startDate, endDate];
}

class UpdateIzinSakitKeluhanEvent extends IzinSakitEvent {
  final String keluhan;

  const UpdateIzinSakitKeluhanEvent(this.keluhan);

  @override
  List<Object?> get props => [keluhan];
}

class SubmitLaporanSakitEvent extends IzinSakitEvent {
  const SubmitLaporanSakitEvent();
}

class PickBuktiSakitEvent extends IzinSakitEvent {
  final String attachmentName;

  const PickBuktiSakitEvent(this.attachmentName);

  @override
  List<Object?> get props => [attachmentName];
}

class RemoveBuktiSakitEvent extends IzinSakitEvent {
  const RemoveBuktiSakitEvent();
}

class SubmitBuktiSakitEvent extends IzinSakitEvent {
  const SubmitBuktiSakitEvent();
}
