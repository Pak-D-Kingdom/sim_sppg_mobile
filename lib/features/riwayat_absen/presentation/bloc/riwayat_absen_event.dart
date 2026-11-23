import 'package:equatable/equatable.dart';
import '../../domain/entities/riwayat_absen_item.dart';

abstract class RiwayatAbsenEvent extends Equatable {
  const RiwayatAbsenEvent();

  @override
  List<Object?> get props => [];
}

class LoadRiwayatAbsenEvent extends RiwayatAbsenEvent {
  final int? month;
  final int? year;

  const LoadRiwayatAbsenEvent({this.month, this.year});

  @override
  List<Object?> get props => [month, year];
}

class ChangeRiwayatMonthEvent extends RiwayatAbsenEvent {
  final int offset;

  const ChangeRiwayatMonthEvent(this.offset);

  @override
  List<Object?> get props => [offset];
}

class SelectRiwayatFilterEvent extends RiwayatAbsenEvent {
  final RiwayatFilterType filter;

  const SelectRiwayatFilterEvent(this.filter);

  @override
  List<Object?> get props => [filter];
}

class ToggleShowAllRiwayatEvent extends RiwayatAbsenEvent {
  const ToggleShowAllRiwayatEvent();
}

class SubmitKoreksiAbsenEvent extends RiwayatAbsenEvent {
  final String itemId;
  final String reason;

  const SubmitKoreksiAbsenEvent({
    required this.itemId,
    required this.reason,
  });

  @override
  List<Object?> get props => [itemId, reason];
}
