import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/cuti_tahunan_entity.dart';
import '../../domain/usecases/cuti_tahunan_usecases.dart';
import 'cuti_tahunan_event.dart';
import 'cuti_tahunan_state.dart';

class CutiTahunanBloc extends Bloc<CutiTahunanEvent, CutiTahunanState> {
  final GetCutiTahunanQuota getQuota;
  final SubmitCutiTahunan submitCuti;

  CutiTahunanBloc({
    required this.getQuota,
    required this.submitCuti,
  }) : super(const CutiTahunanInitial()) {
    on<LoadCutiTahunanInitialEvent>(_onLoadInitial);
    on<UpdateCutiTahunanDatesEvent>(_onUpdateDates);
    on<UpdateCutiTahunanReasonEvent>(_onUpdateReason);
    on<UpdateCutiTahunanAttachmentEvent>(_onUpdateAttachment);
    on<SubmitCutiTahunanFormEvent>(_onSubmitForm);
  }

  int _calculateWorkingDays(DateTime start, DateTime end) {
    if (end.isBefore(start)) return 0;
    int count = 0;
    DateTime current = DateTime(start.year, start.month, start.day);
    final targetEnd = DateTime(end.year, end.month, end.day);

    while (!current.isAfter(targetEnd)) {
      if (current.weekday != DateTime.saturday &&
          current.weekday != DateTime.sunday) {
        count++;
      }
      current = current.add(const Duration(days: 1));
    }
    return count > 0 ? count : 1;
  }

  Future<void> _onLoadInitial(
    LoadCutiTahunanInitialEvent event,
    Emitter<CutiTahunanState> emit,
  ) async {
    emit(const CutiTahunanLoading());
    final result = await getQuota();
    result.fold(
      (failure) => emit(CutiTahunanError(failure.message)),
      (quota) {
        final start = DateTime(2026, 12, 1);
        final end = DateTime(2026, 12, 2);
        final duration = _calculateWorkingDays(start, end);
        final remaining = (quota.remainingQuota - duration).clamp(0, 100);

        emit(
          CutiTahunanLoaded(
            quota: quota,
            formData: CutiTahunanFormData(
              startDate: start,
              endDate: end,
              durationDays: duration,
              remainingAfter: remaining,
              reason: 'Menghadiri acara keluarga di luar kota.',
            ),
          ),
        );
      },
    );
  }

  void _onUpdateDates(
    UpdateCutiTahunanDatesEvent event,
    Emitter<CutiTahunanState> emit,
  ) {
    final currentState = state;
    if (currentState is CutiTahunanLoaded) {
      final newStart = event.startDate ?? currentState.formData.startDate;
      DateTime newEnd = event.endDate ?? currentState.formData.endDate;
      if (newEnd.isBefore(newStart)) newEnd = newStart;

      final duration = _calculateWorkingDays(newStart, newEnd);
      final remaining =
          (currentState.quota.remainingQuota - duration).clamp(0, 100);

      emit(
        currentState.copyWith(
          formData: currentState.formData.copyWith(
            startDate: newStart,
            endDate: newEnd,
            durationDays: duration,
            remainingAfter: remaining,
          ),
          clearMessages: true,
        ),
      );
    }
  }

  void _onUpdateReason(
    UpdateCutiTahunanReasonEvent event,
    Emitter<CutiTahunanState> emit,
  ) {
    final currentState = state;
    if (currentState is CutiTahunanLoaded) {
      emit(
        currentState.copyWith(
          formData: currentState.formData.copyWith(reason: event.reason),
          clearMessages: true,
        ),
      );
    }
  }

  void _onUpdateAttachment(
    UpdateCutiTahunanAttachmentEvent event,
    Emitter<CutiTahunanState> emit,
  ) {
    final currentState = state;
    if (currentState is CutiTahunanLoaded) {
      emit(
        currentState.copyWith(
          formData: currentState.formData.copyWith(
            attachmentName: event.attachmentName,
            clearAttachment: event.attachmentName == null,
          ),
          clearMessages: true,
        ),
      );
    }
  }

  Future<void> _onSubmitForm(
    SubmitCutiTahunanFormEvent event,
    Emitter<CutiTahunanState> emit,
  ) async {
    final currentState = state;
    if (currentState is CutiTahunanLoaded) {
      if (currentState.formData.reason.trim().isEmpty) {
        emit(currentState.copyWith(errorMessage: 'Alasan atau keterangan cuti wajib diisi.'));
        return;
      }

      emit(currentState.copyWith(isSubmitting: true, clearMessages: true));

      final result = await submitCuti(currentState.formData);
      result.fold(
        (failure) => emit(
          currentState.copyWith(
            isSubmitting: false,
            errorMessage: failure.message,
          ),
        ),
        (msg) => emit(
          currentState.copyWith(
            isSubmitting: false,
            successMessage: msg,
          ),
        ),
      );
    }
  }
}
