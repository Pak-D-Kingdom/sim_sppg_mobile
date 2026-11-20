import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/usecase/usecase.dart';
import '../../domain/entities/cuti_form_data.dart';
import '../../domain/entities/cuti_type.dart';
import '../../domain/usecases/get_cuti_quota.dart';
import '../../domain/usecases/submit_cuti.dart';
import 'cuti_event.dart';
import 'cuti_state.dart';

class CutiBloc extends Bloc<CutiEvent, CutiState> {
  final GetCutiQuota getCutiQuota;
  final SubmitCuti submitCuti;

  CutiBloc({
    required this.getCutiQuota,
    required this.submitCuti,
  }) : super(const CutiInitial()) {
    on<LoadCutiInitialEvent>(_onLoadCutiInitial);
    on<ChangeCutiTypeEvent>(_onChangeCutiType);
    on<UpdateCutiDatesEvent>(_onUpdateCutiDates);
    on<UpdateCutiReasonEvent>(_onUpdateCutiReason);
    on<UpdateCutiAttachmentEvent>(_onUpdateCutiAttachment);
    on<SubmitCutiFormEvent>(_onSubmitCutiForm);
  }

  // Calculate working days (Mon-Fri) between start and end dates inclusive
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

  Future<void> _onLoadCutiInitial(
    LoadCutiInitialEvent event,
    Emitter<CutiState> emit,
  ) async {
    emit(const CutiLoading());
    final result = await getCutiQuota(const NoParams());

    result.fold(
      (failure) => emit(CutiError(message: failure.message)),
      (quota) {
        // Default initial dates matching the reference design: 01 Des 2026 s/d 02 Des 2026
        final initialStart = DateTime(2026, 12, 1);
        final initialEnd = DateTime(2026, 12, 2);
        final duration = _calculateWorkingDays(initialStart, initialEnd);
        final remaining = (quota.remainingQuota - duration).clamp(0, 100);

        emit(
          CutiLoaded(
            quota: quota,
            selectedType: CutiType.cutiTahunan,
            startDate: initialStart,
            endDate: initialEnd,
            durationDays: duration,
            remainingAfter: remaining,
            reason: 'Menghadiri acara keluarga di luar kota.',
          ),
        );
      },
    );
  }

  void _onChangeCutiType(
    ChangeCutiTypeEvent event,
    Emitter<CutiState> emit,
  ) {
    final currentState = state;
    if (currentState is CutiLoaded) {
      int remainingAfter;
      if (event.cutiType == CutiType.cutiTahunan) {
        remainingAfter =
            (currentState.quota.remainingQuota - currentState.durationDays)
                .clamp(0, 100);
      } else {
        // Izin Sakit & Izin Darurat do not reduce annual leave quota
        remainingAfter = currentState.quota.remainingQuota;
      }

      emit(
        currentState.copyWith(
          selectedType: event.cutiType,
          remainingAfter: remainingAfter,
          clearMessages: true,
        ),
      );
    }
  }

  void _onUpdateCutiDates(
    UpdateCutiDatesEvent event,
    Emitter<CutiState> emit,
  ) {
    final currentState = state;
    if (currentState is CutiLoaded) {
      final newStart = event.startDate ?? currentState.startDate;
      DateTime newEnd = event.endDate ?? currentState.endDate;

      if (newEnd.isBefore(newStart)) {
        newEnd = newStart;
      }

      final duration = _calculateWorkingDays(newStart, newEnd);
      int remainingAfter;

      if (currentState.selectedType == CutiType.cutiTahunan) {
        remainingAfter =
            (currentState.quota.remainingQuota - duration).clamp(0, 100);
      } else {
        remainingAfter = currentState.quota.remainingQuota;
      }

      emit(
        currentState.copyWith(
          startDate: newStart,
          endDate: newEnd,
          durationDays: duration,
          remainingAfter: remainingAfter,
          clearMessages: true,
        ),
      );
    }
  }

  void _onUpdateCutiReason(
    UpdateCutiReasonEvent event,
    Emitter<CutiState> emit,
  ) {
    final currentState = state;
    if (currentState is CutiLoaded) {
      emit(
        currentState.copyWith(
          reason: event.reason,
          clearMessages: true,
        ),
      );
    }
  }

  void _onUpdateCutiAttachment(
    UpdateCutiAttachmentEvent event,
    Emitter<CutiState> emit,
  ) {
    final currentState = state;
    if (currentState is CutiLoaded) {
      emit(
        currentState.copyWith(
          attachmentName: event.attachmentName,
          clearAttachment: event.attachmentName == null,
          clearMessages: true,
        ),
      );
    }
  }

  Future<void> _onSubmitCutiForm(
    SubmitCutiFormEvent event,
    Emitter<CutiState> emit,
  ) async {
    final currentState = state;
    if (currentState is CutiLoaded) {
      if (currentState.reason.trim().isEmpty) {
        emit(currentState.copyWith(errorMessage: 'Alasan atau keterangan wajib diisi.'));
        return;
      }

      emit(currentState.copyWith(isSubmitting: true, clearMessages: true));

      final formData = CutiFormData(
        cutiType: currentState.selectedType,
        startDate: currentState.startDate,
        endDate: currentState.endDate,
        durationDays: currentState.durationDays,
        remainingAfterSubmission: currentState.remainingAfter,
        reason: currentState.reason,
        attachmentName: currentState.attachmentName,
      );

      final result = await submitCuti(formData);

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
