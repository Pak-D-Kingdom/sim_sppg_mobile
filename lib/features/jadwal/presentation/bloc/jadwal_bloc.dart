import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/jadwal_day.dart';
import '../../domain/usecases/get_jadwal.dart';
import 'jadwal_event.dart';
import 'jadwal_state.dart';

class JadwalBloc extends Bloc<JadwalEvent, JadwalState> {
  final GetJadwal getJadwal;

  JadwalBloc({required this.getJadwal}) : super(const JadwalInitial()) {
    on<LoadJadwalEvent>(_onLoadJadwal);
    on<SelectJadwalDateEvent>(_onSelectJadwalDate);
    on<ChangeMonthEvent>(_onChangeMonth);
  }

  Future<void> _onLoadJadwal(
    LoadJadwalEvent event,
    Emitter<JadwalState> emit,
  ) async {
    emit(const JadwalLoading());
    final month = event.month ?? 11;
    final year = event.year ?? 2026;

    final result = await getJadwal(GetJadwalParams(month: month, year: year));
    result.fold(
      (failure) => emit(JadwalError(message: failure.message)),
      (data) {
        // Default select 23 Nov 2026 to match the UI screenshot
        DateTime targetDate = DateTime(year, month, 23);
        JadwalDay? matchingDay;

        for (final d in data.days) {
          if (d.date.year == targetDate.year &&
              d.date.month == targetDate.month &&
              d.date.day == targetDate.day) {
            matchingDay = d;
            break;
          }
        }

        if (matchingDay == null && data.days.isNotEmpty) {
          matchingDay = data.days.first;
          targetDate = matchingDay.date;
        }

        if (matchingDay != null) {
          emit(
            JadwalLoaded(
              data: data,
              selectedDate: targetDate,
              selectedDay: matchingDay,
            ),
          );
        } else {
          emit(const JadwalError(message: 'Data jadwal tidak ditemukan.'));
        }
      },
    );
  }

  void _onSelectJadwalDate(
    SelectJadwalDateEvent event,
    Emitter<JadwalState> emit,
  ) {
    final currentState = state;
    if (currentState is JadwalLoaded) {
      JadwalDay matchingDay = currentState.selectedDay;
      for (final d in currentState.data.days) {
        if (d.date.year == event.date.year &&
            d.date.month == event.date.month &&
            d.date.day == event.date.day) {
          matchingDay = d;
          break;
        }
      }

      emit(
        currentState.copyWith(
          selectedDate: event.date,
          selectedDay: matchingDay,
        ),
      );
    }
  }

  Future<void> _onChangeMonth(
    ChangeMonthEvent event,
    Emitter<JadwalState> emit,
  ) async {
    final currentState = state;
    if (currentState is JadwalLoaded) {
      if (currentState.isCalendarLoading) return;

      int newMonth = currentState.data.currentMonth + event.offset;
      int newYear = currentState.data.currentYear;

      if (newMonth < 1) {
        newMonth = 12;
        newYear -= 1;
      } else if (newMonth > 12) {
        newMonth = 1;
        newYear += 1;
      }

      // Hanya tandai kalender yang sedang me-load, tanpa mereset halaman
      emit(currentState.copyWith(isCalendarLoading: true));

      final result =
          await getJadwal(GetJadwalParams(month: newMonth, year: newYear));
      result.fold(
        (failure) {
          emit(currentState.copyWith(isCalendarLoading: false));
        },
        (data) {
          final targetDay = data.days.isNotEmpty ? data.days.first : null;
          if (targetDay != null) {
            emit(
              JadwalLoaded(
                data: data,
                selectedDate: targetDay.date,
                selectedDay: targetDay,
                isCalendarLoading: false,
              ),
            );
          } else {
            emit(currentState.copyWith(isCalendarLoading: false));
          }
        },
      );
    }
  }
}
