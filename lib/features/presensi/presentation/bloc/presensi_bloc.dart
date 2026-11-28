import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/presensi_data.dart';
import '../../domain/usecases/submit_presensi.dart';
import 'presensi_event.dart';
import 'presensi_state.dart';

class PresensiBloc extends Bloc<PresensiEvent, PresensiState> {
  final GetPresensiStatus getPresensiStatus;
  final SubmitClockIn submitClockIn;
  final SubmitClockOut submitClockOut;

  PresensiBloc({
    required this.getPresensiStatus,
    required this.submitClockIn,
    required this.submitClockOut,
  }) : super(const PresensiInitial()) {
    on<LoadPresensiStatusEvent>(_onLoadStatus);
    on<TogglePresensiTypeEvent>(_onToggleType);
    on<CaptureFacePhotoEvent>(_onCapturePhoto);
    on<SubmitPresensiEvent>(_onSubmitPresensi);
  }

  Future<void> _onLoadStatus(
    LoadPresensiStatusEvent event,
    Emitter<PresensiState> emit,
  ) async {
    emit(const PresensiLoading());
    final result = await getPresensiStatus(requestedType: event.requestedType);
    result.fold(
      (failure) => emit(PresensiError(failure.message)),
      (data) => emit(PresensiLoaded(data: data)),
    );
  }

  Future<void> _onToggleType(
    TogglePresensiTypeEvent event,
    Emitter<PresensiState> emit,
  ) async {
    emit(const PresensiLoading());
    final result = await getPresensiStatus(requestedType: event.type);
    result.fold(
      (failure) => emit(PresensiError(failure.message)),
      (data) => emit(PresensiLoaded(data: data)),
    );
  }

  void _onCapturePhoto(
    CaptureFacePhotoEvent event,
    Emitter<PresensiState> emit,
  ) {
    if (state is! PresensiLoaded) return;
    final currentState = state as PresensiLoaded;

    emit(
      currentState.copyWith(
        data: event.photoPath == null
            ? currentState.data.copyWith(clearCapturedPhoto: true)
            : currentState.data.copyWith(
                capturedPhotoPath: event.photoPath,
                isFaceDetected: true,
                isLivenessOk: true,
              ),
        clearMessages: true,
      ),
    );
  }

  Future<void> _onSubmitPresensi(
    SubmitPresensiEvent event,
    Emitter<PresensiState> emit,
  ) async {
    if (state is! PresensiLoaded) return;
    final currentState = state as PresensiLoaded;

    if (currentState.isSubmitting) return;

    final photoPath = currentState.data.capturedPhotoPath;
    if (photoPath == null || photoPath.isEmpty) return;

    emit(currentState.copyWith(isSubmitting: true, clearMessages: true));

    if (currentState.data.type == PresensiType.clockIn) {
      final result = await submitClockIn(photoPath: photoPath);
      result.fold(
        (failure) => emit(
          currentState.copyWith(
            isSubmitting: false,
            errorMessage: failure.message,
          ),
        ),
        (data) => emit(
          PresensiLoaded(
            data: data,
            isSubmitting: false,
            successMessage:
                'Presensi Kehadiran (Clock-In) berhasil diverifikasi!',
          ),
        ),
      );
    } else {
      final result = await submitClockOut(photoPath: photoPath);
      result.fold(
        (failure) => emit(
          currentState.copyWith(
            isSubmitting: false,
            errorMessage: failure.message,
          ),
        ),
        (data) => emit(
          PresensiLoaded(
            data: data,
            isSubmitting: false,
            successMessage:
                'Presensi Pulang (Clock-Out) berhasil tercatat!',
          ),
        ),
      );
    }
  }
}
