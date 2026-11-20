import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/izin_sakit_entity.dart';
import '../../domain/usecases/submit_bukti_sakit.dart';
import '../../domain/usecases/submit_laporan_sakit.dart';
import 'izin_sakit_event.dart';
import 'izin_sakit_state.dart';

class IzinSakitBloc extends Bloc<IzinSakitEvent, IzinSakitState> {
  final SubmitLaporanSakit submitLaporanSakit;
  final SubmitBuktiSakit submitBuktiSakit;

  IzinSakitBloc({
    required this.submitLaporanSakit,
    required this.submitBuktiSakit,
  }) : super(const IzinSakitInitial()) {
    on<LoadIzinSakitInitialEvent>(_onLoadInitial);
    on<UpdateIzinSakitDatesEvent>(_onUpdateDates);
    on<UpdateIzinSakitKeluhanEvent>(_onUpdateKeluhan);
    on<SubmitLaporanSakitEvent>(_onSubmitLaporanSakit);
    on<PickBuktiSakitEvent>(_onPickBuktiSakit);
    on<RemoveBuktiSakitEvent>(_onRemoveBuktiSakit);
    on<SubmitBuktiSakitEvent>(_onSubmitBuktiSakit);
  }

  int _calculateDays(DateTime start, DateTime end) {
    if (end.isBefore(start)) return 1;
    final diff = end.difference(start).inDays + 1;
    return diff > 0 ? diff : 1;
  }

  void _onLoadInitial(
    LoadIzinSakitInitialEvent event,
    Emitter<IzinSakitState> emit,
  ) {
    // Default initial dates matching Gambar 1: 20 Nov 2026 s/d 20 Nov 2026
    emit(
      IzinSakitLoaded(
        data: IzinSakitData(
          tahap: IzinSakitTahap.tahap1Form,
          startDate: DateTime(2026, 11, 20),
          endDate: DateTime(2026, 11, 20),
          durationDays: 1,
          keluhan: 'Demam tinggi dan pusing sejak subuh.',
        ),
      ),
    );
  }

  void _onUpdateDates(
    UpdateIzinSakitDatesEvent event,
    Emitter<IzinSakitState> emit,
  ) {
    final currentState = state;
    if (currentState is IzinSakitLoaded) {
      final newStart = event.startDate ?? currentState.data.startDate;
      DateTime newEnd = event.endDate ?? currentState.data.endDate;
      if (newEnd.isBefore(newStart)) newEnd = newStart;

      final duration = _calculateDays(newStart, newEnd);
      emit(
        currentState.copyWith(
          data: currentState.data.copyWith(
            startDate: newStart,
            endDate: newEnd,
            durationDays: duration,
          ),
          clearMessages: true,
        ),
      );
    }
  }

  void _onUpdateKeluhan(
    UpdateIzinSakitKeluhanEvent event,
    Emitter<IzinSakitState> emit,
  ) {
    final currentState = state;
    if (currentState is IzinSakitLoaded) {
      emit(
        currentState.copyWith(
          data: currentState.data.copyWith(keluhan: event.keluhan),
          clearMessages: true,
        ),
      );
    }
  }

  Future<void> _onSubmitLaporanSakit(
    SubmitLaporanSakitEvent event,
    Emitter<IzinSakitState> emit,
  ) async {
    final currentState = state;
    if (currentState is IzinSakitLoaded) {
      if (currentState.data.keluhan.trim().isEmpty) {
        emit(currentState.copyWith(errorMessage: 'Alasan / keluhan sakit wajib diisi.'));
        return;
      }

      emit(currentState.copyWith(
        data: currentState.data.copyWith(isSubmitting: true),
        clearMessages: true,
      ));

      final result = await submitLaporanSakit(
        SubmitLaporanSakitParams(
          startDate: currentState.data.startDate,
          endDate: currentState.data.endDate,
          durationDays: currentState.data.durationDays,
          keluhan: currentState.data.keluhan,
        ),
      );

      result.fold(
        (failure) => emit(
          currentState.copyWith(
            data: currentState.data.copyWith(isSubmitting: false),
            errorMessage: failure.message,
          ),
        ),
        (updatedData) {
          // Transition to Tahap 2 (Gambar 2)
          emit(
            currentState.copyWith(
              data: updatedData.copyWith(isSubmitting: false),
              successMessage: 'Laporan sakit awal berhasil dikirim ke KSPPG.',
            ),
          );
        },
      );
    }
  }

  void _onPickBuktiSakit(
    PickBuktiSakitEvent event,
    Emitter<IzinSakitState> emit,
  ) {
    final currentState = state;
    if (currentState is IzinSakitLoaded) {
      emit(
        currentState.copyWith(
          data: currentState.data.copyWith(attachmentName: event.attachmentName),
          clearMessages: true,
        ),
      );
    }
  }

  void _onRemoveBuktiSakit(
    RemoveBuktiSakitEvent event,
    Emitter<IzinSakitState> emit,
  ) {
    final currentState = state;
    if (currentState is IzinSakitLoaded) {
      emit(
        currentState.copyWith(
          data: currentState.data.copyWith(clearAttachment: true),
          clearMessages: true,
        ),
      );
    }
  }

  Future<void> _onSubmitBuktiSakit(
    SubmitBuktiSakitEvent event,
    Emitter<IzinSakitState> emit,
  ) async {
    final currentState = state;
    if (currentState is IzinSakitLoaded) {
      if (currentState.data.attachmentName == null) {
        emit(currentState.copyWith(errorMessage: 'Silakan pilih foto atau dokumen surat sakit.'));
        return;
      }

      emit(currentState.copyWith(
        data: currentState.data.copyWith(isSubmitting: true),
        clearMessages: true,
      ));

      final result = await submitBuktiSakit(currentState.data.attachmentName!);

      result.fold(
        (failure) => emit(
          currentState.copyWith(
            data: currentState.data.copyWith(isSubmitting: false),
            errorMessage: failure.message,
          ),
        ),
        (updatedData) => emit(
          currentState.copyWith(
            data: updatedData.copyWith(isSubmitting: false),
            successMessage: 'Bukti surat sakit berhasil dikirimkan ke KSPPG.',
          ),
        ),
      );
    }
  }
}
