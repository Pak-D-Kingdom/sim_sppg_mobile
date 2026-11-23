import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_payroll_data.dart';
import 'payroll_event.dart';
import 'payroll_state.dart';

class PayrollBloc extends Bloc<PayrollEvent, PayrollState> {
  final GetPayrollData getPayrollData;

  PayrollBloc({required this.getPayrollData}) : super(const PayrollInitial()) {
    on<LoadPayrollEvent>(_onLoadPayroll);
    on<ChangePayrollYearEvent>(_onChangeYear);
    on<TogglePayrollItemExpandEvent>(_onToggleItemExpand);
  }

  Future<void> _onLoadPayroll(
    LoadPayrollEvent event,
    Emitter<PayrollState> emit,
  ) async {
    emit(const PayrollLoading());
    final result = await getPayrollData(year: event.year);
    result.fold(
      (failure) => emit(PayrollError(failure.message)),
      (data) => emit(
        PayrollLoaded(
          data: data,
          expandedItemIds: const {},
        ),
      ),
    );
  }

  Future<void> _onChangeYear(
    ChangePayrollYearEvent event,
    Emitter<PayrollState> emit,
  ) async {
    emit(const PayrollLoading());
    final result = await getPayrollData(year: event.year);
    result.fold(
      (failure) => emit(PayrollError(failure.message)),
      (data) => emit(
        PayrollLoaded(
          data: data,
          expandedItemIds: const {},
        ),
      ),
    );
  }

  void _onToggleItemExpand(
    TogglePayrollItemExpandEvent event,
    Emitter<PayrollState> emit,
  ) {
    if (state is! PayrollLoaded) return;
    final currentState = state as PayrollLoaded;

    final updatedSet = Set<String>.from(currentState.expandedItemIds);
    if (updatedSet.contains(event.itemId)) {
      updatedSet.remove(event.itemId);
    } else {
      updatedSet.add(event.itemId);
    }

    emit(currentState.copyWith(expandedItemIds: updatedSet));
  }
}
