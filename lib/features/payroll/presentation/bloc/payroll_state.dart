import 'package:equatable/equatable.dart';
import '../../domain/entities/payroll_data.dart';

abstract class PayrollState extends Equatable {
  const PayrollState();

  @override
  List<Object?> get props => [];
}

class PayrollInitial extends PayrollState {
  const PayrollInitial();
}

class PayrollLoading extends PayrollState {
  const PayrollLoading();
}

class PayrollLoaded extends PayrollState {
  final PayrollData data;
  final Set<String> expandedItemIds;

  const PayrollLoaded({
    required this.data,
    this.expandedItemIds = const {},
  });

  bool isExpanded(String id) => expandedItemIds.contains(id);

  PayrollLoaded copyWith({
    PayrollData? data,
    Set<String>? expandedItemIds,
  }) {
    return PayrollLoaded(
      data: data ?? this.data,
      expandedItemIds: expandedItemIds ?? this.expandedItemIds,
    );
  }

  @override
  List<Object?> get props => [data, expandedItemIds];
}

class PayrollError extends PayrollState {
  final String message;

  const PayrollError(this.message);

  @override
  List<Object?> get props => [message];
}
