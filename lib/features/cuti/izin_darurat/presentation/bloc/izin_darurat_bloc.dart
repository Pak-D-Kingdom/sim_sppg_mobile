import 'package:flutter_bloc/flutter_bloc.dart';
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
    on<ChangeIzinDaruratDateRangeEvent>(_onChangeDateRange);
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
          successMessage: 'Laporan izin darurat berhasil dikirim ke KSPPG!',
        ),
      ),
    );
  }
}
