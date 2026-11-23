import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/riwayat_absen_item.dart';
import '../../domain/usecases/get_riwayat_absen.dart';
import 'riwayat_absen_event.dart';
import 'riwayat_absen_state.dart';

class RiwayatAbsenBloc extends Bloc<RiwayatAbsenEvent, RiwayatAbsenState> {
  final GetRiwayatAbsen getRiwayatAbsen;

  RiwayatAbsenBloc({required this.getRiwayatAbsen})
      : super(const RiwayatAbsenInitial()) {
    on<LoadRiwayatAbsenEvent>(_onLoad);
    on<ChangeRiwayatMonthEvent>(_onChangeMonth);
    on<SelectRiwayatFilterEvent>(_onSelectFilter);
    on<ToggleShowAllRiwayatEvent>(_onToggleShowAll);
    on<SubmitKoreksiAbsenEvent>(_onSubmitKoreksi);
  }

  Future<void> _onLoad(
    LoadRiwayatAbsenEvent event,
    Emitter<RiwayatAbsenState> emit,
  ) async {
    emit(const RiwayatAbsenLoading());
    final month = event.month ?? 11;
    final year = event.year ?? 2026;

    final result = await getRiwayatAbsen(
      GetRiwayatAbsenParams(month: month, year: year),
    );

    result.fold(
      (failure) => emit(RiwayatAbsenError(failure.message)),
      (data) => emit(RiwayatAbsenLoaded(data: data)),
    );
  }

  Future<void> _onChangeMonth(
    ChangeRiwayatMonthEvent event,
    Emitter<RiwayatAbsenState> emit,
  ) async {
    final currentState = state;
    if (currentState is! RiwayatAbsenLoaded) return;

    int newMonth = currentState.data.month + event.offset;
    int newYear = currentState.data.year;

    if (newMonth < 1) {
      newMonth = 12;
      newYear -= 1;
    } else if (newMonth > 12) {
      newMonth = 1;
      newYear += 1;
    }

    final result = await getRiwayatAbsen(
      GetRiwayatAbsenParams(month: newMonth, year: newYear),
    );

    result.fold(
      (failure) => emit(RiwayatAbsenError(failure.message)),
      (data) => emit(
        RiwayatAbsenLoaded(
          data: data,
          selectedFilter: RiwayatFilterType.semua,
          showAll: false,
        ),
      ),
    );
  }

  void _onSelectFilter(
    SelectRiwayatFilterEvent event,
    Emitter<RiwayatAbsenState> emit,
  ) {
    final currentState = state;
    if (currentState is! RiwayatAbsenLoaded) return;

    emit(
      currentState.copyWith(
        selectedFilter: event.filter,
        showAll: false,
        clearFeedback: true,
      ),
    );
  }

  void _onToggleShowAll(
    ToggleShowAllRiwayatEvent event,
    Emitter<RiwayatAbsenState> emit,
  ) {
    final currentState = state;
    if (currentState is! RiwayatAbsenLoaded) return;

    emit(
      currentState.copyWith(
        showAll: !currentState.showAll,
        clearFeedback: true,
      ),
    );
  }

  void _onSubmitKoreksi(
    SubmitKoreksiAbsenEvent event,
    Emitter<RiwayatAbsenState> emit,
  ) {
    final currentState = state;
    if (currentState is! RiwayatAbsenLoaded) return;

    final updatedItems = currentState.data.items.map((item) {
      if (item.id == event.itemId) {
        return item.copyWith(
          canRequestCorrection: false,
          correctionSubmitted: true,
        );
      }
      return item;
    }).toList();

    emit(
      currentState.copyWith(
        data: currentState.data.copyWith(
          items: updatedItems,
          menungguCount: currentState.data.menungguCount + 1,
        ),
        feedbackMessage: 'Pengajuan koreksi absensi berhasil dikirim.',
      ),
    );
  }
}
