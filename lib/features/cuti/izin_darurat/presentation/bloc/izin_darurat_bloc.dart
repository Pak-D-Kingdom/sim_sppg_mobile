import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/izin_darurat_entity.dart';
import '../../domain/usecases/submit_izin_darurat.dart';
import 'izin_darurat_event.dart';
import 'izin_darurat_state.dart';

class IzinDaruratBloc extends Bloc<IzinDaruratEvent, IzinDaruratState> {
  final GetInitialIzinDarurat getInitialIzinDarurat;
  final SubmitIzinDarurat submitIzinDarurat;

  IzinDaruratBloc({
    required this.getInitialIzinDarurat,
    required this.submitIzinDarurat,
  }) : super(const IzinDaruratInitial()) {
    on<LoadIzinDaruratInitialEvent>(_onLoadInitial);
    on<ChangeIzinDaruratJenisEvent>(_onChangeJenis);
    on<ChangeIzinDaruratDateRangeEvent>(_onChangeDateRange);
    on<ChangeIzinDaruratTimeEvent>(_onChangeTime);
    on<ChangeIzinDaruratKategoriEvent>(_onChangeKategori);
    on<ChangeIzinDaruratAlasanEvent>(_onChangeAlasan);
    on<ChangeIzinDaruratAttachmentEvent>(_onChangeAttachment);
    on<SubmitIzinDaruratEvent>(_onSubmitIzinDarurat);
  }

  Future<void> _onLoadInitial(
    LoadIzinDaruratInitialEvent event,
    Emitter<IzinDaruratState> emit,
  ) async {
    emit(const IzinDaruratLoading());
    final result = await getInitialIzinDarurat();
    result.fold(
      (failure) => emit(IzinDaruratError(failure.message)),
      (data) => emit(IzinDaruratLoaded(data: data)),
    );
  }

  void _onChangeJenis(
    ChangeIzinDaruratJenisEvent event,
    Emitter<IzinDaruratState> emit,
  ) {
    if (state is! IzinDaruratLoaded) return;
    final currentState = state as IzinDaruratLoaded;

    final isSwitchingToTerlambat = event.jenis == IzinDaruratJenis.terlambat;
    String newKategori = currentState.data.kategori;
    String newAlasan = currentState.data.alasan;

    if (isSwitchingToTerlambat) {
      if (newKategori == 'Keluarga Rawat Darurat') {
        newKategori = 'Kendaraan Mogok';
      }
      if (newAlasan == 'Anggota keluarga inti masuk IGD RSUD pagi ini.') {
        newAlasan = 'Ban motor bocor & rantai putus di jalan menuju dapur.';
      }
    } else {
      if (newKategori == 'Kendaraan Mogok') {
        newKategori = 'Keluarga Rawat Darurat';
      }
      if (newAlasan == 'Ban motor bocor & rantai putus di jalan menuju dapur.') {
        newAlasan = 'Anggota keluarga inti masuk IGD RSUD pagi ini.';
      }
    }

    final updatedData = currentState.data.copyWith(
      jenis: event.jenis,
      kategori: newKategori,
      alasan: newAlasan,
    );
    emit(currentState.copyWith(data: updatedData, clearMessages: true));
  }

  void _onChangeDateRange(
    ChangeIzinDaruratDateRangeEvent event,
    Emitter<IzinDaruratState> emit,
  ) {
    if (state is! IzinDaruratLoaded) return;
    final currentState = state as IzinDaruratLoaded;

    final duration = event.endDate.difference(event.startDate).inDays + 1;
    final updatedData = currentState.data.copyWith(
      startDate: event.startDate,
      endDate: event.endDate,
      durationDays: duration > 0 ? duration : 1,
    );

    emit(currentState.copyWith(data: updatedData, clearMessages: true));
  }

  void _onChangeTime(
    ChangeIzinDaruratTimeEvent event,
    Emitter<IzinDaruratState> emit,
  ) {
    if (state is! IzinDaruratLoaded) return;
    final currentState = state as IzinDaruratLoaded;

    final updatedData = currentState.data.copyWith(
      jamTiba: event.jamTiba,
      menitTerlambat: event.menitTerlambat,
    );
    emit(currentState.copyWith(data: updatedData, clearMessages: true));
  }

  void _onChangeKategori(
    ChangeIzinDaruratKategoriEvent event,
    Emitter<IzinDaruratState> emit,
  ) {
    if (state is! IzinDaruratLoaded) return;
    final currentState = state as IzinDaruratLoaded;

    final updatedData = currentState.data.copyWith(kategori: event.kategori);
    emit(currentState.copyWith(data: updatedData, clearMessages: true));
  }

  void _onChangeAlasan(
    ChangeIzinDaruratAlasanEvent event,
    Emitter<IzinDaruratState> emit,
  ) {
    if (state is! IzinDaruratLoaded) return;
    final currentState = state as IzinDaruratLoaded;

    final updatedData = currentState.data.copyWith(alasan: event.alasan);
    emit(currentState.copyWith(data: updatedData, clearMessages: true));
  }

  void _onChangeAttachment(
    ChangeIzinDaruratAttachmentEvent event,
    Emitter<IzinDaruratState> emit,
  ) {
    if (state is! IzinDaruratLoaded) return;
    final currentState = state as IzinDaruratLoaded;

    final updatedData = currentState.data.copyWith(
      attachmentName: event.attachmentName,
      clearAttachment: event.attachmentName == null,
    );
    emit(currentState.copyWith(data: updatedData, clearMessages: true));
  }

  Future<void> _onSubmitIzinDarurat(
    SubmitIzinDaruratEvent event,
    Emitter<IzinDaruratState> emit,
  ) async {
    if (state is! IzinDaruratLoaded) return;
    final currentState = state as IzinDaruratLoaded;

    if (currentState.data.isSubmitting) return;

    emit(
      currentState.copyWith(
        data: currentState.data.copyWith(isSubmitting: true),
        clearMessages: true,
      ),
    );

    final result = await submitIzinDarurat(
      SubmitIzinDaruratParams(
        startDate: currentState.data.startDate,
        endDate: currentState.data.endDate,
        durationDays: currentState.data.durationDays,
        kategori: currentState.data.kategori,
        alasan: currentState.data.alasan,
        attachmentName: currentState.data.attachmentName,
      ),
    );

    result.fold(
      (failure) => emit(
        currentState.copyWith(
          data: currentState.data.copyWith(isSubmitting: false),
          errorMessage: failure.message,
        ),
      ),
      (data) => emit(
        IzinDaruratLoaded(
          data: data.copyWith(isSubmitting: false),
          successMessage: currentState.data.jenis == IzinDaruratJenis.terlambat
              ? 'Laporan izin terlambat berhasil dikirim ke KSPPG!'
              : 'Laporan izin darurat berhasil dikirim ke KSPPG!',
        ),
      ),
    );
  }
}
