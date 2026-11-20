import 'package:equatable/equatable.dart';

abstract class IzinDaruratEvent extends Equatable {
  const IzinDaruratEvent();

  @override
  List<Object?> get props => [];
}

class LoadIzinDaruratInitialEvent extends IzinDaruratEvent {
  const LoadIzinDaruratInitialEvent();
}

class ChangeIzinDaruratDateRangeEvent extends IzinDaruratEvent {
  final DateTime startDate;
  final DateTime endDate;

  const ChangeIzinDaruratDateRangeEvent({
    required this.startDate,
    required this.endDate,
  });

  @override
  List<Object?> get props => [startDate, endDate];
}

class ChangeIzinDaruratKategoriEvent extends IzinDaruratEvent {
  final String kategori;

  const ChangeIzinDaruratKategoriEvent(this.kategori);

  @override
  List<Object?> get props => [kategori];
}

class ChangeIzinDaruratAlasanEvent extends IzinDaruratEvent {
  final String alasan;

  const ChangeIzinDaruratAlasanEvent(this.alasan);

  @override
  List<Object?> get props => [alasan];
}

class ChangeIzinDaruratAttachmentEvent extends IzinDaruratEvent {
  final String? attachmentName;

  const ChangeIzinDaruratAttachmentEvent(this.attachmentName);

  @override
  List<Object?> get props => [attachmentName];
}

class SubmitIzinDaruratEvent extends IzinDaruratEvent {
  const SubmitIzinDaruratEvent();
}
