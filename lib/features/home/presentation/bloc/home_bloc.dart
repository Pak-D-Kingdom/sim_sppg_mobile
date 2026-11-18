import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/usecase/usecase.dart';
import '../../domain/usecases/get_home_dashboard.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetHomeDashboard getHomeDashboard;

  HomeBloc({required this.getHomeDashboard}) : super(const HomeInitial()) {
    on<LoadHomeDashboardEvent>(_onLoadHomeDashboard);
    on<RefreshHomeDashboardEvent>(_onRefreshHomeDashboard);
    on<ClockOutAttendanceEvent>(_onClockOutAttendance);
  }

  Future<void> _onLoadHomeDashboard(
    LoadHomeDashboardEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(const HomeLoading());
    final result = await getHomeDashboard(const NoParams());
    result.fold(
      (failure) => emit(HomeError(message: failure.message)),
      (dashboard) => emit(HomeLoaded(dashboard: dashboard)),
    );
  }

  Future<void> _onRefreshHomeDashboard(
    RefreshHomeDashboardEvent event,
    Emitter<HomeState> emit,
  ) async {
    final result = await getHomeDashboard(const NoParams());
    result.fold(
      (failure) => emit(HomeError(message: failure.message)),
      (dashboard) => emit(HomeLoaded(dashboard: dashboard)),
    );
  }

  void _onClockOutAttendance(
    ClockOutAttendanceEvent event,
    Emitter<HomeState> emit,
  ) {
    final currentState = state;
    if (currentState is HomeLoaded) {
      final updatedAttendance = currentState.dashboard.todayAttendance.copyWith(
        clockOutTime: event.clockOutTime,
        clockOutStatus: 'Shift Selesai',
        statusText: 'Selesai\nBertugas',
        isClockedOut: true,
      );
      emit(
        HomeLoaded(
          dashboard: currentState.dashboard.copyWith(
            todayAttendance: updatedAttendance,
          ),
        ),
      );
    }
  }
}
